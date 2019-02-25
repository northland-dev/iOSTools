//
//  FSIMClientSever.m
//  Ready
//
//  Created by jiapeng on 2018/7/29.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSIMClientSever.h"
#import <RongIMLib/RongIMLib.h>
#import "FSRequestTokenAPI.h"
#import "FSMessageReceiptSever.h"

#import <FSFileCacheFramework/FSFileCacheManager.h>

//消息注册类型 对应转换类型
#import "RCAddFriendsContent.h"
#import "FSIMAddFriendsContent.h"
#import "RCAgreeAddFriednsContent.h"
#import "FSIMAgreeAddFriednsContent.h"
#import "RCFriendsMessageContent.h"
#import "FSIMFriendsMessageContent.h"
#import "RCGameInviteContent.h"
#import "FSIMGameInviteContent.h"
#import "RCGroupJoinContent.h"
#import "FSIMGroupJoinContent.h"
#import "RCTaskUpdateContent.h"
#import "FSIMTaskUpdateContent.h"
#import "RCGameMatchMessage.h"
#import "FSIMGameMatchContent.h"
#import "RCGameMathRobotContent.h"
#import "FSGameMatchRobotContent.h"
#import "RCGameRejectContent.h"
#import "FSGameRejectContent.h"
#import "RCTaskUpdateContent.h"
#import "FSIMTaskUpdateContent.h"
#import "RCGameFriendStateContent.h"
#import "RCNoticeTextContent.h"
#import "FSIMNoticeTextContent.h"
#import "FSIMGameFriendStateMessage.h"
#import "RCFriendOnlineContent.h"
#import "FSIMFriendOnlineMessage.h"

#import "FSFriendBlackListManager.h"
#import "RCSystemContent.h"
#import "FSIMSystemContent.h"
#import "RCGameChangeContent.h"
#import "FSIMGameChangeContent.h"
#import "FSAppLanucher.h"
#import "RCBalanceUpdateContent.h"
#import "RCDanmuContent.h"
#import "FSIMDanmuContent.h"
#import "FSLocalNotificationMananger.h"
#import "RCGameInviteAcceptContent.h"

#import "FSGameInviteAcceptContent.h"
#import "RCFriendRemoveContent.h"

#import "FSMessageUnRead.h"
#import "RCUnFriendContent.h"
#import "FSUnFriendContent.h"
#import "FSIMActivityAwardPoolEnd.h"
#import "RCActivityAwardPoolEnd.h"
#import "FSIMActivityHorseRace.h"
#import "RCActivityHorseRace.h"

@interface FSIMClientSever ()<FSRequestTokenAPIDelegate,RCConnectionStatusChangeDelegate,RCIMClientReceiveMessageDelegate> {
    NSMutableArray *_delegates;
    FSRequestTokenAPI *_requestTokenAPI;
    NSString *_token;
    NSTimer  *_timer;
    NSMutableArray *_messageArray;
    FSMessageReceiptSever *_messageReceiptSever;

    BOOL _IMConnected;//是否链接成功过
}

@end

@implementation FSIMClientSever

static FSIMClientSever *sharedInstance;

+ (FSIMClientSever *)sharedService {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FSIMClientSever alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init {
    if(self = [super init]) {
        _IMConnected = NO;
        _delegates = [NSMutableArray array];
        _messageArray = [NSMutableArray array];
    }
    return self;
}

- (void)initData {
    if (!_requestTokenAPI) {
        NSString *rongYunUrl = [[[FSGlobalLauncher launcher].allKeyDict objectForKey:key_rong_url] stringByReplacingOccurrencesOfString:@"http://" withString:@""];
        NSString *rongYunFile = [[[FSGlobalLauncher launcher].allKeyDict objectForKey:key_rong_file] stringByReplacingOccurrencesOfString:@"http://" withString:@""];
        NSString *rongYunStatistic = [[[FSGlobalLauncher launcher].allKeyDict objectForKey:key_rong_statistic] stringByReplacingOccurrencesOfString:@"http://" withString:@""];
        
        if([IMCLIENT_APP_KEY isEqualToString:@"6tnym1br64wf7"]){
              [[RCIMClient sharedRCIMClient] setServerInfo:rongYunUrl fileServer:rongYunFile];
              [[RCIMClient sharedRCIMClient] setStatisticServer:rongYunStatistic];
        }else{
              [[RCIMClient sharedRCIMClient] setServerInfo:@"navsg01-glb.ronghub.com" fileServer:@"up.qbox.me"];
              [[RCIMClient sharedRCIMClient] setStatisticServer:@"statssg01-glb.ronghub.com"];
        }

        [[RCIMClient sharedRCIMClient] initWithAppKey:IMCLIENT_APP_KEY];
        [[RCIMClient sharedRCIMClient] setReceiveMessageDelegate:self object:nil];
        [[RCIMClient sharedRCIMClient] setRCConnectionStatusChangeDelegate:self];
        
        //添加好友消息类型
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCAddFriendsContent class]];
        //同意添加好友消息类型
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCAgreeAddFriednsContent class]];
        //发送好友消息
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCFriendsMessageContent class]];
        //游戏邀请消息
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCGameInviteContent class]];
        //聊天室进入消息
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCGroupJoinContent class]];
        //更新任务显示
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCTaskUpdateContent class]];
        //
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCGameMatchMessage class]];
        //
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCGameMathRobotContent class]];
        
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCGameRejectContent class]];
        
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCTaskUpdateContent class]];

        [[RCIMClient sharedRCIMClient] registerMessageType:[RCGameFriendStateContent class]];
        
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCNoticeTextContent class]];

        [[RCIMClient sharedRCIMClient] registerMessageType:[RCFriendOnlineContent class]];
        // 系统消息
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCSystemContent class]];
        
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCGameChangeContent class]];
        
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCBalanceUpdateContent class]];
        //弹幕
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCDanmuContent class]];
        //游戏接受
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCGameInviteAcceptContent class]];
        // 
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCFriendRemoveContent class]];
        
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCUnFriendContent class]];
        //奖池结束或开始
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCActivityAwardPoolEnd class]];
        //奖池跑马灯消息
        [[RCIMClient sharedRCIMClient] registerMessageType:[RCActivityHorseRace class]];
        
        
//        [[RCIMClient sharedRCIMClient] registerMessageType:[FSIMCommonMessage class]];
//        [[RCIMClient sharedRCIMClient] registerMessageType:[RCPayPicMessage class]];
//        [[RCIMClient sharedRCIMClient] registerMessageType:[RCLollyMailContent class]];
//        [[RCIMClient sharedRCIMClient] registerMessageType:[RCLollyPicBePayed class]];
//        [[RCIMClient sharedRCIMClient] registerMessageType:[RCPushMessageContent class]];
        _requestTokenAPI = [[FSRequestTokenAPI alloc] init];
        [_requestTokenAPI setDelegate:self];

//        _messageReceiptSever = [[FSMessageReceiptSever alloc] init];
    }
}

- (BOOL)FSIMIsConnected {
    return _IMConnected;
}

-(void)addDelegate:(id<FSIMClientReceiveMessageDelegate>)delegate {
    [_delegates addObject:delegate];
}

-(void)removeDelegate:(id<FSIMClientReceiveMessageDelegate>)delegate {
    [_delegates removeObject:delegate];
}

- (void)connetIMSever {
    [self initData];
    [self  achieveToken];
    if (!_token) {
        [self requestToken];
    }else{
        [[RCIMClient sharedRCIMClient] connectWithToken:_token
                                                success:^(NSString *userId) {
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGIN_IM_SUCCESS object:nil];
                                                    });
                                                    //登录成功才可初始化
                                                    [FSMessageUnRead launcher];
                                                    NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
                                                    self->_IMConnected = YES;
                                                    [[RCIMClient sharedRCIMClient] getBlacklist:^(NSArray *blockUserIds) {
                                                        [[FSFriendBlackListManager sharedManager] clearBlackList];
                                                        [[FSFriendBlackListManager sharedManager] insertBlackLists:blockUserIds];
                                                    } error:^(RCErrorCode status) {
                                                        
                                                    }];
//                                                    [self stopTimer];
                                                } error:^(RCConnectErrorCode status) {
                                                    NSLog(@"登陆的错误码为:%d", (int)status);
                                                    if (status == RC_CONN_TOKEN_INCORRECT || status == RC_CONN_NOT_AUTHRORIZED) {
                                                        [self requestToken];
                                                    }else if(status == RC_DISCONN_KICK){
//                                                        [self dealWithConnetStatus:FSIMConnectKicked_Offline_By_Other_Client];
                                                    }else if(status == RC_CONN_USER_BLOCKED){
//                                                        [self dealWithConnetStatus:FSIMConnectKicked_UserBlocked];
                                                    }
                                                } tokenIncorrect:^{
                                                    //token过期或者不正确。
                                                    //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                                                    //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                                                    NSLog(@"token错误");
                                                    [self requestToken];
                                                }];
    }
}

- (void)achieveToken {
    _token = (NSString*)[[FSFileCacheManager sharedInstance] objectForKey:[NSString stringWithFormat:@"%@%@",TOKEN_KEY,[LoginSDKManager shareManager].user.userId] fileType:FSFileCacheTypeDefault];
}

- (void)saveToken:(NSString*)token {
    [[FSFileCacheManager sharedInstance] addObject:token forKey:[NSString stringWithFormat:@"%@%@",TOKEN_KEY,[LoginSDKManager shareManager].user.userId] fileType:FSFileCacheTypeDefault];
}

//从服务器端获取token
- (void)requestToken {
    [self logout];
    if(![LoginSDKManager shareManager].isLogined){
        NSLog(@"登录还是失败");
        return;
    }
    [[FSFileCacheManager sharedInstance] removeObjectForKey:[NSString stringWithFormat:@"%@%@",TOKEN_KEY,[LoginSDKManager shareManager].user.userId] fileType:FSFileCacheTypeDefault];
    [_requestTokenAPI requestIMToken:[[FSGlobalLauncher launcher].allKeyDict objectForKey:KeyUser_chat_token]];
    
}

#pragma mark - FSRequestTokenAPIDelegate
    
- (void)fsRequestTokenAPISuccess:(FSRequestTokenResult *)result {
    [self saveToken:result.dataInfo];
    [self connetIMSever];
}

- (void)fsRequestTokenAPIFailed:(NSError *)error {
    [self requestToken];
}

- (void)logout {
    [[FSFriendBlackListManager sharedManager] clearBlackList];
    [[RCIMClient sharedRCIMClient] disconnect:YES];
}


- (FSIMMessage*)sendMessage:(FSIMMessage*)message {
    if ([message.content isKindOfClass:[FSIMTextMessage class]]) {
        // 构建消息的内容，普通文本消息。
        FSIMTextMessage* textMessage = (FSIMTextMessage*) message.content;
        RCTextMessage *rcTextMessage = [RCTextMessage messageWithContent:textMessage.content];
        // 调用RCIMClient的sendMessage方法进行发送，结果会通过回调进行反馈。
        RCMessage* rcMessage = [[RCIMClient sharedRCIMClient] sendMessage:(RCConversationType)message.conversationType
                                                                 targetId:message.targetId
                                                                  content:rcTextMessage
                                                              pushContent:message.pushContent
                                                                 pushData:message.pushData
                                                                  success:^(long messageId) {
                                                                      NSLog(@"发送成功。当前消息ID：%ld", messageId);
                                                                      [self sendMessageSucess:messageId];
                                                                  } error:^(RCErrorCode nErrorCode, long messageId) {
                                                                      [self sendMessageFailed:nErrorCode messageId:messageId];
                                                                      NSLog(@"发送失败。消息ID：%ld， 错误码：%d", messageId, (int)nErrorCode);
                                                                  }];
        FSIMMessage* message = [self copyRCMessage:rcMessage];
        return message;
    }else if ([message.content isKindOfClass:[FSIMCommandMessage class]]) {
        // 构建消息的内容，命令文本消息。
        FSIMCommandMessage* commandMessage = (FSIMCommandMessage*) message.content;
        RCCommandMessage *rcCommandMessage =  [RCCommandMessage messageWithName:commandMessage.name data:commandMessage.data];
        RCMessage* rcMessage = [[RCIMClient sharedRCIMClient] sendMessage:(RCConversationType)message.conversationType
                                                                 targetId:message.targetId
                                                                  content:rcCommandMessage
                                                              pushContent:message.pushContent
                                                                 pushData:message.pushData
                                                                  success:^(long messageId) {
                                                                      [self sendMessageSucess:messageId];
                                                                      NSLog(@"发送成功。当前消息ID：%ld", messageId);
                                                                  } error:^(RCErrorCode nErrorCode, long messageId) {
                                                                      [self sendMessageFailed:nErrorCode messageId:messageId];
                                                                      NSLog(@"发送失败。消息ID：%ld， 错误码：%d", messageId, (int)nErrorCode);
                                                                  }];
        FSIMMessage* message = [self copyRCMessage:rcMessage];
        return message;
    }else if ([message.content isKindOfClass:[FSIMVoiceMessage class]]) {
        // 构建消息的内容，命令文本消息。
        FSIMVoiceMessage* voiceMessage = (FSIMVoiceMessage*) message.content;
        RCVoiceMessage *rcVoiceMessage =  [RCVoiceMessage messageWithAudio:voiceMessage.wavAudioData duration:voiceMessage.duration];
        RCMessage* rcMessage = [[RCIMClient sharedRCIMClient] sendMessage:(RCConversationType)message.conversationType
                                                                 targetId:message.targetId
                                                                  content:rcVoiceMessage
                                                              pushContent:message.pushContent
                                                                 pushData:message.pushData
                                                                  success:^(long messageId) {
                                                                      [self sendMessageSucess:messageId];
                                                                      NSLog(@"发送成功。当前消息ID：%ld", messageId);
                                                                  } error:^(RCErrorCode nErrorCode, long messageId) {
                                                                      [self sendMessageFailed:nErrorCode messageId:messageId];
                                                                      NSLog(@"发送失败。消息ID：%ld， 错误码：%d", messageId, (int)nErrorCode);
                                                                  }];
        FSIMMessage* message = [self copyRCMessage:rcMessage];
        return message;
    }
    return nil;
}


- (void)sendMessageSucess:(NSInteger)messageId {
    NSArray *tmpArray = [NSArray arrayWithArray:_delegates];
    for(id<FSIMClientReceiveMessageDelegate> delegate in tmpArray) {
        if ([delegate respondsToSelector:@selector(sendMessageSucess:)]) {
            [delegate sendMessageSucess:messageId];
        }
    }
}

- (void)sendMessageFailed:(RCErrorCode)errorCode messageId:(NSInteger)messageId{
    NSArray *tmpArray = [NSArray arrayWithArray:_delegates];
    for(id<FSIMClientReceiveMessageDelegate> delegate in tmpArray) {
        if ([delegate respondsToSelector:@selector(sendMessageFailed:messageId:)]) {
            [delegate sendMessageFailed:(FSIMErrorCode)errorCode messageId:messageId];
        }
    }
}

- (int)totalUnreadCount {
    return [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
}

- (void)setDeviceToken:(NSString *)deviceToken {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[RCIMClient sharedRCIMClient] setDeviceToken:deviceToken];
    });
}

- (FSIMMessage *)insertMessage:(FSConversationType)conversationType
                      targetId:(NSString *)targetId
                    sendStatus:(FSIMSentStatus)sendStatus
                       content:(FSIMMessageContent *)content {
    RCMessageContent* rcContent = [self copyFSIMMessageContent:content];
    RCMessage* rcMessage = [[RCIMClient sharedRCIMClient] insertOutgoingMessage:(RCConversationType)conversationType targetId:targetId sentStatus:(RCSentStatus)sendStatus content:rcContent];
    return [self copyRCMessage:rcMessage];
}

- (FSIMMessage *)insertIncomeMessage:(FSConversationType)conversationType
                      targetId:(NSString *)targetId
                    senderUserId:(NSString *)senderUserId
                       content:(FSIMMessageContent *)content {
    RCMessageContent* rcContent = [self copyFSIMMessageContent:content];
    RCMessage* rcMessage = [[RCIMClient sharedRCIMClient] insertIncomingMessage:(RCConversationType)conversationType targetId:targetId senderUserId:senderUserId receivedStatus:(ReceivedStatus_READ) content:rcContent];
    return [self copyRCMessage:rcMessage];
}

- (int)getUnreadCount:(FSConversationType)conversationType targetId:(NSString *)targetId {
    return [[RCIMClient sharedRCIMClient] getUnreadCount:(RCConversationType)conversationType targetId:targetId];
}

- (int)getUnreadCount:(NSArray *)conversationTypes  {
    return [[RCIMClient sharedRCIMClient] getUnreadCount:conversationTypes];
}

- (BOOL)clearMessagesUnreadStatus:(FSConversationType)conversationType targetId:(NSString *)targetId {
    return [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:(RCConversationType)conversationType targetId:targetId];
}

- (NSArray<FSConversation *> *)conversationList {
    NSArray *conversationList = [[RCIMClient sharedRCIMClient]
                                 getConversationList:@[@(ConversationType_PRIVATE),
                                                       @(ConversationType_DISCUSSION),
                                                       @(ConversationType_GROUP),
                                                       @(ConversationType_SYSTEM),
                                                       @(ConversationType_APPSERVICE),
                                                       @(ConversationType_PUBLICSERVICE)]];
    
    NSMutableArray *fsConversationList = [NSMutableArray array];
    for (RCConversation *conversation in conversationList) {
        NSLog(@"会话类型：%lu，目标会话ID：%@", (unsigned long)conversation.conversationType, conversation.targetId);
        FSConversation* fsConversation = [self copyRCConversation:conversation];
        [fsConversationList addObject:fsConversation];
    }
    return fsConversationList;
}
- (FSConversation *)getConversation:(FSConversationType)conversationType targetId:(NSString *)targetId {
    RCConversation* conversation = [[RCIMClient sharedRCIMClient] getConversation:(RCConversationType)conversationType targetId:targetId];
    return [self copyRCConversation:conversation];
}

- (NSArray *)getLatestMessages:(FSConversationType)conversationType
                      targetId:(NSString *)targetId
                         count:(int)count{
    NSArray* rcMessageArray = [[RCIMClient sharedRCIMClient] getLatestMessages:(RCConversationType)conversationType targetId:targetId count:count];
    NSMutableArray *fsMesssageList = [NSMutableArray array];
    for (RCMessage *message in rcMessageArray) {
        FSIMMessage* fsMessage = [self copyRCMessage:message];
        [fsMesssageList addObject:fsMessage];
    }
    return fsMesssageList;
}

- (NSArray *)getHistoryMessages:(FSConversationType)conversationType
                       targetId:(NSString *)targetId
                oldestMessageId:(long)oldestMessageId
                          count:(int)count {
    NSArray* rcMessageArray = [[RCIMClient sharedRCIMClient] getHistoryMessages:(RCConversationType)conversationType targetId:targetId oldestMessageId:oldestMessageId count:count];
    NSMutableArray *fsMesssageList = [NSMutableArray array];
    for (RCMessage *message in rcMessageArray) {
        FSIMMessage* fsMessage = [self copyRCMessage:message];
        [fsMesssageList addObject:fsMessage];
    }
    return fsMesssageList;
}

- (BOOL)deleteMessages:(NSArray *)messageIds {
    return [[RCIMClient sharedRCIMClient] deleteMessages:messageIds];
}

- (BOOL)clearMessages:(FSConversationType)conversationType targetId:(NSString *)targetId {
    return [[RCIMClient sharedRCIMClient] clearMessages:(RCConversationType)conversationType targetId:targetId];
}

- (BOOL)setMessageExtra:(long)messageId value:(NSString *)value {
    return [[RCIMClient sharedRCIMClient] setMessageExtra:messageId value:value];
}

- (BOOL)setMessageSentStatus:(long)messageId sentStatus:(FSIMSentStatus)sentStatus {
    return [[RCIMClient sharedRCIMClient] setMessageSentStatus:messageId sentStatus:(RCSentStatus)sentStatus];
}

- (BOOL)clearConversations:(NSArray *)conversationTypeList {
    return [[RCIMClient sharedRCIMClient] clearConversations:conversationTypeList];
}

- (BOOL)removeConversation:(FSConversationType)conversationType targetId:(NSString *)targetId {
    return [[RCIMClient sharedRCIMClient] removeConversation:(RCConversationType)conversationType targetId:targetId];
}

- (BOOL)setConversationToTop:(FSConversationType)conversationType targetId:(NSString *)targetId isTop:(BOOL)isTop {
    return [[RCIMClient sharedRCIMClient] setConversationToTop:(RCConversationType)conversationType targetId:targetId isTop:isTop];
}

- (NSString *)getTextMessageDraft:(FSConversationType)conversationType targetId:(NSString *)targetId {
    return [[RCIMClient sharedRCIMClient] getTextMessageDraft:(RCConversationType)conversationType targetId:targetId];
}

- (BOOL)saveTextMessageDraft:(FSConversationType)conversationType targetId:(NSString *)targetId content:(NSString *)content {
    return [[RCIMClient sharedRCIMClient] saveTextMessageDraft:(RCConversationType)conversationType targetId:targetId content:content];
}

- (BOOL)clearTextMessageDraft:(FSConversationType)conversationType targetId:(NSString *)targetId {
    return [[RCIMClient sharedRCIMClient] clearTextMessageDraft:(RCConversationType)conversationType targetId:targetId];
}

- (void)addToBlacklist:(NSString *)userId success:(void (^)())successBlock error:(void (^)())errorBlock {
    [[RCIMClient sharedRCIMClient] addToBlacklist:userId success:successBlock error:errorBlock];
}

- (void)removeFromBlacklist:(NSString *)userId success:(void (^)())successBlock error:(void (^)())errorBlock {
    [[RCIMClient sharedRCIMClient] removeFromBlacklist:userId success:successBlock error:errorBlock];
}

- (void)getBlacklistStatus:(NSString *)userId success:(void (^)(int bizStatus))successBlock error:(void (^)())errorBlock {
    [[RCIMClient sharedRCIMClient] getBlacklistStatus:userId success:successBlock error:errorBlock];
}

- (void)getBlacklist:(void (^)(NSArray *blockUserIds))successBlock error:(void (^)())errorBlock {
    [[RCIMClient sharedRCIMClient] getBlacklist:successBlock error:errorBlock];
}


#pragma mark - RCIMClientReceiveMessageDelegate
- (void)onReceived:(RCMessage *)message left:(int)nLeft object:(id)object {
    
//    NSLog(@"RCIMClientReceiveMessageDelegate %@",message.content);
    
    // 被删除了
    if ([message.content isKindOfClass:[RCFriendRemoveContent class]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationDidRemovedByUser object:message.senderUserId];
        });
        return;
    }
    
    if ([message.content isKindOfClass:[RCBalanceUpdateContent class]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            FSUserInfoModel *userInfo = (FSUserInfoModel *)[LoginSDKManager shareManager].user;
            RCBalanceUpdateContent *content = (RCBalanceUpdateContent *)message.content;
            for (FSVpBalanceData *data in content.balance) {
                if (data.vpType == 0) {
                    userInfo.goldNumber = data.currentVpBalance;
                }else if (data.vpType == 1){
                    userInfo.diamondNumber = data.currentVpBalance;
                }
            }
            
            [[LoginSDKManager shareManager] updateUserInfo:userInfo];
        });
        return;
    }
    
    if ([[FSFriendBlackListManager sharedManager].blackListIds containsObject:message.targetId]) {
        // 黑名单
        return;
    }
    
    // for appstore
    BOOL shouldDisplay = [[FSUpgradeServer sharedInstance] shouldDisplayGameInfo];
    if (!shouldDisplay) {
        NSArray *blockIds = [FSBlackListFile ConfigInfo];
        if ([blockIds containsObject:message.targetId]) {
            return;
        }
    }
    
    
    NSString *notificationName = kNSNotificationRongClientReceiveMessage;
    
    FSIMMessage* fsMessage = [self copyRCMessage:message];
    
    if ([fsMessage.content isKindOfClass:[FSIMGameChangeContent class]]) {
        //
        [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationUserSwitchGame object:fsMessage];
        return;
    }
    

    // 处理动作
    BOOL shouldPostCheckUnRead = NO;
    if([fsMessage.content isKindOfClass:[FSIMAddFriendsContent class]]){
        //添加好友消息
        notificationName =kNSNotificationFRIEND_ADDMessage;
        
        //---------------------------------------------
        FSIMAddFriendsContent *addMessage = (FSIMAddFriendsContent *)fsMessage.content;
        NSString *userId = [[addMessage.mExtern mj_JSONObject] valueForKeyPath:@"userId"];
        //保存当前消息数
        [[FSMessageUnRead launcher] addFridensMessageNumber:userId];
        //---------------------------------------------
        
        // 非活动状态 显示本地推送
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *name = [[addMessage.mExtern mj_JSONObject] valueForKey:MessageExtraKeyName];
            
            UIApplicationState applicationState = [[UIApplication sharedApplication] applicationState];
            BOOL canShowNotification = (applicationState != UIApplicationStateActive);
            if (canShowNotification) {
                // 本地推送
                
                NSString *addFriendMessage = [FSSharedLanguages CustomLocalizedStringWithKey:@"AllPage_AppliesToAdd"];
                if (name.length == 0) {
                    name = @"Some one";
                }
                addFriendMessage = [addFriendMessage stringByReplacingOccurrencesOfString:@"(s)" withString:name];
                [FSLocalNotificationMananger showNotificationWithMessage:addFriendMessage];
            }
        });
    }else if ([fsMessage.content isKindOfClass:[FSIMAgreeAddFriednsContent class]]) {
        //同意添加好友消息
        notificationName =kNSNotificationFRIEND_AGREEMessage;
        shouldPostCheckUnRead = YES;
    }else if ([fsMessage.content isKindOfClass:[FSIMFriendsMessageContent class]]) {
        //发送聊天消息
        notificationName =kNSNotificationFRIEND_CUSTOM_MESSAGE;
        shouldPostCheckUnRead = YES;
        
        FSIMFriendsMessageContent *content = (FSIMFriendsMessageContent *)fsMessage.content;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIApplicationState applicationState = [[UIApplication sharedApplication] applicationState];
            BOOL canShowNotification = (applicationState != UIApplicationStateActive);
            if (canShowNotification) {
                [FSLocalNotificationMananger showNotificationWithMessageWithContent:fsMessage.content];
            }
        });

        NSString *key = [NSString stringWithFormat:@"DataSta_IM_Receive_Friends"];
        NSDictionary *contentJson = @{@"senderUserId":fsMessage.senderUserId,@"messageType":content.messageType};
        NSDictionary *param = @{@"content":contentJson.mj_JSONString};
        [RyzeMagicStatics ryze_addEventName:key withParams:param];
        
    }else if ([fsMessage.content isKindOfClass:[FSIMGameInviteContent class]]) {
        //游戏邀请消息
        notificationName =kNSNotificationGAME_INVITEMessage;
        shouldPostCheckUnRead = YES;

        
    }else if ([fsMessage.content isKindOfClass:[FSIMGroupJoinContent class]]) {
        //聊天室进入消息
        notificationName = kNSNotificationGROUP_JOINMessage;
    }else if ([fsMessage.content isKindOfClass:[FSGameInviteAcceptContent class]]){
        notificationName = kNSNotificationGROUP_RoobotJOINMessage;
    }else if ([fsMessage.content isKindOfClass:[FSIMGameMatchContent class]] || [fsMessage.content isKindOfClass:[FSGameMatchRobotContent class]]) {
        notificationName =kNSNotificationGameMatchSuccess;
    }else if ([fsMessage.content isKindOfClass:[FSGameRejectContent class]]){
        notificationName =kNSNotificationGameInviteReject;
    }else if ([fsMessage.content isKindOfClass:[FSIMTaskUpdateContent class]]){
        notificationName = kNSNotificationTaskStateUpdate;
    } else if ([fsMessage.content isKindOfClass:[FSIMGameFriendStateMessage class]]) {
        notificationName = kNSNotificationFriendGameStateChangedMessage;
        shouldPostCheckUnRead = YES;
    } else if ([fsMessage.content isKindOfClass:[FSIMFriendOnlineMessage class]]) {
        notificationName = kNSNotificationFrieneOnlineStateChanged;
    } else if ([fsMessage.content isKindOfClass:[FSIMSystemContent class]]) {
        notificationName = kNSNotificationNewSystemMessage;
        shouldPostCheckUnRead = YES;
        //
        FSIMSystemContent *content = (FSIMSystemContent *)fsMessage.content;
        // 官方消息到达数
        dispatch_async(dispatch_get_main_queue(), ^{
            UIApplicationState applicationState = [[UIApplication sharedApplication] applicationState];
            BOOL canShowNotification = (applicationState != UIApplicationStateActive);
            if (canShowNotification) {
                NSString *systemMessage = [content getContentDetailString];
                [FSLocalNotificationMananger showNotificationWithMessage:systemMessage];
            }
        });
        NSString *key = [NSString stringWithFormat:@"DataSta_IM_Click_Ready"];
        NSString *tempValue = [NSString stringWithFormat:@"%ld",content.systemTemplate];
        NSDictionary *contentJson = @{@"systemTemplate":tempValue};
        NSDictionary *param = @{@"content":contentJson.mj_JSONString};
        [RyzeMagicStatics ryze_addEventName:key withParams:param];
        
    }else if ([fsMessage.content isKindOfClass:[FSIMDanmuContent class]]) {
        //接收弹幕消息
        notificationName = kNSNotificationReceiveOtherPeopleDanMuMessage;
         //FSIMDanmuContent *danmuContent = (FSIMDanmuContent *)fsMessage.content;
    }else if ([fsMessage.content isKindOfClass:[FSIMActivityAwardPoolEnd class]]){
        //奖池开始结束消息
        notificationName = kNSNotificationActivityAwardPoolEndOrBegin;
        
    }else if ([fsMessage.content isKindOfClass:[FSIMActivityHorseRace class]]){
        //奖池活动跑马灯消息
        notificationName = kNSNotificationAwardPoolActivityHorseRace;
    }
    
//    NSLog(@"RCIMClientReceiveMessageDelegate Receive Message %@ %@",NSStringFromClass([fsMessage.content class]),notificationName);
    if (shouldPostCheckUnRead) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationRefreshRedPointState object:nil];
    }
    
    if ([notificationName isEqualToString:kNSNotificationGROUP_JOINMessage]) {
        // 这个消息有提前到情况 做延时发送 给UI充足的时间做动画
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:fsMessage];
        });
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:fsMessage];
    }
    
    NSArray *tmpArray = [NSArray arrayWithArray:_delegates];
    for(id<FSIMClientReceiveMessageDelegate> delegate in tmpArray) {
        if ([delegate respondsToSelector:@selector(onReceived:left:)]) {
            [delegate onReceived:fsMessage left:nLeft];
        }
    }
    
    [self showLocalNotification];
}
- (void)showLocalNotification {
    

}

#pragma mark - RCConnectionStatusChangeDelegate
- (void)onConnectionStatusChanged:(RCConnectionStatus)status{
    NSLog(@"RCConnectionStatus: %d",(int)status);
    if(status == ConnectionStatus_TOKEN_INCORRECT) {
        [self requestToken];
        return;
    }else if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        [self dealWithConnetStatus:FSIMConnectKicked_Offline_By_Other_Client];
        return;
    }else if (status == ConnectionStatus_SignUp){
        return;
    }
    
    if (status == ConnectionStatus_Connected) {
        [self stopTimer];
    }else{
        [self startTimer];
    }
}

#pragma mark - 内部方法

- (void)startTimer {
    [self stopTimer];
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(timerCount) userInfo:nil repeats:NO];
    }
}

- (void)stopTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)timerCount {
    [self logout];
    [self connetIMSever];
    [self dealWithConnetStatus:FSIMConnectTimeOut];
}

- (void)dealWithConnetStatus:(FSIIMConnectStatus)status {
//    NSArray *tmpArray = [NSArray arrayWithArray:_delegates];
//    for(id<FSIMClientReceiveMessageDelegate> delegate in tmpArray) {
//        if ([delegate respondsToSelector:@selector(onConnectionStatusChanged:)]) {
//            [delegate onConnectionStatusChanged:status];
//        }
//    }
    if (status == FSIMConnectKicked_Offline_By_Other_Client) {
        [FSAppLanucher launcher].isForce = YES;
        [[FSAppLanucher launcher] forceLogout];
    }
}

- (FSIMMessage*)copyRCMessage:(RCMessage*)message{
    FSIMMessage* newMessage = [[FSIMMessage alloc] init];
    newMessage.conversationType = (FSConversationType)message.conversationType;
    newMessage.targetId = message.targetId;
    newMessage.messageId = message.messageId;
    newMessage.messageDirection = (FSIMMessageDirection)message.messageDirection;
    newMessage.senderUserId = message.senderUserId;
    newMessage.sentTime = message.sentTime;
    newMessage.receivedTime = message.receivedTime;
    newMessage.sentStatus = (FSIMSentStatus)message.sentStatus;
    newMessage.receivedStatus = (FSIMReceivedStatus)message.receivedStatus;
    newMessage.objectName = message.objectName;
    newMessage.messageUId = message.messageUId;
    newMessage.extra = message.extra;
    newMessage.content.senderUserInfo = [[FSIMUserInfo alloc] initWithUserId:message.content.senderUserInfo.userId name:message.content.senderUserInfo.name portrait:message.content.senderUserInfo.portraitUri];
    if ([message.content isKindOfClass:[RCTextMessage class]]) {
        RCTextMessage *rcTextMessage = (RCTextMessage *)message.content;
        FSIMTextMessage *fsTextMessage = [[FSIMTextMessage alloc] init];
        fsTextMessage.content = rcTextMessage.content;
        newMessage.content = fsTextMessage;
    }else if ([message.content isKindOfClass:[RCCommandMessage class]]) {
        RCCommandMessage *rcCommandMessage = (RCCommandMessage *)message.content;
        FSIMCommandMessage *fsCommandMessage =  [FSIMCommandMessage messageWithName:rcCommandMessage.name data:rcCommandMessage.data];
        newMessage.content = fsCommandMessage;
    }else if ([message.content isKindOfClass:[RCVoiceMessage class]]) {
        RCVoiceMessage *rcVoiceMessage = (RCVoiceMessage*)message.content;
        FSIMVoiceMessage *fsVoiceMessage = [FSIMVoiceMessage messageWithAudio:rcVoiceMessage.wavAudioData duration:rcVoiceMessage.duration];
        newMessage.content = fsVoiceMessage;
    }else if ([message.content isKindOfClass:[RCImageMessage class]]){
        RCImageMessage *rcImageMessage = (RCImageMessage*)message.content;
        FSIMImageMessage *fsImageMessage = [[FSIMImageMessage alloc] init];
        fsImageMessage.full = rcImageMessage.full;
        fsImageMessage.thumbnailImage = rcImageMessage.thumbnailImage;
        fsImageMessage.imageUrl = rcImageMessage.imageUrl;
        fsImageMessage.localPath = rcImageMessage.localPath;
        fsImageMessage.originalImage = rcImageMessage.originalImage;
        newMessage.content = fsImageMessage;
    }else if ([message.content isKindOfClass:[FSIMCommonMessage class]]) {
        FSIMCommonMessage *rcCommandMessage = (FSIMCommonMessage *)message.content;
        FSIMDefineMessageContent *fsCommandMessage =  [FSIMDefineMessageContent messageWithName:rcCommandMessage.name data:rcCommandMessage.data];
        newMessage.content = fsCommandMessage;
    }else if ([message.content isKindOfClass:[RCPayPicMessage class]]) {
        RCPayPicMessage *payPicMessage = (RCPayPicMessage*)message.content;
        FSIMPayPicMessage *fsPayPicMessage =  [FSIMPayPicMessage messageWithName:payPicMessage.name data:payPicMessage.data];
        fsPayPicMessage.soureImage = payPicMessage.soureImage;
        fsPayPicMessage.thumbImage = payPicMessage.thumbImage;
        fsPayPicMessage.localThumbImage = payPicMessage.localThumbImage;
        fsPayPicMessage.localSoureImage = payPicMessage.localSoureImage;
        newMessage.content = fsPayPicMessage;
    }else if ([message.content isKindOfClass:[RCAddFriendsContent class]]) {
        RCAddFriendsContent *addFriendsMessage = (RCAddFriendsContent *)message.content;
      
        FSIMAddFriendsContent *fsMessage =  [[FSIMAddFriendsContent alloc] init];
        fsMessage.mExtern = addFriendsMessage.mExtern;
        fsMessage.fromUserId = addFriendsMessage.fromUserId;
        fsMessage.st = addFriendsMessage.st;
        fsMessage.type = addFriendsMessage.type;
        fsMessage.sendTargetId = message.targetId;
        newMessage.content = fsMessage;
    }else if ([message.content isKindOfClass:[RCAgreeAddFriednsContent class]]) {
        RCAgreeAddFriednsContent *agreeFriendsMessage = (RCAgreeAddFriednsContent *)message.content;
        
        FSIMAgreeAddFriednsContent *fsMessage =  [[FSIMAgreeAddFriednsContent alloc] init];
        fsMessage.mExtern =agreeFriendsMessage.mExtern;
        fsMessage.type =agreeFriendsMessage.type;
        fsMessage.fromUserId = agreeFriendsMessage.fromUserId;

        
        // 本地刷新
        newMessage.content = fsMessage;
    }else if ([message.content isKindOfClass:[RCFriendsMessageContent class]]) {
        RCFriendsMessageContent *friendsMessage = (RCFriendsMessageContent *)message.content;
        
        FSIMFriendsMessageContent *fsMessage =  [[FSIMFriendsMessageContent alloc] init];
        fsMessage.mExtern =friendsMessage.mExtern;
        fsMessage.type =friendsMessage.type;
        fsMessage.messageType =friendsMessage.messageType;
        fsMessage.message =friendsMessage.message;
        
        newMessage.content = fsMessage;
        
    }else if ([message.content isKindOfClass:[RCGameInviteContent class]]) {
        RCGameInviteContent *gameInviteMessage = (RCGameInviteContent *)message.content;
        
        FSIMGameInviteContent *fsMessage =  [[FSIMGameInviteContent alloc] init];
        fsMessage.mExtern =gameInviteMessage.mExtern;
        fsMessage.fromUserId = gameInviteMessage.fromUserId;
        fsMessage.st =gameInviteMessage.st;
        fsMessage.type =gameInviteMessage.type;
        fsMessage.gameId =gameInviteMessage.gameId;
        fsMessage.groupType =gameInviteMessage.groupType;
        fsMessage.gameName =gameInviteMessage.gameName;
        fsMessage.groupId =gameInviteMessage.groupId;
        
        newMessage.content = fsMessage;
        
    }else if ([message.content isKindOfClass:[RCGroupJoinContent class]]) {
        RCGroupJoinContent *groupJoinMessage = (RCGroupJoinContent *)message.content;
        FSIMGroupJoinContent *fsMessage =  [[FSIMGroupJoinContent alloc] init];
        fsMessage.mExtern =groupJoinMessage.mExtern;
        fsMessage.type =groupJoinMessage.type;
        fsMessage.onlineNumber =groupJoinMessage.onlineNumber;
        fsMessage.roomNumber =groupJoinMessage.roomNumber;
        fsMessage.userInfo =groupJoinMessage.userInfo;
        fsMessage.groupType =groupJoinMessage.groupType;
        fsMessage.groupId =groupJoinMessage.groupId;
        fsMessage.userId =groupJoinMessage.userId;
        newMessage.content = fsMessage;
    }else if([message.content isKindOfClass:[RCGameInviteAcceptContent class]]){
        RCGameInviteAcceptContent *gameAccept = (RCGameInviteAcceptContent *)message.content;
        FSGameInviteAcceptContent *fsMessage = [[FSGameInviteAcceptContent alloc] init];
        fsMessage.groupType = gameAccept.groupType;
        fsMessage.groupId = gameAccept.groupId;
        fsMessage.userType = gameAccept.userType;
        newMessage.content = fsMessage;
    }else if ([message.content isKindOfClass:[RCGameMatchMessage class]]){
        RCGameMatchMessage *matchMessage = (RCGameMatchMessage *)message.content;
        FSIMGameMatchContent *gameMatchContent = [[FSIMGameMatchContent alloc] init];
        gameMatchContent.mExtern = matchMessage.mExtern;
        gameMatchContent.type = matchMessage.type;
        gameMatchContent.groupId = matchMessage.groupId;
        gameMatchContent.groupType = matchMessage.groupType;
        [gameMatchContent setUsers:matchMessage.users];
        newMessage.content = gameMatchContent;
    }else if ([message.content isKindOfClass:[RCGameMathRobotContent class]]){
        RCGameMathRobotContent *matchMessage = (RCGameMathRobotContent *)message.content;
        FSGameMatchRobotContent *gameMatchContent = [[FSGameMatchRobotContent alloc] init];
        gameMatchContent.mExtern = matchMessage.mExtern;
        gameMatchContent.type = matchMessage.type;
        gameMatchContent.groupId = matchMessage.groupId;
        [gameMatchContent setUsers:matchMessage.users];
        newMessage.content = gameMatchContent;
        
    }else if ([message.content isKindOfClass:[RCGameRejectContent class]]){
        RCGameRejectContent *gameReject = (RCGameRejectContent *)message.content;
        FSGameRejectContent *fsgameReject = [[FSGameRejectContent alloc] init];
        fsgameReject.mExtern = gameReject.mExtern;
        fsgameReject.type = gameReject.type;
        fsgameReject.groupId = gameReject.groupId;
        newMessage.content = fsgameReject;
    }else if ([message.content isKindOfClass:[RCTaskUpdateContent class]]){
        RCTaskUpdateContent *taskUpdate = (RCTaskUpdateContent *)message.content;
        FSIMTaskUpdateContent *fstaskUpdate = [[FSIMTaskUpdateContent alloc] init];
        fstaskUpdate.mExtern = taskUpdate.mExtern;
        fstaskUpdate.mtype = taskUpdate.mtype;
        fstaskUpdate.taskId = taskUpdate.taskId;
        newMessage.content = fstaskUpdate;
    }else if ([message.content isKindOfClass:[RCNoticeTextContent class]]){
        RCNoticeTextContent *notice = (RCNoticeTextContent *)message.content;
        FSIMNoticeTextContent *fsnotice = [[FSIMNoticeTextContent alloc] init];
        fsnotice.mExtern = notice.mExtern;
        fsnotice.noticeTextKey = notice.noticeTextKey;
        fsnotice.noticeTextStr = notice.noticeTextStr;
        newMessage.content = fsnotice;
    } else if ([message.content isKindOfClass:[RCGameFriendStateContent class]]) {
        //
        RCGameFriendStateContent *friendState = (RCGameFriendStateContent *)message.content;
        FSIMGameFriendStateMessage *friendStateMessage = [[FSIMGameFriendStateMessage alloc] init];
        friendStateMessage.gameId = friendState.gameId;
        friendStateMessage.gameRoomId = friendState.gameRoomId;
        friendStateMessage.gameState = friendState.gameState;
        newMessage.content = friendStateMessage;
    } else if ([message.content isKindOfClass:[RCFriendOnlineContent class]]) {
        RCFriendOnlineContent *onlineContent = (RCFriendOnlineContent *)message.content;
        FSIMFriendOnlineMessage *onlineMessage = [[FSIMFriendOnlineMessage alloc] init];
        onlineMessage.online = onlineContent.online;
        newMessage.content = onlineMessage;
    } else if ([message.content isKindOfClass:[RCSystemContent class]]) {
        RCSystemContent *system = (RCSystemContent *)message.content;
        FSIMSystemContent *fsSystem = [[FSIMSystemContent alloc] init];
        fsSystem.systemTemplate = system.systemTemplate;
        fsSystem.image = system.image;
        fsSystem.link = system.link;
        fsSystem.linkContent = system.linkContent;
        fsSystem.titleContent = system.titleContent;
        fsSystem.content = system.content;
        newMessage.content = fsSystem;
    }else if ([message.content isKindOfClass:[RCGameChangeContent class]]){
        RCGameChangeContent *change = (RCGameChangeContent *)message.content;
        FSIMGameChangeContent *fsmessage = [[FSIMGameChangeContent alloc] init];
        fsmessage.fromUserId = change.fromUserId;
        fsmessage.st = change.st;
        newMessage.content = fsmessage;
    }else if ([message.content isKindOfClass:[RCDanmuContent class]]) {
        
        RCDanmuContent *danmuContent = (RCDanmuContent *)message.content;
        FSIMDanmuContent *imDanMuContent = [[FSIMDanmuContent alloc] init];
        imDanMuContent.danmuDict =danmuContent.danmuDict;
        
        newMessage.content = imDanMuContent;
        
    }else if ([message.content isKindOfClass:[RCUnFriendContent class]]){
        RCUnFriendContent *unfriend = (RCUnFriendContent *)message.content;
        FSUnFriendContent *fsUnfriend = [[FSUnFriendContent alloc] init];
        fsUnfriend.tipType = unfriend.tipType;
        newMessage.content = fsUnfriend;
    }else if ([message.content isKindOfClass:[RCActivityAwardPoolEnd class]]){
        
        RCActivityAwardPoolEnd *awardPool = (RCActivityAwardPoolEnd *)message.content;
        FSIMActivityAwardPoolEnd *imAwardPool =[[FSIMActivityAwardPoolEnd alloc] init];
        imAwardPool.awardPoolDict =awardPool.awardPoolDict;
        
        newMessage.content = imAwardPool;
        
    }else if ([message.content isKindOfClass:[RCActivityHorseRace class]]){
        
        RCActivityHorseRace *horseRace = (RCActivityHorseRace *)message.content;
        FSIMActivityHorseRace *imHorseRace =[[FSIMActivityHorseRace alloc] init];
        imHorseRace.marqueeInfo =horseRace.marqueeInfo;
        
        newMessage.content = imHorseRace;
    }
    
    return newMessage;
}

- (FSConversation*)copyRCConversation:(RCConversation*)coversation{
    FSConversation* fsCoversation = [[FSConversation alloc] init];
    fsCoversation.conversationType = (FSConversationType)coversation.conversationType;
    fsCoversation.targetId = coversation.targetId;
    fsCoversation.conversationTitle = coversation.conversationTitle;
    fsCoversation.unreadMessageCount = coversation.unreadMessageCount;
    fsCoversation.isTop = coversation.isTop;
    fsCoversation.receivedStatus = (FSIMReceivedStatus)coversation.receivedStatus;
    fsCoversation.sentStatus = (FSIMSentStatus)coversation.sentStatus;
    fsCoversation.receivedTime = coversation.receivedTime;
    fsCoversation.sentTime = coversation.sentTime;
    fsCoversation.draft = coversation.draft;
    fsCoversation.objectName = coversation.objectName;
    fsCoversation.senderUserId = coversation.senderUserId;
    fsCoversation.lastestMessageId = coversation.lastestMessageId;
    fsCoversation.lastestMessageDirection = coversation.lastestMessageDirection;
    fsCoversation.jsonDict = coversation.jsonDict;
    fsCoversation.lastestMessageUId = coversation.lastestMessageUId;
    fsCoversation.hasUnreadMentioned = coversation.hasUnreadMentioned;
    if ([coversation.lastestMessage isKindOfClass:[RCTextMessage class]]) {
        RCTextMessage *rcTextMessage = (RCTextMessage *)coversation.lastestMessage;
        FSIMTextMessage *fsTextMessage = [[FSIMTextMessage alloc] init];
        fsTextMessage.content = rcTextMessage.content;
        fsCoversation.lastestMessage = fsTextMessage;
    }else if ([coversation.lastestMessage isKindOfClass:[RCVoiceMessage class]]) {
        RCVoiceMessage *rcVoiceMessage = (RCVoiceMessage*)coversation.lastestMessage;
        FSIMVoiceMessage *fsVoiceMessage = [FSIMVoiceMessage messageWithAudio:rcVoiceMessage.wavAudioData duration:rcVoiceMessage.duration];
        fsCoversation.lastestMessage = fsVoiceMessage;
    }else if ([coversation.lastestMessage isKindOfClass:[RCPayPicMessage class]]) {
        RCPayPicMessage *payPicMessage = (RCPayPicMessage*)coversation.lastestMessage;
        FSIMPayPicMessage *fsPayPicMessage =  [FSIMPayPicMessage messageWithName:payPicMessage.name data:payPicMessage.data];
        fsPayPicMessage.soureImage = payPicMessage.soureImage;
        fsPayPicMessage.thumbImage = payPicMessage.thumbImage;
        fsPayPicMessage.localThumbImage = payPicMessage.localThumbImage;
        fsPayPicMessage.localSoureImage = payPicMessage.localSoureImage;
        fsCoversation.lastestMessage = fsPayPicMessage;
    }else if ([coversation.lastestMessage isKindOfClass:[RCLollyPicBePayed class]]) {
        RCLollyPicBePayed *lollyMessage = (RCLollyPicBePayed*)coversation.lastestMessage;
        FSIMLollyPicBePayed *fsLollyMessage =  [FSIMLollyPicBePayed messageWithName:lollyMessage.name data:lollyMessage.data];
        fsCoversation.lastestMessage = fsLollyMessage;
    }else if ([coversation.lastestMessage isKindOfClass:[RCFriendsMessageContent class]]){
        RCFriendsMessageContent *friendMessage = (RCFriendsMessageContent *)coversation.lastestMessage;
        FSIMFriendsMessageContent *messageContent = [[FSIMFriendsMessageContent alloc] init];
        messageContent.message = friendMessage.message;
        messageContent.mExtern = friendMessage.mExtern;
        messageContent.messageType = friendMessage.messageType;
        fsCoversation.lastestMessage = messageContent;
    }else if ([coversation.lastestMessage isKindOfClass:[RCGameInviteContent class]]){
        RCGameInviteContent *gameMessage = (RCGameInviteContent *)coversation.lastestMessage;
        FSIMGameInviteContent *gameInvite = [[FSIMGameInviteContent alloc] init];
        gameInvite.gameId = gameMessage.gameId;
        gameInvite.groupId = gameMessage.groupId;
        gameInvite.gameName = gameMessage.gameName;
        gameInvite.groupType = gameMessage.groupType;
        RCMessage *message = [[RCIMClient sharedRCIMClient] getMessage:coversation.lastestMessageId];
        NSDictionary *info = [message.extra mj_JSONObject];
        if (info) {
            NSNumber *stateNumber = [info valueForKey:MessageExtraKeyGameMsgState];
            if (stateNumber != nil) {
                gameInvite.gameState = [stateNumber integerValue];
            }
            NSString *winnerId = [info valueForKey:MessageExtraKeyGameMsgStateWinId];
            gameInvite.winUserId = winnerId;
        }
        
        if (gameInvite.gameState == FSGameMesageStateWaiting) {
            gameInvite.gameState = FSGameMesageStateOutOfDate;
        }
        gameInvite.countDown = 0;
        fsCoversation.lastestMessage = gameInvite;
        
    }else if ([coversation.lastestMessage isKindOfClass:[RCNoticeTextContent class]]){
        RCNoticeTextContent *notice = (RCNoticeTextContent *)coversation.lastestMessage;
        FSIMNoticeTextContent *fsnotice = [[FSIMNoticeTextContent alloc] init];
        fsnotice.mExtern = notice.mExtern;
        fsnotice.noticeTextKey = notice.noticeTextKey;
        fsnotice.noticeTextStr = notice.noticeTextStr;
        fsCoversation.lastestMessage = fsnotice;
    } else if ([coversation.lastestMessage isKindOfClass:[RCSystemContent class]]) {
        RCSystemContent *system = (RCSystemContent *)coversation.lastestMessage;
        FSIMSystemContent *fsSystem = [[FSIMSystemContent alloc] init];
        fsSystem.systemTemplate = system.systemTemplate;
        fsSystem.image = system.image;
        fsSystem.link = system.link;
        fsSystem.linkContent = system.linkContent;
        fsSystem.titleContent = system.titleContent;
        fsSystem.content = system.content;
        fsCoversation.lastestMessage = fsSystem;
    } else if ([coversation.lastestMessage isKindOfClass:[RCAgreeAddFriednsContent class]]){
        RCAgreeAddFriednsContent *agreeAdd = (RCAgreeAddFriednsContent *)coversation.lastestMessage;
        FSIMAgreeAddFriednsContent *content = [[FSIMAgreeAddFriednsContent alloc] init];
        content.mExtern = agreeAdd.mExtern;
        fsCoversation.lastestMessage = content;
    }else if ([coversation.lastestMessage isKindOfClass:[RCUnFriendContent class]]){
        RCUnFriendContent *unfriendContent = (RCUnFriendContent *)coversation.lastestMessage;
        FSUnFriendContent *content = [[FSUnFriendContent alloc] init];
        content.tipType = unfriendContent.tipType;
        fsCoversation.lastestMessage = content;
    }else if ([coversation.lastestMessage isKindOfClass:[RCAddFriendsContent class]]){
        RCAddFriendsContent *addFriend = (RCAddFriendsContent *)coversation.lastestMessage;
        FSIMAddFriendsContent *fsAddFriendContent = [[FSIMAddFriendsContent alloc] init];
        fsAddFriendContent.st = addFriend.st;
        fsAddFriendContent.type = addFriend.type;
        fsAddFriendContent.mExtern = addFriend.mExtern;
        fsAddFriendContent.fromUserId = addFriend.fromUserId;
        fsCoversation.lastestMessage = fsAddFriendContent;
    }
    return fsCoversation;
}

- (RCMessageContent*)copyFSIMMessageContent:(FSIMMessageContent*) fsMessageContent {
    RCMessageContent *content = nil;
    if ([fsMessageContent isKindOfClass:[FSIMTextMessage class]]) {
        FSIMTextMessage *fsTextMessage = (FSIMTextMessage *)fsMessageContent;
        RCTextMessage *rcContent = [[RCTextMessage alloc] init];
        rcContent.content = fsTextMessage.content;
        content = rcContent;
    }else if ([fsMessageContent isKindOfClass:[RCCommandMessage class]]) {
        FSIMCommandMessage *fsCommandMessage = (FSIMCommandMessage *)fsMessageContent;
        RCCommandMessage *rcCommandMessage =  [RCCommandMessage messageWithName:fsCommandMessage.name data:fsCommandMessage.data];
        content = rcCommandMessage;
    }else if ([fsMessageContent isKindOfClass:[RCVoiceMessage class]]) {
        FSIMVoiceMessage *fsVoiceMessage = (FSIMVoiceMessage*)fsMessageContent;
        RCVoiceMessage *rcVoiceMessage = [RCVoiceMessage messageWithAudio:fsVoiceMessage.wavAudioData duration:fsVoiceMessage.duration];
        content = rcVoiceMessage;
    }else if ([fsMessageContent isKindOfClass:[RCVoiceMessage class]]) {
        FSIMImageMessage *fsImageMessage = (FSIMImageMessage*)fsMessageContent;
        RCImageMessage *rcImageMessage = [[RCImageMessage alloc] init];
        rcImageMessage.full = fsImageMessage.full;
        rcImageMessage.thumbnailImage = fsImageMessage.thumbnailImage;
        rcImageMessage.imageUrl = fsImageMessage.imageUrl;
        rcImageMessage.localPath = fsImageMessage.localPath;
        rcImageMessage.originalImage = fsImageMessage.originalImage;
        content = rcImageMessage;
    }else if ([fsMessageContent isKindOfClass:[FSIMDefineMessageContent class]]) {
        FSIMDefineMessageContent *fsCommandMessage = (FSIMDefineMessageContent *)fsMessageContent;
        FSIMCommonMessage *rcCommandMessage =  [FSIMCommonMessage messageWithName:fsCommandMessage.name data:fsCommandMessage.data];
        content = rcCommandMessage;
    }else if ([fsMessageContent isKindOfClass:[FSIMPayPicMessage class]]) {
        FSIMPayPicMessage *fspayPicMessage = (FSIMPayPicMessage*)fsMessageContent;
        RCPayPicMessage *payPicMessage =  [RCPayPicMessage messageWithName:fspayPicMessage.name data:fspayPicMessage.data];
        payPicMessage.soureImage = fspayPicMessage.soureImage;
        payPicMessage.thumbImage = fspayPicMessage.thumbImage;
        payPicMessage.localThumbImage = fspayPicMessage.localThumbImage;
        payPicMessage.localSoureImage = fspayPicMessage.localSoureImage;
        content = payPicMessage;
    }else if ([fsMessageContent isKindOfClass:[FSIMGameInviteContent class]]) {
        FSIMGameInviteContent *gameInvite = (FSIMGameInviteContent *)fsMessageContent;
        RCGameInviteContent *rcGameInvite = [[RCGameInviteContent alloc] init];
        rcGameInvite.gameId = gameInvite.gameId;
        rcGameInvite.groupId = gameInvite.groupId;
        rcGameInvite.gameName = gameInvite.gameName;
        rcGameInvite.groupType = gameInvite.groupType;
        rcGameInvite.type = gameInvite.type;
        rcGameInvite.mExtern = gameInvite.mExtern;
        content = rcGameInvite;
    }else if ([fsMessageContent isKindOfClass:[FSIMFriendsMessageContent class]]){
        FSIMFriendsMessageContent *friendMessage = (FSIMFriendsMessageContent *)fsMessageContent;
        RCFriendsMessageContent *rcfriendMessage = [[RCFriendsMessageContent alloc] init];
        rcfriendMessage.message = friendMessage.message;
        rcfriendMessage.messageType = friendMessage.messageType;
        rcfriendMessage.type = friendMessage.type;
        rcfriendMessage.mExtern = friendMessage.mExtern;
        content = rcfriendMessage;
    }else if ([fsMessageContent isKindOfClass:[FSIMNoticeTextContent class]]){
        FSIMNoticeTextContent *friendMessage = (FSIMNoticeTextContent *)fsMessageContent;
        RCNoticeTextContent *rcfriendMessage = [[RCNoticeTextContent alloc] init];
        rcfriendMessage.noticeTextKey = friendMessage.noticeTextKey;
        rcfriendMessage.noticeTextStr = friendMessage.noticeTextStr;
        rcfriendMessage.type = friendMessage.type;
        rcfriendMessage.mExtern = friendMessage.mExtern;
        content = rcfriendMessage;
    }else if ([fsMessageContent isKindOfClass:[FSUnFriendContent class]]){
        FSUnFriendContent *fsUnFriendContent = (FSUnFriendContent *)fsMessageContent;
        RCUnFriendContent *unFriendContent = [[RCUnFriendContent alloc] init];
        unFriendContent.tipType = fsUnFriendContent.tipType;
        content = unFriendContent;
    }
    content.senderUserInfo = [[RCUserInfo alloc] initWithUserId:fsMessageContent.senderUserInfo.userId name:fsMessageContent.senderUserInfo.name portrait:fsMessageContent.senderUserInfo.portraitUri];
    return content;
}



- (void)joinGroupWithGroupId:(NSString *)groupId {
    [[RCIMClient sharedRCIMClient] joinChatRoom:groupId messageCount:0 success:^{
        
    } error:^(RCErrorCode status) {
        
    }];
}

@end
