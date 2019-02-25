//
//  FSIMLollyPicBePayed.h
//  Lolly
//
//  Created by Charles on 2017/11/19.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSIMMessageContent.h"

@interface FSIMLollyPicBePayed : FSIMMessageContent


@property(nonatomic, assign) NSInteger price; //金额
@property(nonatomic, copy) NSString *previewUrl; //图片
@property(nonatomic, copy) NSString *originalUrl;
@property(nonatomic, copy) NSString *photoId;
@property(nonatomic, copy) NSString *hostId;

@property(nonatomic, assign) NSInteger originalMessageId;
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
 初始化命令消息
 
 @param name    命令的名称
 @param data    命令的扩展数据
 @return        命令消息对象
 */
+ (instancetype)messageWithName:(NSString *)name data:(NSString *)data;


@end
