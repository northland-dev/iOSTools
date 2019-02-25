//
//  FSFaildPaymentsMananger.h
//  FSPurchase
//
//  Created by Charles on 2017/11/2.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSLocalPaymentVerifyProtocol.h"
#import "FSRecipetManager.h"

@interface FSFaildPaymentsMananger : NSObject
// 启动本地检测时必须要实现
@property(nonatomic,strong)id<FSLocalPaymentVerifyProtocol> verifyManager;

+ (instancetype)sharedManager;

- (void)startFaildVerify;

- (void)checkPayments;

- (void)stopFaildVerify;
@end
