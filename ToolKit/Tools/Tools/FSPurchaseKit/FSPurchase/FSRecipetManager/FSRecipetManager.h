//
//  FSRecipetManager.h
//  FSPurchaseKit
//
//  Created by Charles on 2017/11/23.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSPurchaseHeader.h"
//typedef void (^CompletBlock)(void);
@protocol FSRecipetManagerDelegate;
@interface FSRecipetManager : NSObject
@property (nonatomic,assign)id<FSRecipetManagerDelegate> delegate;
+ (instancetype)defaultManager;
- (void)refreshRecipet;
- (void)refreshRecipetSuccess:(CompleteBlock)success
                        faild:(CompleteBlock)faild;
@end

@protocol FSRecipetManagerDelegate<NSObject>
- (void)recipetManagerRefreshComplete;
- (void)recipetManagerRefreshFaild;
@end
