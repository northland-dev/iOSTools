//
//  FSPaymentManager.m
//  FSPurchase
//
//  Created by Fission on 2/11/2017.
//  Copyright © 2017 Fission. All rights reserved.
//

#import "FSPaymentManager.h"
#import "FSPaymentCache.h"
#import "FSPurchaseConfiger.h"
#import "FSFaildPaymentsMananger.h"
#import "FSRecipetManager.h"
#import <Adjust/Adjust.h>

@interface FSPaymentManager()<SKPaymentTransactionObserver,SKRequestDelegate>
{
    NSInteger _tryCount;
}
@property(nonatomic,strong)FaildBlock faildBlock;
@property(nonatomic,strong)SuccessBlock successBlock;
@property(nonatomic,strong)FSExtraParam *extra;
@property(nonatomic,strong)FSRecipetManager *recipetManager;
@end
@implementation FSPaymentManager
- (FSRecipetManager *)recipetManager {
    if (!_recipetManager) {
        _recipetManager = [FSRecipetManager defaultManager];
    }
    return _recipetManager;
}
- (void)startAutoVerify {
    
}

- (void)managerPurchase:(SKProduct *)product
                  extra:(FSExtraParam *)extra
           successBlock:(SuccessBlock)success
             faildBlock:(FaildBlock)faild {
    
    [[FSFaildPaymentsMananger sharedManager] stopFaildVerify];
    _successBlock = success;
    _faildBlock = faild;
    _tryCount = 0;
    _extra = extra;
    
    if (![SKPaymentQueue canMakePayments]) {
        // 不能创建订单
        if(faild){
            faild(nil,-2,nil);
        }
        return;
    }
    
    NSArray *trs = [[SKPaymentQueue defaultQueue] transactions];
    NSMutableArray *willFinishedArray = [NSMutableArray array];
    for (SKPaymentTransaction *transaction in trs) {
        if ([transaction.payment.productIdentifier isEqualToString:product.productIdentifier]) {
            [willFinishedArray addObject:transaction];
        }
    }
    
    for (SKPaymentTransaction *tr in willFinishedArray) {
        // 点击的时候出现的事物都是没有验证的
        if (tr.transactionState == SKPaymentTransactionStatePurchased) {
            [[FSPaymentCache sharedCache] savePaymentTransactionToCache:tr extra:extra completion:^(BOOL cacheSuccess, FSPayment *payment, SKPaymentTransaction *paymentTraction) {
                if (cacheSuccess) {
                    [[SKPaymentQueue defaultQueue] finishTransaction:tr];
                }
            }];
        }else if (tr.transactionState != SKPaymentTransactionStatePurchasing) {
             [[SKPaymentQueue defaultQueue] finishTransaction:tr];
        }
        
    }
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
#ifdef DEBUG
//    [payment setSimulatesAskToBuyInSandbox:YES];
#endif
    [payment setApplicationUsername:[FSPurchaseConfiger sharedConfiger].applicationUserName];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}
#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        if (transaction.transactionState == SKPaymentTransactionStatePurchased || transaction.transactionState == SKPaymentTransactionStateRestored) {
            
            NSString *eventName = [NSString stringWithFormat:@"DataSta_Recharge_Pay_Success"];
            NSDictionary *contentJson = @{@"orderId":transaction.payment.applicationUsername};
            NSDictionary *param = @{@"content":contentJson.mj_JSONString};
            [RyzeMagicStatics ryze_addEventName:eventName withParams:param];
            
            if(self.pricesOfProducts != nil){
                ADJEvent *event = [ADJEvent eventWithEventToken:@"ugfxmu"];
                SKProduct *product = [self.pricesOfProducts objectForKey:transaction.payment.productIdentifier];
                if (product != nil) {
                    [event setRevenue:product.price.doubleValue currency:@"USD"];
                    [event setTransactionId:transaction.transactionIdentifier];
                    [Adjust trackEvent:event];
                }
            }

            [[FSPaymentCache sharedCache] savePaymentTransactionToCache:transaction extra:_extra completion:^(BOOL cacheSuccess, FSPayment *payment, SKPaymentTransaction *paymentTraction)  {
                if (cacheSuccess) {
                    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                    [self verifyPaymentTraction:transaction];
                }else{
                    NSLog(@"cacheSuccess %@",paymentTraction.transactionIdentifier);
                }
            }];
        }else if (transaction.transactionState == SKPaymentTransactionStateFailed){
            if (_faildBlock) {
                // 提示失败了 不能提示处理中 所以不传出transaction
                _faildBlock(nil,-1,transaction.error);
            }
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
        }
    }
}
#pragma mark - verify
- (void)verifyPaymentTraction:(SKPaymentTransaction *)paymentTraction {
    
    [[FSPaymentCache sharedCache] topCheckedPayment:^(FSPayment *payment) {
        if (payment != nil) {
            _tryCount ++;
            if (self.verifyManager != nil && [self.verifyManager respondsToSelector:@selector(paymentVerify:extra:successBlock:faildBlock:)]) {
                [self.verifyManager paymentVerify:paymentTraction extra:payment.extra successBlock:^(FSPayment *payment, NSDictionary *dataInfo) {
                    //
                    NSInteger code = [[dataInfo valueForKey:@"code"] integerValue];
                    //
                    if (SuccessCode == code  || RepeatSuccessCode == code) {
                        NSDictionary *info = [dataInfo valueForKey:@"dataInfo"];
                        [[FSPaymentCache sharedCache] removePaymentsFromCache:payment completion:^{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [[SKPaymentQueue defaultQueue] finishTransaction:paymentTraction];
                                if (self.successBlock) {
                                    self.successBlock(payment, info);
                                }
                            });
                        }];
                    }else if(FaildByBlankRecipet == code){
                        [self.recipetManager refreshRecipetSuccess:^{
                            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(verifyPaymentTraction:) object:paymentTraction];
                            [self performSelector:@selector(verifyPaymentTraction:) withObject:paymentTraction afterDelay:1.0f];
                        } faild:^{
                            if (_tryCount <= _retryTimes) {
                                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(verifyPaymentTraction:) object:paymentTraction];
                                [self performSelector:@selector(verifyPaymentTraction:) withObject:paymentTraction afterDelay:1.0f];
                            }else{
                                if (self.faildBlock) {
                                    self.faildBlock(payment,code,nil);
                                }
                            }
                        }];
                    } else {
                        if (self.faildBlock) {
                            self.faildBlock(payment,code,nil);
                        }
                    }
                } faildBlock:^(FSPayment *payment,NSInteger code,NSError *error) {
                    if (_tryCount <= _retryTimes) {
                        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(verifyPaymentTraction:) object:paymentTraction];
                        [self performSelector:@selector(verifyPaymentTraction:) withObject:paymentTraction afterDelay:1.0f];
                    }else{
                        if (self.faildBlock) {
                            self.faildBlock(payment,-1,error);
                        }
                    }
                }];
            }
        }
    }];
}

#pragma mark - init
- (NSInteger)retryTimes{
    _retryTimes = 3;
    return _retryTimes;
}

static id paymentManager;
+ (instancetype)sharedManager{
    return [[FSPaymentManager alloc] init];
}
- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((paymentManager = [super init]) != nil) {
            [[SKPaymentQueue defaultQueue] addTransactionObserver:paymentManager];
        }
    });
    self = paymentManager;
    return self;
}
+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        paymentManager = [super allocWithZone:zone];
    });
    return paymentManager;
}
+ (id)copyWithZone:(struct _NSZone *)zone {
    return paymentManager;
}
@end
