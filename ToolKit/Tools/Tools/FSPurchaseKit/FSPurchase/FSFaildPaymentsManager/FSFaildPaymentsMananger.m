//
//  FSFaildPaymentsMananger.m
//  FSPurchase
//
//  Created by Charles on 2017/11/2.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSFaildPaymentsMananger.h"
#import "FSPaymentCache.h"
#import "FSPurchaseConfiger.h"
#import "FSRecipetManager.h"

@interface FSFaildPaymentsMananger ()
{
    dispatch_queue_t _CheckPurcheseThread;
    BOOL _shouldStop;
    BOOL _IncheckIng;
}
@property(nonatomic,strong)FSRecipetManager *recipetManager;
@end
@implementation FSFaildPaymentsMananger
- (FSRecipetManager *)recipetManager {
    if (!_recipetManager) {
        _recipetManager = [FSRecipetManager defaultManager];
    }
    return _recipetManager;
}
- (void)checkPayments {
    if (_shouldStop) {
        _IncheckIng = NO;
        return;
    }
    
    if (_IncheckIng) {
        return;
    }
    
    _IncheckIng = YES;
    [[FSPaymentCache sharedCache] willCheckedPayment:^(FSPayment *payment) {
        dispatch_async(_CheckPurcheseThread, ^{
            if (payment != nil) {
                //
                [self verifyPaymentTraction:payment];
            }else{
                _IncheckIng = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkPayments) object:nil];
                    [self performSelector:@selector(checkPayments) withObject:nil afterDelay:[FSPurchaseConfiger sharedConfiger].localCheckInterval];
                });
            }
        });
    }];
}

- (void)verifyPaymentTraction:(FSPayment *)payment {
    if (self.verifyManager != nil && [self.verifyManager respondsToSelector:@selector(paymentVerify:successBlock:faildBlock:)]) {
        [self.verifyManager paymentVerify:payment successBlock:^(FSPayment *payment, NSDictionary *dataInfo) {
            _IncheckIng = NO;

            NSInteger code = [[dataInfo valueForKey:@"code"] integerValue];
            //
            if (code == SuccessCode || code == RepeatSuccessCode) {
                [[FSPaymentCache sharedCache] removePaymentsFromCache:payment completion:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkPayments) object:nil];
                        [self performSelector:@selector(checkPayments) withObject:nil afterDelay:[FSPurchaseConfiger sharedConfiger].localCheckInterval];
                    });
                }];
            }
        } faildBlock:^(FSPayment *payment,NSInteger code,NSError *error) {
            _IncheckIng = NO;

            if (FaildByBlankRecipet == code){
                [self.recipetManager refreshRecipetSuccess:^{
                    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkPayments) object:nil];
                    [self performSelector:@selector(checkPayments) withObject:nil afterDelay:[FSPurchaseConfiger sharedConfiger].localCheckInterval];
                } faild:^{
                    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkPayments) object:nil];
                    [self performSelector:@selector(checkPayments) withObject:nil afterDelay:[FSPurchaseConfiger sharedConfiger].localCheckInterval];
                }];
            }else{
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkPayments) object:nil];
                [self performSelector:@selector(checkPayments) withObject:nil afterDelay:[FSPurchaseConfiger sharedConfiger].localCheckInterval];
            }
        }];
    }else{
        _IncheckIng = NO;
        NSLog(@"没有书写本地验证的地址");
    }
}

- (void)startFaildVerify {
    
    _shouldStop = NO;
    
    if (_IncheckIng) {
        return;
    }
    
    [self checkPayments];
}

- (void)stopFaildVerify {
    
    _shouldStop = YES;
}

#pragma mark - init
static id faildPaymetManager;
+ (instancetype)sharedManager {
    return [[FSFaildPaymentsMananger alloc] init];
}
- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((faildPaymetManager = [super init]) != nil) {
            _CheckPurcheseThread = dispatch_queue_create("com.fissions.checkPaymentss", DISPATCH_QUEUE_SERIAL);
            _shouldStop = NO;
            _IncheckIng = NO;
        }
    });
    self = faildPaymetManager;
    return self;
}
+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        faildPaymetManager = [super allocWithZone:zone];
    });
    return faildPaymetManager;
}
+ (id)copyWithZone:(struct _NSZone *)zone {
    return faildPaymetManager;
}
@end
