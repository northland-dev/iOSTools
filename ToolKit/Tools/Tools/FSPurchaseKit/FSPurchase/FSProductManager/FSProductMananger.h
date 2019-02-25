//
//  FSProductMananger.h
//  FSPurchase
//
//  Created by Charles on 2017/11/1.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@class FSProductMananger;
@protocol FSProductManangerDelegate <NSObject>
-(void)productManager:(FSProductMananger *)manager productSets:(NSDictionary<NSString *,SKProduct *> *)productSet;
@end

@interface FSProductMananger : NSObject

@property(nonatomic,assign)id<FSProductManangerDelegate> delegate;

+(instancetype)sharedManager;

// 获取苹果配置的有效商品列表
-(void)requestProducts:(NSSet<NSString *> *)productIds;
// 取消请求苹果列表
-(void)cancleRequest;
@end
