//
//  FSPaymentCache.m
//  FSPurchase
//
//  Created by Fission on 2/11/2017.
//  Copyright © 2017 Fission. All rights reserved.
//

#import "FSPaymentCache.h"


#define  FSSavedPresistencePayments @"FSSavedPresistencePayments"
#define  FSSavedTransactionPath     [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Transactions.data"]

@interface FSPaymentCache() {
    dispatch_queue_t _readWriteQueue;
}
//
@property(nonatomic,strong)NSMutableDictionary *finishedPayments;
@end

@implementation FSPaymentCache
#pragma mark -
- (NSMutableDictionary *)willCheckedPaymentsQueue {
    if (!_finishedPayments) {
        _finishedPayments = [NSMutableDictionary dictionary];
    }
    return _finishedPayments;
}
//
- (void)savePaymentTransactionToCache:(SKPaymentTransaction *)paymentTransaction
                                extra:(FSExtraParam *)extra
                           completion:(CachePaymentBlock)cacheBlock {
    
    dispatch_async(_readWriteQueue, ^{
        
        // 读取本地列表.

        if ([self.finishedPayments count] == 0) {
            NSMutableArray *localPayments = [NSKeyedUnarchiver unarchiveObjectWithFile:FSSavedTransactionPath];
            for (FSPayment *payment in localPayments) {
                if (payment.transactionId) {
                    [self.finishedPayments setValue:@"haveFinished" forKey:payment.transactionId];
                }
            }
        }
        
        NSString *haveFinished = [self.finishedPayments valueForKey:paymentTransaction.transactionIdentifier];
        if (haveFinished != nil) {
            // 去重
            dispatch_async(dispatch_get_main_queue(), ^{
                if (cacheBlock) {
                    cacheBlock(YES,nil,paymentTransaction);
                }
            });
            
            return;
        }
        
        if (paymentTransaction.transactionIdentifier != nil) {
            [self.finishedPayments setObject:@"HaveFinished" forKey:paymentTransaction.transactionIdentifier];
        }
        
        FSPayment * payment = [FSPayment paymentWithPaymentTraction:paymentTransaction];
        [payment setExtra:extra];
        
        if (payment == nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (cacheBlock) {
                    cacheBlock(YES,payment,paymentTransaction);
                }
            });
            return;
        }
        
        BOOL saved = NO;
        BOOL dealed = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath:FSSavedTransactionPath]) {
            NSMutableArray *loaclPayments = [NSKeyedUnarchiver unarchiveObjectWithFile:FSSavedTransactionPath];
            if (loaclPayments != nil) {
                [loaclPayments addObject:payment];
                saved = [NSKeyedArchiver archiveRootObject:loaclPayments toFile:FSSavedTransactionPath];
                dealed = YES;
            }
        }
        
        if (!dealed) {
            NSMutableArray *loaclPayments = [NSMutableArray array];
            [loaclPayments addObject:payment];
            saved = [NSKeyedArchiver archiveRootObject:loaclPayments toFile:FSSavedTransactionPath];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (cacheBlock) {
                cacheBlock(saved,payment,paymentTransaction);
            }
        });
    });
    
}
// 从cache中删除Payment
- (void)removePaymentsFromCache:(FSPayment *)payment
                     completion:(CompleteBlock)completion {
    
    dispatch_async(_readWriteQueue, ^{
        NSMutableArray *localPayments = [NSKeyedUnarchiver unarchiveObjectWithFile:FSSavedTransactionPath];
        if (localPayments != nil) {
            
            FSPayment *willRmObj = nil;
            
            for (FSPayment *obj in localPayments) {
                if ([obj isSamePayment:payment]) {
                    willRmObj = obj;
                    break;
                }
            }
            
            if (willRmObj != nil) {
                [localPayments removeObject:willRmObj];
                [NSKeyedArchiver archiveRootObject:localPayments toFile:FSSavedTransactionPath];
            }
        }
        
        if (completion) {
            completion();
        }
    });
}

// 获取要提交验证的payment
- (void)willCheckedPayment:(CheckPaymentBlock)checkBlock {
    
    dispatch_async(_readWriteQueue, ^{
        if (![[NSFileManager defaultManager] fileExistsAtPath:FSSavedTransactionPath]) {
            // 没有这个文件
            if (checkBlock) {
                checkBlock(nil);
            }
            return;
        }
        
        NSMutableArray *localPayments = [NSKeyedUnarchiver unarchiveObjectWithFile:FSSavedTransactionPath];
        if (localPayments != nil && [localPayments count] != 0) {
            FSPayment *obj = [localPayments firstObject];
            // 调整顺序放到最后一个
            [localPayments removeObject:obj];
            [localPayments addObject:obj];
            [NSKeyedArchiver archiveRootObject:localPayments toFile:FSSavedTransactionPath];
            
            if (checkBlock) {
                checkBlock(obj);
            }
            return;
        }
        
        // 没有存储过 或者 存储的数据为0
        if (checkBlock) {
            checkBlock(nil);
        }
    });
}

- (void)topCheckedPayment:(CheckPaymentBlock)checkBlock {
    
    dispatch_async(_readWriteQueue, ^{
        if (![[NSFileManager defaultManager] fileExistsAtPath:FSSavedTransactionPath]) {
            // 没有这个文件
            if (checkBlock) {
                checkBlock(nil);
            }
            return;
        }
        
        NSMutableArray *localPayments = [NSKeyedUnarchiver unarchiveObjectWithFile:FSSavedTransactionPath];
        if (localPayments != nil && [localPayments count] != 0) {
            FSPayment *obj = [localPayments firstObject];
            if (checkBlock) {
                checkBlock(obj);
            }
        }else{
            // 没有存储过 或者 存储的数据为0
            if (checkBlock) {
                checkBlock(nil);
            }
        }
    });
}


#pragma mark - init
static id paymentCache;
+ (instancetype)sharedCache{
    return [[FSPaymentCache alloc] init];
}
- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((paymentCache = [super init]) != nil) {
            _readWriteQueue = dispatch_queue_create("com.fission.CacheTransaction", DISPATCH_QUEUE_SERIAL);
        }
    });
    self = paymentCache;
    return self;
}
+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        paymentCache = [super allocWithZone:zone];
    });
    return paymentCache;
}
+ (id)copyWithZone:(struct _NSZone *)zone {
    return paymentCache;
}
@end
