//
//  FSLocalPaymentVerifyProtocol.h
//  FSPurchase
//
//  Created by Charles on 2017/11/2.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSPurchaseHeader.h"

@class FSPayment;
@protocol FSLocalPaymentVerifyProtocol <NSObject>
// 超时设置
@property (nonatomic,assign)NSTimeInterval timeOutInterval;
// 提交验证的地址
@property (nonatomic,strong)NSString *verfiyUrl;
// 额外的验证参数
@property (nonatomic,strong)NSDictionary *extraParam;

- (void)paymentVerify:(FSPayment *)payment
         successBlock:(SuccessBlock)successBlock
           faildBlock:(FaildBlock)faildBlock;
@end
