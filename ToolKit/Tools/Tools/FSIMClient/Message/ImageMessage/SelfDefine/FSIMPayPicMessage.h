//
//  FSIMPayPicMessage.h
//  Lolly
//
//  Created by stu on 2017/11/7.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSIMChatMessage.h"

@interface FSIMPayPicMessage : FSIMChatMessage

@property(nonatomic, assign) BOOL ischarged; //是否需要付费
@property(nonatomic, assign) BOOL ispurchased; //是否已付费
@property(nonatomic, assign) NSInteger gold; //金额
@property(nonatomic, copy) NSString *imgUrl; //图片
@property(nonatomic, copy) NSString *originalUrl;
@property(nonatomic, copy) NSString *photoId;
@property(nonatomic, assign)NSInteger mid;
/*!
 命令的名称
 */
@property(nonatomic, strong) NSString *name;

/*!
 命令的扩展数据
 
 @discussion 命令的扩展数据，可以为任意字符串，如存放您定义的json数据。
 */
@property(nonatomic, strong) NSString *data;

/*!
 原始图片
 */
@property(nonatomic, strong) UIImage *soureImage;

/*!
 缩略图
 */
@property(nonatomic, strong) UIImage *thumbImage;
/*!
 原始图片地址
 */
@property(nonatomic, strong) NSString *localSoureImage;

/*!
 缩略图地址
 */
@property(nonatomic, strong) NSString *localThumbImage;

/*!
 初始化命令消息
 
 @param name    命令的名称
 @param data    命令的扩展数据
 @return        命令消息对象
 */
+ (instancetype)messageWithName:(NSString *)name data:(NSString *)data;

@end
