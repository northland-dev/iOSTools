//
//  FSIMClientSever.h
//  Ready
//
//  Created by jiapeng on 2018/7/29.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSIMTextMessage.h"
#import "FSIMMessage.h"
#import "FSIMCommandMessage.h"
#import "FSIMVoiceMessage.h"
#import "FSConversation.h"
#import "FSIMImageMessage.h"
#import "FSIMMessageDefine.h"
#import "FSIMCommonMessage.h"
#import "FSIMDefineMessageContent.h"
#import "RCPayPicMessage.h"
#import "FSIMPayPicMessage.h"

#import "RCLollyPicBePayed.h"
#import "FSIMLollyPicBePayed.h"
#import "RCPushMessageContent.h"
#import "FSPushMessageContent.h"

#define KNOTIFICATION_LOGIN_IM_SUCCESS @"login_IM_Sucess"

@protocol FSIMClientReceiveMessageDelegate <NSObject>

/*!
 接收消息的回调方法
 
 @param message     当前接收到的消息
 @param nLeft       还剩余的未接收的消息数，left>=0
 
 @discussion 如果您设置了IMlib消息监听之后，SDK在接收到消息时候会执行此方法。
 其中，left为还剩余的、还未接收的消息数量。比如刚上线一口气收到多条消息时，通过此方法，您可以获取到每条消息，left会依次递减直到0。
 您可以根据left数量来优化您的App体验和性能，比如收到大量消息时等待left为0再刷新UI。
 */
- (void)onReceived:(FSIMMessage *)message left:(int)nLeft;

@optional
/*!
 IMLib连接状态的的监听器
 
 @param status  SDK与融云服务器的连接状态 0 成功 非0 异常状态
 
 @discussion 如果您设置了IMLib消息监听之后，当SDK与融云服务器的连接状态发生变化时，会回调此方法。
 */
- (void)onConnectionStatusChanged:(FSIIMConnectStatus)status;

- (void)sendMessageSucess:(NSInteger)messageId;

- (void)sendMessageFailed:(FSIMErrorCode)errorCode messageId:(NSInteger)messageId;

@end


@interface FSIMClientSever : NSObject

+ (FSIMClientSever *)sharedService;

-(void)addDelegate:(id<FSIMClientReceiveMessageDelegate>)delegate;

-(void)removeDelegate:(id<FSIMClientReceiveMessageDelegate>)delegate;

//链接消息服务器
- (void)connetIMSever;

//链接是否成功过
- (BOOL)FSIMIsConnected;

//发送消息
- (FSIMMessage*)sendMessage:(FSIMMessage*)message;

//当前所有会话的未读消息数
- (int)totalUnreadCount;

/*!
 设置deviceToken，用于远程推送
 
 @param deviceToken     从系统获取到的设备号deviceToken(需要去掉空格和尖括号)
 
 @discussion
 deviceToken是系统提供的，从苹果服务器获取的，用于APNs远程推送必须使用的设备唯一值。
 您需要将-application:didRegisterForRemoteNotificationsWithDeviceToken:获取到的deviceToken，转为NSString类型，并去掉其中的空格和尖括号，作为参数传入此方法。
 
 如:
 
 - (void)application:(UIApplication *)application
 didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
 NSString *token = [deviceToken description];
 token = [token stringByReplacingOccurrencesOfString:@"<"
 withString:@""];
 token = [token stringByReplacingOccurrencesOfString:@">"
 withString:@""];
 token = [token stringByReplacingOccurrencesOfString:@" "
 withString:@""];
 [[FSIMClientSever sharedService] setDeviceToken:token];
 }
 
 */
- (void)setDeviceToken:(NSString *)deviceToken;

/*!
 插入消息
 
 @param conversationType    会话类型
 @param targetId            目标会话ID
 @param sendStatus          发送状态
 @param content             消息的内容
 @return                    插入的消息实体
 
 @discussion 此方法不支持聊天室的会话类型。
 
 @warning 目前仅支持插入向外发送的消息，不支持插入接收的消息。
 */
- (FSIMMessage *)insertMessage:(FSConversationType)conversationType
                      targetId:(NSString *)targetId
                    sendStatus:(FSIMSentStatus)sendStatus
                       content:(FSIMMessageContent *)content;

/*!
 插入消息
 
 @param conversationType    会话类型
 @param targetId            目标会话ID
 @param senderUserId        发送者消息
 @param content             消息的内容
 @return                    插入的消息实体
 
 @discussion 此方法不支持聊天室的会话类型。
 
 @warning 目前仅支持插入向外发送的消息，不支持插入接收的消息。
 */


- (FSIMMessage *)insertIncomeMessage:(FSConversationType)conversationType
                            targetId:(NSString *)targetId
                        senderUserId:(NSString *)senderUserId
                             content:(FSIMMessageContent *)content;

/*!
 获取某个会话内的未读消息数
 
 @param conversationType    会话类型
 @param targetId            会话目标ID
 @return                    该会话内的未读消息数
 */
- (int)getUnreadCount:(FSConversationType)conversationType targetId:(NSString *)targetId;

/*!
 获取某个类型的会话中所有的未读消息数
 
 @param conversationTypes   会话类型的数组
 @return                    该类型的会话中所有的未读消息数
 */
- (int)getUnreadCount:(NSArray *)conversationTypes;

/*!
 清除某个会话中的未读消息数
 
 @param conversationType    会话类型，不支持聊天室
 @param targetId            目标会话ID
 @return                    是否清除成功
 */
- (BOOL)clearMessagesUnreadStatus:(FSConversationType)conversationType
                         targetId:(NSString *)targetId;

/*!
 获取本地存储的会话列表。
 */
- (NSArray<FSConversation *> *)conversationList;

/*!
 获取单个会话数据
 
 @param conversationType    会话类型
 @param targetId            目标会话ID
 @return                    会话的对象
 */
- (FSConversation *)getConversation:(FSConversationType)conversationType
                           targetId:(NSString *)targetId;

/*!
 删除指定类型的会话
 
 @param conversationTypeList    会话类型的数组(需要将FSConversationType转为NSNumber构建Array)
 @return                        是否删除成功
 */
- (BOOL)clearConversations:(NSArray *)conversationTypeList;

/*!
 从本地存储中删除会话
 
 @param conversationType    会话类型
 @param targetId            目标会话ID
 @return                    是否删除成功
 
 @discussion 此方法会从本地存储中删除该会话，但是不会删除会话中的消息。
 */
- (BOOL)removeConversation:(FSConversationType)conversationType
                  targetId:(NSString *)targetId;

/*!
 设置会话的置顶状态
 
 @param conversationType    会话类型
 @param targetId            目标会话ID
 @param isTop               是否置顶
 @return                    设置是否成功
 */
- (BOOL)setConversationToTop:(FSConversationType)conversationType
                    targetId:(NSString *)targetId
                       isTop:(BOOL)isTop;

/*!
 获取会话中的草稿信息
 
 @param conversationType    会话类型
 @param targetId            会话目标ID
 @return                    该会话中的草稿
 */
- (NSString *)getTextMessageDraft:(FSConversationType)conversationType
                         targetId:(NSString *)targetId;

/*!
 保存草稿信息
 
 @param conversationType    会话类型
 @param targetId            会话目标ID
 @param content             草稿信息
 @return                    是否保存成功
 */
- (BOOL)saveTextMessageDraft:(FSConversationType)conversationType
                    targetId:(NSString *)targetId
                     content:(NSString *)content;

/*!
 删除会话中的草稿信息
 
 @param conversationType    会话类型
 @param targetId            会话目标ID
 @return                    是否删除成功
 */
- (BOOL)clearTextMessageDraft:(FSConversationType)conversationType
                     targetId:(NSString *)targetId;

/*!
 获取某个会话中指定数量的最新消息实体
 
 @param conversationType    会话类型
 @param targetId            目标会话ID
 @param count               需要获取的消息数量
 @return                    消息实体FSIMMessage对象列表
 
 @discussion 此方法会获取该会话中指定数量的最新消息实体，返回的消息实体按照时间从新到旧排列。
 如果会话中的消息数量小于参数count的值，会将该会话中的所有消息返回。
 */
- (NSArray *)getLatestMessages:(FSConversationType)conversationType
                      targetId:(NSString *)targetId
                         count:(int)count;

/*!
 获取会话中，从指定消息之前、指定数量的最新消息实体
 
 @param conversationType    会话类型
 @param targetId            目标会话ID
 @param oldestMessageId     截止的消息ID
 @param count               需要获取的消息数量
 @return                    消息实体FSIMMessage对象列表
 
 @discussion 此方法会获取该会话中，oldestMessageId之前的、指定数量的最新消息实体，返回的消息实体按照时间从新到旧排列。
 返回的消息中不包含oldestMessageId对应那条消息，如果会话中的消息数量小于参数count的值，会将该会话中的所有消息返回。
 如：
 oldestMessageId为10，count为2，会返回messageId为9和8的RCMessage对象列表。
 */
- (NSArray *)getHistoryMessages:(FSConversationType)conversationType
                       targetId:(NSString *)targetId
                oldestMessageId:(long)oldestMessageId
                          count:(int)count;
/*!
 删除消息
 
 @param messageIds  消息ID的列表
 @return            是否删除成功
 */
- (BOOL)deleteMessages:(NSArray *)messageIds;

/*!
 删除某个会话中的所有消息
 
 @param conversationType    会话类型，不支持聊天室
 @param targetId            目标会话ID
 @return                    是否删除成功
 */
- (BOOL)clearMessages:(FSConversationType)conversationType
             targetId:(NSString *)targetId;

/*!
 设置消息的附加信息
 
 @param messageId   消息ID
 @param value       附加信息
 @return            是否设置成功
 */
- (BOOL)setMessageExtra:(long)messageId value:(NSString *)value;

/*!
 设置消息的发送状态
 
 @param messageId       消息ID
 @param sentStatus      消息的发送状态
 @return                是否设置成功
 */
- (BOOL)setMessageSentStatus:(long)messageId
                  sentStatus:(FSIMSentStatus)sentStatus;

/*!
 将某个用户加入黑名单
 
 @param userId          需要加入黑名单的用户ID
 @param successBlock    加入黑名单成功的回调
 @param errorBlock      加入黑名单失败的回调 [status:失败的错误码]
 */
- (void)addToBlacklist:(NSString *)userId
               success:(void (^)())successBlock
                 error:(void (^)())errorBlock;

/*!
 将某个用户移出黑名单
 
 @param userId          需要移出黑名单的用户ID
 @param successBlock    移出黑名单成功的回调
 @param errorBlock      移出黑名单失败的回调[status:失败的错误码]
 */
- (void)removeFromBlacklist:(NSString *)userId
                    success:(void (^)())successBlock
                      error:(void (^)())errorBlock;

/*!
 查询某个用户是否已经在黑名单中
 
 @param userId          需要查询的用户ID
 @param successBlock    查询成功的回调 [bizStatus:该用户是否在黑名单中。0表示已经在黑名单中，101表示不在黑名单中]
 @param errorBlock      查询失败的回调 [status:失败的错误码]
 */
- (void)getBlacklistStatus:(NSString *)userId
                   success:(void (^)(int bizStatus))successBlock
                     error:(void (^)())errorBlock;

/*!
 查询已经设置的黑名单列表
 
 @param successBlock    查询成功的回调 [blockUserIds:已经设置的黑名单中的用户ID列表]
 @param errorBlock      查询失败的回调 [status:失败的错误码]
 */
- (void)getBlacklist:(void (^)(NSArray *blockUserIds))successBlock
               error:(void (^)())errorBlock;

/*!
 断开与融云服务器的连接，并不再接收远程推送
 
 @discussion
 因为SDK在前后台切换或者网络出现异常都会自动重连，会保证连接的可靠性。
 所以除非您的App逻辑需要登出，否则一般不需要调用此方法进行手动断开。
 */
- (void)logout;


- (void)joinGroupWithGroupId:(NSString *)groupId;

@end
