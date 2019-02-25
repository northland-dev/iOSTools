//
//  FSRecipetManager.m
//  FSPurchaseKit
//
//  Created by Charles on 2017/11/23.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSRecipetManager.h"
#import <StoreKit/StoreKit.h>
@interface FSRecipetManager()<SKRequestDelegate>
@property (nonatomic,copy)CompleteBlock success;
@property (nonatomic,copy)CompleteBlock faild;
@end
@implementation FSRecipetManager
+(instancetype)defaultManager {
    return [[FSRecipetManager alloc] init];
}
- (void)refreshRecipet {
    SKReceiptRefreshRequest *request = [[SKReceiptRefreshRequest alloc] init];
    [request setDelegate:self];
    [request start];
}
- (void)refreshRecipetSuccess:(void(^)(void))success
                        faild:(void(^)(void))faild {
    self.success = success;
    self.faild = faild;
    [self refreshRecipet];
}
- (void)requestDidFinish:(SKRequest *)request {
    if ([self.delegate respondsToSelector:@selector(recipetManagerRefreshComplete)]) {
        [self.delegate recipetManagerRefreshComplete];
    }
    if (self.success) {
        self.success();
    }
}
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(recipetManagerRefreshFaild)]) {
        [self.delegate recipetManagerRefreshFaild];
    }
    if (self.faild) {
        self.faild();
    }
}

@end
