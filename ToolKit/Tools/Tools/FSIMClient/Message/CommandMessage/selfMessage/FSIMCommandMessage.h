//
//  FSIMCommandMessage.h
//  testRongYun
//
//  Created by stu on 2017/11/2.
//  Copyright © 2017年 stu. All rights reserved.
//

#import "FSIMMessageContent.h"

/*!
 命令消息类
 
 @discussion 命令消息类，此消息不存储不计入未读消息数。
 */
@interface FSIMCommandMessage : FSIMMessageContent

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
