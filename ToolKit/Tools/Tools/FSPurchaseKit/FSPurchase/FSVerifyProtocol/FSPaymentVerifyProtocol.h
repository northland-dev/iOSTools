//
//  FSPaymentVerifyProtocol.h
//  FSPurchase
//
//  Created by Charles on 2017/11/2.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/Storekit.h>
#import "FSPurchaseHeader.h"

@class FSExtraParam;
@protocol FSPaymentVerifyProtocol <NSObject>
// 超时设置
@property (nonatomic,assign)NSTimeInterval timeOutInterval;
// 提交验证的地址
@property (nonatomic,strong)NSString *verfiyUrl;
// 额外的验证参数
@property (nonatomic,strong)NSDictionary *extraParam;

- (void)paymentVerify:(SKPaymentTransaction *)paymentTransaction
                extra:(FSExtraParam *)extra
         successBlock:(SuccessBlock)successBlock
           faildBlock:(FaildBlock)faildBlock;
@end
