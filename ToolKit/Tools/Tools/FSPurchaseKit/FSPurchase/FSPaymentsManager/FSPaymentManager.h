//
//  FSPaymentManager.h
//  FSPurchase
//
//  Created by Fission on 2/11/2017.
//  Copyright © 2017 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSPurchaseHeader.h"
#import "FSPaymentVerifyProtocol.h"

@interface FSPaymentManager : NSObject

@property(nonatomic,strong)id<FSPaymentVerifyProtocol> verifyManager;
// default 3
@property(nonatomic,assign)NSInteger retryTimes;

@property(nonatomic,strong)NSDictionary *pricesOfProducts;

+ (instancetype)sharedManager;

- (void)startAutoVerify;

- (void)managerPurchase:(SKProduct *)product
                  extra:(FSExtraParam *)extra
           successBlock:(SuccessBlock)success
             faildBlock:(FaildBlock)faild;

@end
