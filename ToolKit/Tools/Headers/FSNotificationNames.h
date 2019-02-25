//
//  FSNotificationNames.h
//  Ready
//
//  Created by jiapeng on 2018/8/8.
//  Copyright © 2018年 Fission. All rights reserved.
//

#ifndef FSNotificationNames_h
#define FSNotificationNames_h

//消息类型通知
#define kNSNotificationBlackListIDChange        @"kNSNotificationBlackListIDChange"

//自己接收弹幕消息
#define kNSNotificationReceiveDanMuMessage @"kNSNotificationReceiveDanMuMessage"
//别人发接收弹幕消息
#define kNSNotificationReceiveOtherPeopleDanMuMessage @"kNSNotificationReceiveOtherPeopleDanMuMessage"


//进入前台（唤醒）
#define kNSNotificationInhoneDidBecomeActive @"kNSNotificationInhoneDidBecomeActive"

//完善信息成功
#define KNOTIFICATION_COMPLETEPERSONINFOSUCCESS @"completePersonInfoSuccess"
//获取个人信息登录成功
#define KNOTIFICATION_REQUESTPERSONINFOSUCCESS @"requestPersonInfoSuccess"

//添加好友
#define kNSNotificationFRIEND_ADDMessage @"kNSNotificationFRIEND_ADDMessage"
//删除好友
#define kNSNotificationFRIEND_DelMessage @"kNSNotificationFRIEND_DelMessage"
//同意添加好友
#define kNSNotificationFRIEND_AGREEMessage @"kNSNotificationFRIEND_AGREE"
//聊天消息
#define kNSNotificationFRIEND_CUSTOM_MESSAGE @"kNSNotificationFRIEND_CUSTOM_MESSAGE"
//游戏邀请
#define kNSNotificationGAME_INVITEMessage @"kNSNotificationGAME_INVITEMessage"
//进入聊天室
#define kNSNotificationGROUP_JOINMessage @"kNSNotificationGROUP_JOINMessage"
//进入聊天室
#define kNSNotificationGROUP_RoobotJOINMessage @"kNSNotificationGROUP_RoobotJOINMessage"

// 语言切换
#define kNSNotificationLanguageChanged  @"kNSNotificationLanguageChanged"
// 语言切换
#define kNSNotificationGameMatchSuccess  @"kNSNotificationGameMatchSuccess"
// 游戏邀请拒绝
#define kNSNotificationGameInviteReject  @"kNSNotificationGameInviteReject"
// 游戏结束
#define kNSNotificationGameOver  @"kNSNotificationGameOver"
// 游戏再来一局
#define kNSNotificationGamePalyAgain  @"kNSNotificationGamePalyAgain"
// 游戏重新开始
#define kNSNotificationSwitchGame  @"kNSNotificationSwitchGame"

#define kNSNotificationTaskStateUpdate  @"kNSNotificationTaskStateUpdate"

#define kNSNotificationSuperScrollShouldEnable  @"kNSNotificationSuperScrollShouldEnable"

#define kNSNotificationRongClientReceiveMessage @"kNSNotificationRongClientReceiveMessage"

// 跳到任务页面
#define kNSNotificationNeedJumpToTask  @"kNSNotificationNeedJumpToTask"

#define kNSNotificationUpdateUserBalance    @"kNSNotificationUpdateUserBalance"

#define kNSNotificationCheckInSuccess       @"kNSNotificationCheckInSuccess"

#define kNSNotificationFriendGameStateChangedMessage    @"kNSNotificationFriendGameStateChangedMessage"
#define kNSNotificationFrieneOnlineStateChanged         @"kNSNotificationFrieneOnlineStateChanged"

#define kNSNotificationNewSystemMessage        @"kNSNotificationNewSystemMessage"

#define kNSNotificationRefreshRedPointState        @"kNSNotificationRefreshRedPointState"

#define kNSNotificationUserSwitchGame        @"kNSNotificationUserSwitchGame"

#define kNSNotificationChangeToMessage       @"kNSNotificationChangeToMessage"
#define kNSNotificationChangeToAddFriends      @"kNSNotificationChangeToAddFriends"
#define kNSNotificationChangeToRankPK       @"kNSNotificationChangeToRankPK"
#define kNSNotificationUpdateLockState      @"kNSNotificationUpdateLockState"


#define kNSNotificationDidGetUserLocation  @"kNSNotificationDidGetUserLocation"

#define kNSNotificationDidRemovedByUser  @"kNSNotificationDidRemovedByUser"


//当前消息未读总数
#define kNSNotificationCurrentMessageNumber  @"kNSNotificationCurrentMessageNumber"
//当前好友消息未读数
#define kNSNotificationCurrentFriendsMessageNumber  @"kNSNotificationCurrentFriendsMessageNumber"

//活动列表获取成功
#define kNSNotificationActivitylistAPISuccess  @"kNSNotificationActivitylistAPISuccess"
//活动列表获取失败
#define kNSNotificationActivitylistAPIFail  @"kNSNotificationActivitylistAPIFail"
//活动列表获取失败返回状态码
#define kNSNotificationActivitylistAPICode  @"kNSNotificationActivitylistAPICode"

//首页活动跳转
#define kNSNotificationHomeActivityJumpType  @"kNSNotificationHomeActivityJumpType"

// udf keys
#define kNSUserDefaultKeysForActivity @"kNSUserDefaultKeysForActivity"
//奖池活动开始或结束
#define kNSNotificationActivityAwardPoolEndOrBegin  @"kNSNotificationActivityAwardPoolEndOrBegin"
//奖池活动跑马灯消息
#define kNSNotificationAwardPoolActivityHorseRace  @"kNSNotificationAwardPoolActivityHorseRace"

#endif /* FSNotificationNames_h */
