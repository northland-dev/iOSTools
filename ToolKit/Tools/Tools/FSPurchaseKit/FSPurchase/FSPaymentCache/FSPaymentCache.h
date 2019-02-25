//
//  FSPaymentCache.h
//  FSPurchase
//
//  Created by Fission on 2/11/2017.
//  Copyright © 2017 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSPurchaseHeader.h"

@interface FSPaymentCache : NSObject
+ (instancetype)sharedCache;

- (void)savePaymentTransactionToCache:(SKPaymentTransaction *)paymentTransaction
                                extra:(FSExtraParam *)extra
                           completion:(CachePaymentBlock)cacheBlock;
// 从cache中删除Payment
- (void)removePaymentsFromCache:(FSPayment *)payment completion:(CompleteBlock)completion;
// 获取要提交验证的payment
- (void)willCheckedPayment:(CheckPaymentBlock)checkBlock;
//
- (void)topCheckedPayment:(CheckPaymentBlock)checkBlock;


@end
