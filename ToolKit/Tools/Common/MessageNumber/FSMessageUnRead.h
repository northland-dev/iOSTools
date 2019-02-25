//
//  FSMessageUnRead.h
//  Ready
//
//  Created by jiapeng on 2018/10/31.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSMessageUnRead : NSObject
+ (instancetype) launcher;
-(void)addFridensMessageNumber:(NSString *)userId;
-(void)removeFridensMessageNumber:(NSString *)userId;
-(void)cleanFriendsMessageNumber;
-(void)currentMessageAllNumber;

//添加临时会话
-(void)addTemporarySession:(NSString *)userId;
//查询是否超过24小时
-(BOOL)isOverCurrentTime:(NSString *)userId;

-(BOOL)isOverCurrentTime:(NSString *)userId showToast:(BOOL)show;
@end

NS_ASSUME_NONNULL_END
