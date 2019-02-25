//
//  FSIMMessage.h
//  testRongYun
//
//  Created by stu on 2017/11/1.
//  Copyright © 2017年 stu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSIMStatusDefine.h"
#import "FSIMMessageContent.h"

/*!
 消息实体类
 
 @discussion 消息实体类，包含消息的所有属性。
 
 消息实体（FSIMMessage）是本地存储的实体对象，其中包含消息的各种属性（如消息 ID、消息的方向、接收状态、接收时间、发送者等）与消息内容。
 
 消息内容（FSIMMessageContent）是与消息属性无关的一段 json 数据，可以承载任何内容。
 
 SDK 针对 IM 的使用场景，内置了常用类型的消息（如文本消息、图片消息、语音消息、位置消息、富文本消息等）。您也可以自定义消息，在消息内容中传输和存储任何json格式的内容。 消息在本地存储是以消息实体（FSIMMessage）的形式存在，在传输时以内容（FSIMMessageContent）的形式存在。
 */
@interface FSIMMessage : NSObject

@property (strong, nonatomic) NSString *pushContent;//push显示的内容
@property (strong, nonatomic) NSString *pushData;//push不显示的内容

/*!
 会话类型
 */
@property(nonatomic, assign) FSConversationType conversationType;

/*!
 目标会话ID
 */
@property(nonatomic, strong) NSString *targetId;

/*!
 消息的ID
 
 @discussion 本地存储的消息的唯一值（数据库索引唯一值）
 */
@property(nonatomic, assign) long messageId;

/*!
 消息的方向
 */
@property(nonatomic, assign) FSIMMessageDirection messageDirection;

/*!
 消息的发送者ID
 */
@property(nonatomic, strong) NSString *senderUserId;

/*!
 消息的接收状态
 */
@property(nonatomic, assign) FSIMReceivedStatus receivedStatus;

/*!
 消息的发送状态
 */
@property(nonatomic, assign) FSIMSentStatus sentStatus;

/*!
 消息的接收时间（Unix时间戳、毫秒）
 */
@property(nonatomic, assign) long long receivedTime;

/*!
 消息的发送时间（Unix时间戳、毫秒）
 */
@property(nonatomic, assign) long long sentTime;

/*!
 消息的类型名
 */
@property(nonatomic, strong) NSString *objectName;

/*!
 消息的内容
 */
@property(nonatomic, strong) FSIMMessageContent *content;

/*!
 消息的附加字段
 */
@property(nonatomic, strong) NSString *extra;

/*!
 全局唯一ID
 
 @discussion 服务器消息唯一ID（在同一个Appkey下全局唯一）
 */
@property(nonatomic, strong) NSString *messageUId;

/*!
 FSIMMessage初始化方法
 
 @param  conversationType    会话类型
 @param  targetId            目标会话ID
 @param  messageDirection    消息的方向
 @param  messageId           消息的ID
 @param  content             消息的内容
 */
- (instancetype)initWithType:(FSConversationType)conversationType
                    targetId:(NSString *)targetId
                   direction:(FSIMMessageDirection)messageDirection
                   messageId:(long)messageId
                     content:(FSIMMessageContent *)content;

@end
