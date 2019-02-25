//
//  FSIMUserInfo.h
//  testRongYun
//
//  Created by stu on 2017/11/2.
//  Copyright © 2017年 stu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSUserCenterInfoModel.h"

@interface FSIMUserInfo : FSUserCenterInfoModel

/*!
 用户ID
 */
@property(nonatomic, strong) NSString *userId;

/*!
 用户名称
 */
@property(nonatomic, strong) NSString *name;

/*!
 用户头像的URL
 */
@property(nonatomic, strong) NSString *portraitUri;

/*!
 用户头像
 */
@property(nonatomic, strong) UIImage *portraitImage;

/*!
 用户信息的初始化方法
 
 @param userId      用户ID
 @param username    用户名称
 @param portrait    用户头像的URL
 @return            用户信息对象
 */
- (instancetype)initWithUserId:(NSString *)userId
                          name:(NSString *)username
                      portrait:(NSString *)portrait;


+ (instancetype)userInfoFromUserCenter:(FSUserCenterInfoModel *)centerModel;

@end
