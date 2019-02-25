//
//  FSIMStatusDefine.h
//  testRongYun
//
//  Created by stu on 2017/11/2.
//  Copyright © 2017年 stu. All rights reserved.
//

#ifndef FSIMStatusDefine_h
#define FSIMStatusDefine_h

#pragma mark - 链接相关
#pragma mark RCReceivedStatus - 链接相关
typedef NS_ENUM(NSUInteger, FSIIMConnectStatus) {
    FSIIMConnectFailed = 1,//连接失败
    FSIMConnectKicked_Offline_By_Other_Client,//其他设备登录，被迫下线
    FSIMConnectKicked_UserBlocked,// 用户被封禁
    FSIMConnectTimeOut//超时
};

#pragma mark - 消息相关

#pragma mark RCMessageDirection - 消息的方向
/*!
 消息的方向
 */
typedef NS_ENUM(NSUInteger, FSIMMessageDirection) {
    /*!
     发送
     */
    FSIMMessageDirection_SEND = 1,
    
    /*!
     接收
     */
    FSIMMessageDirection_RECEIVE = 2
};

#pragma mark RCMessagePersistent - 消息的存储策略
/*!
 消息的存储策略
 */
typedef NS_ENUM(NSUInteger, FSIMMessagePersistent) {
    /*!
     在本地不存储，不计入未读数
     */
    FSIMMessagePersistent_NONE = 0,
    
    /*!
     在本地只存储，但不计入未读数
     */
    FSIMMessagePersistent_ISPERSISTED = 1,
    
    /*!
     在本地进行存储并计入未读数
     */
    FSIMMessagePersistent_ISCOUNTED = 3,
    
    /*!
     在本地不存储，不计入未读数，并且如果对方不在线，服务器会直接丢弃该消息，对方如果之后再上线也不会再收到此消息(聊天室类型除外，此类消息聊天室会视为普通消息)。
     
     @discussion 一般用于发送输入状态之类的消息，该类型消息的messageUId为nil。
     */
    FSIMMessagePersistent_STATUS = 16
};

#pragma mark RCReceivedStatus - 消息的接收状态
/*!
 消息的接收状态
 */
typedef NS_ENUM(NSUInteger, FSIMReceivedStatus) {
    /*!
     未读
     */
    FSIMReceivedStatus_UNREAD = 0,
    
    /*!
     已读
     */
    FSIMReceivedStatus_READ = 1,
    
    /*!
     已听
     
     @discussion 仅用于语音消息
     */
    FSIMReceivedStatus_LISTENED = 2,
    
    /*!
     已下载
     */
    FSIMReceivedStatus_DOWNLOADED = 4,
    
    /*!
     该消息已经被其他登录的多端收取过。（即该消息已经被其他端收取过后。当前端才登录，并重新拉取了这条消息。客户可以通过这个状态更新UI，比如不再提示）。
     */
    FSIMReceivedStatus_RETRIEVED = 8,
    
    /*!
     该消息是被多端同时收取的。（即其他端正同时登录，一条消息被同时发往多端。客户可以通过这个状态值更新自己的某些UI状态）。
     */
    FSIMReceivedStatus_MULTIPLERECEIVE = 16,
    
};

#pragma mark RCSentStatus - 消息的发送状态
/*!
 消息的发送状态
 */
typedef NS_ENUM(NSUInteger, FSIMSentStatus) {
    /*!
     发送中
     */
    FSIMSentStatus_SENDING = 10,
    
    /*!
     发送失败
     */
    FSIMSentStatus_FAILED = 20,
    
    /*!
     已发送成功
     */
    FSIMSentStatus_SENT = 30,
    
    /*!
     对方已接收
     */
    FSIMSentStatus_RECEIVED = 40,
    
    /*!
     对方已阅读
     */
    FSIMSentStatus_READ = 50,
    
    /*!
     对方已销毁
     */
    FSIMSentStatus_DESTROYED = 60,
    
    /*!
     发送已取消
     */
    FSIMSentStatus_CANCELED = 70
};

#pragma mark - 会话相关

#pragma mark RCConversationType - 会话类型
/*!
 会话类型
 */
typedef NS_ENUM(NSUInteger, FSConversationType) {
    /*!
     单聊
     */
    FSConversationType_PRIVATE = 1,
    
    /*!
     讨论组
     */
    FSConversationType_DISCUSSION = 2,
    
    /*!
     群组
     */
    FSConversationType_GROUP = 3,
    
    /*!
     聊天室
     */
    FSConversationType_CHATROOM = 4,
    
    /*!
     客服
     */
    FSConversationType_CUSTOMERSERVICE = 5,
    
    /*!
     系统会话
     */
    FSConversationType_SYSTEM = 6,
    
    /*!
     应用内公众服务会话
     
     @discussion
     客服2.0使用应用内公众服务会话（ConversationType_APPSERVICE）的方式实现。
     即客服2.0会话是其中一个应用内公众服务会话，这种方式我们目前不推荐，请尽快升级到新客服，升级方法请参考官网的客服文档。
     */
    FSConversationType_APPSERVICE = 7,
    
    /*!
     跨应用公众服务会话
     */
    FSConversationType_PUBLICSERVICE = 8,
    
    /*!
     推送服务会话
     */
    FSConversationType_PUSHSERVICE = 9
};

#pragma mark RCErrorCode - 具体业务错误码
/*!
 具体业务错误码
 */
typedef NS_ENUM(NSInteger, FSIMErrorCode) {
    /*!
     未知错误（预留）
     */
    FS_ERRORCODE_UNKNOWN = -1,
    
    /*!
     已被对方加入黑名单
     */
    FS_REJECTED_BY_BLACKLIST = 405,
    
    /*!
     超时
     */
    FS_ERRORCODE_TIMEOUT = 5004,
    
    /*!
     发送消息频率过高，1秒钟最多只允许发送5条消息
     */
    FS_SEND_MSG_FREQUENCY_OVERRUN = 20604,
    
    /*!
     不在该讨论组中
     */
    FS_NOT_IN_DISCUSSION = 21406,
    
    /*!
     不在该群组中
     */
    FS_NOT_IN_GROUP = 22406,
    
    /*!
     在群组中已被禁言
     */
    FS_FORBIDDEN_IN_GROUP = 22408,
    
    /*!
     不在该聊天室中
     */
    FS_NOT_IN_CHATROOM = 23406,
    
    /*!
     在该聊天室中已被禁言
     */
    FS_FORBIDDEN_IN_CHATROOM = 23408,
    
    /*!
     已被踢出并禁止加入聊天室
     */
    FS_KICKED_FROM_CHATROOM = 23409,
    
    /*!
     聊天室不存在
     */
    FS_RC_CHATROOM_NOT_EXIST = 23410,
    
    /*!
     聊天室成员超限
     */
    FS_RC_CHATROOM_IS_FULL = 23411,
    
    /*!
     聊天室接口参数无效
     */
    FS_RC_PARAMETER_INVALID_CHATROOM = 23412,
    
    /*!
     聊天室云存储业务未开通
     */
    FS_RC_ROAMING_SERVICE_UNAVAILABLE_CHATROOM = 23414,
    
    /*!
     当前连接不可用（连接已经被释放）
     */
    FS_RC_CHANNEL_INVALID = 30001,
    
    /*!
     当前连接不可用
     */
    FS_RC_NETWORK_UNAVAILABLE = 30002,
    
    /*!
     消息响应超时
     */
    FS_RC_MSG_RESPONSE_TIMEOUT = 30003,
    
    /*!
     SDK没有初始化
     
     @discussion 在使用SDK任何功能之前，必须先Init。
     */
    FS_CLIENT_NOT_INIT = 33001,
    
    /*!
     数据库错误
     
     @discussion 请检查您使用的Token和userId是否正确。
     */
    FS_DATABASE_ERROR = 33002,
    
    /*!
     开发者接口调用时传入的参数错误
     
     @discussion 请检查接口调用时传入的参数类型和值。
     */
    FS_INVALID_PARAMETER = 33003,
    
    /*!
     历史消息云存储业务未开通
     */
    FS_MSG_ROAMING_SERVICE_UNAVAILABLE = 33007,
    
    /*!
     无效的公众号。(由会话类型和Id所标识的公众号会话是无效的)
     */
    FS_INVALID_PUBLIC_NUMBER = 29201,
    /*!
     消息大小超限，消息体（序列化成json格式之后的内容）最大128k bytes。
     */
    FS_RC_MSG_SIZE_OUT_OF_LIMIT = 30016,
    
    /*!
     撤回消息参数无效。
     */
    FS_RC_RECALLMESSAGE_PARAMETER_INVALID   = 25101,
    /*!
     push设置参数无效。
     */
    FS_RC_PUSHSETTING_PARAMETER_INVALID  = 26001,
    /*!
     操作被禁止。
     */
    FS_RC_OPERATION_BLOCKED  = 20605,
    
    /*!
     操作不支持。
     */
    FS_RC_OPERATION_NOT_SUPPORT  = 20606,
    
    /*!
     发送的消息中包含敏感词 （发送方发送失败，接收方不会收到消息）
     */
    FS_RC_MSG_BLOCKED_SENSITIVE_WORD = 21501,
    
    /*!
     消息中敏感词已经被替换 （接收方可以收到被替换之后的消息）
     */
    FS_RC_MSG_REPLACED_SENSITIVE_WORD = 21502
};


#endif /* FSIMStatusDefine_h */
