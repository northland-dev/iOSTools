//
//  FSIMMessageDefine.h
//  Lolly
//
//  Created by stu on 2017/11/6.
//  Copyright © 2017年 Fission. All rights reserved.
//

#ifndef FSIMMessageDefine_h
#define FSIMMessageDefine_h
/*
* 10W-20W 1v1相关逻辑
* 20W-30W 广场页相关逻辑
* 30W-40W 用户信息相关
* 40W-50W im相关
 */

//messageid分组
typedef NS_OPTIONS(long, MessageIDType) {
    //广场页相关逻辑
    FSHostStateChange   = 200001,//"在线状态变更",
    FSHostCheckAlive    = 200002,//"主播保活检查",

    //用户信息相关
    FSHostIncomeChange  = 300001,//"增加收入",
    FSUserAccountChange = 300002,//"余额变动",

    //1v1视频相关
    FSVideoChatHangUp   = 100001,//"停止视频", (挂断)
    FSVideoBeAccept     = 100002,//"接听视频", （接听）
    FSVideoBeRefused    = 100003,//"拒绝接听视频", （拒绝）
    FSVideoOnCalling    = 100004,//"发起视频",    (主播收到)
    FSGiftReceive       = 100005,//"主播接收礼物",
    FSVideoCancelCall   = 100006,//"取消发起视频",
    FSVideoChatClientCmd = 100007,//通话-客户端发送命令请求(服务端转发)

    //im相关
    FSSendPayPhotos     = 400001,//发送付费图片";
};



/**
 * 聊天室匹配成功
 */
#define GROUP_MATCH_ROBOT             @"READY:GroupMatchRobot"
/**
 * 聊天室匹配超时
 */
#define GROUP_MATCH_TIMEOUT             @"READY:GroupMatchTimeout"
/**
 * 聊天室超时
 */
#define GROUP_TIMEOUT             @"READY:GroupTimeout"
/**
 * 进入聊天室
 */
#define GROUP_JOIN             @"READY:GroupJoin"
/**
 * 进入聊天室超时
 */
#define GROUP_JOIN_TIMEOUT             @"READY:GroupJoinTimeout"
/**
 * 离开聊天室
 */
#define GROUP_LEAVE             @"READY:GroupLeave"
/**
 * 聊天室销毁
 */
#define GROUP_DESTORY             @"READY:GroupDestory"
/**
 * 聊天室邀请
 */
#define GROUP_INVITE             @"READY:GroupInvite"
/**
 * 聊天室邀请上麦
 */
#define GROUP_INVITE_CONNECT             @"READY:GroupInviteConnect"
/**
 * 关注聊天室
 */
#define GROUP_FOLLOW             @"READY:GroupFollow"
/**
 * 聊天室送礼
 */
#define GROUP_GIFT             @"READY:GroupGift"
/**
 * 聊天室骰子
 */
#define GROUP_DICE             @"READY:GroupDice"
/**
 * 聊天室发言
 */
#define GROUP_MESSAGE             @"READY:GroupMessage"
/**
 * 聊天室自定义发言
 */
#define GROUP_CUSTOM_MESSAGE             @"READY:GroupCustomMessage"
/**
 * 聊天室连麦
 */
#define GROUP_CONNECT_UPDATE             @"READY:GroupConnectUpdate"
/**
 * 聊天室踢下麦
 */
#define GROUP_KICK_CONNECT             @"READY:GroupKickConnect"
/**
 * 聊天室连麦同步消息
 */
#define GROUP_CONNECT_SYNC             @"READY:GroupConnectSync"
/**
 * 聊天室奖励通知
 */
#define GROUP_LUCK             @"READY:GroupLuck"
/**
 * 聊天室禁言
 */
#define GROUP_MUTE             @"READY:GroupMute"
/**
 * 聊天室管理员
 */
#define GROUP_ADMIN             @"READY:GroupAdmin"
/**
 * 聊天室踢人
 */
#define GROUP_KICK             @"READY:GroupKick"
/**
 * 聊天室禁麦
 */
#define GROUP_BAN             @"READY:GroupBan"
/**
 * 聊天室唱歌连麦
 */
#define GROUP_SONG_CONNECT             @"READY:GroupSongConnect"
/**
 * 鲜花消息
 */
#define GROUP_FLOWER             @"READY:GroupFlower"
/**
 * 鸡蛋消息
 */
#define GROUP_EGG             @"READY:GroupEgg"
/**
 * 点赞消息
 */
#define GROUP_PRAISE             @"READY:GroupPraise"
/**
 * 允许链接mic消息
 */
#define GROUP_ALLOW_APPLY_MIC             @"READY:GroupAllowApplyMic"

/**
 * 视频透传消息
 */
#define GROUP_MEDIA_RELAY             @"READY:GroupMediaRelay"

/**
 * 聊天室红包
 */
#define GROUP_RED             @"READY:GroupRed"
/**
 * 聊天室红包退款
 */
#define GROUP_RED_RETURN             @"READY:GroupRedReturn"
/**
 * 聊天室抢红包
 */
#define GROUP_GRAB_RED             @"READY:GroupGrabRed"
/**
 * 被邀请注册完成消息
 */
#define INVITEE_REGISTER             @"READY:InviteeRegister"
/**
 * 被邀请注册奖励消息
 */
#define INVITEE_REGISTER_AWARD             @"READY:InviteeRegisterAward"
/**
 * 抽成奖励消息
 */
#define DIVIDE_AWARD             @"READY:DivideAward"
/**
 * 任务状态变更
 */
#define TASK_STATE_UPDATE             @"READY:TaskStateUpdate"
/**
 * 好友消息
 */
#define FRIEND_MESSAGE             @"READY:FriendMessage"
/**
 * 好友自定义透传消息
 */
#define FRIEND_CUSTOM_MESSAGE             @"READY:FriendCustomMessage"
/**
 * 好友送礼
 */
#define FRIEND_GIFT             @"READY:FriendGift"

/**
 * 好友宠物邀请
 */
#define FRIEND_PET_INVITE             @"READY:FriendPetInvite"
/**
 * 好友唤醒
 */
#define FRIEND_WAKE_UP             @"READY:FriendWakeUp"
/**
 * 删除好友
 */
#define FRIEND_REMOVE             @"READY:FriendRemove"
/**
 * 好友信息变更
 */
#define FRIEND_INFO_UPDATE             @"READY:FriendInfoUpdate"
/**
 * 同意添加好友
 */
#define FRIEND_AGREE             @"READY:FriendAgree"
/**
 * 系统新游戏上线
 */
#define SYSTEM_NEW_GAME             @"READY:SystemNewGame"
/**
 * 聊天室通知类消息
 */
#define SYSTEM_GROUP             @"READY:SystemGroup"
/**
 * 系统游戏通知消息
 */
#define SYSTEM_GAME             @"READY:SystemGame"
/**
 * 系统赠送消息
 */
#define SYSTEM_GIVE             @"READY:SystemGive"
/**
 * 系统公告
 */
#define SYSTEM_NOTE             @"READY:SystemNote"
/**
 * 系统公告
 */
#define PET_REAP             @"READY:PetReap"
/**
 * 客户端匹配保活
 */
#define GROUP_MATCH_KEEP_ALIVE             @"READY:GroupMatchKeepAlive"
/**
 * 视频房主切换
 */
#define GROUP_HOST_UPDATE             @"READY:GroupHostUpdate"
/**
 * 客户端房间保活
 */
#define GROUP_KEEP_ALIVE             @"READY:GroupKeepAlive"
/**
 * 客户端在线保活
 */
#define ONLINE_KEEP_ALIVE             @"READY:OnlineKeepAlive"
/**
 * 客户端在线状态变更
 */
#define ONLINE_STATE_UPDATE             @"READY:OnlineStateUpdate"
/**
 * 房间游戏透传消息
 */
#define GROUP_GAME_RELAY             @"READY:GroupGameRelay"
/**
 * 举报处理消息
 */
#define REPORT_OPERATE             @"READY:ReportOperate"
/**
 * 举报处理完成通知
 */
#define REPORT_COMPLETE             @"READY:ReportComplete"
/**
 * 系统召回push
 */
#define SYSTEM_RECALL             @"READY:SystemRecall"
/**
 * 系统单向通知，SystemNotify
 * 使用场景：定向用户上传日志，清除缓存之类的
 */
#define SYSTEM_NOTIFY             @"READY:SystemNotify"
/**
 * 消息可靠性测试
 */
#define SYSTEM_TEST             @"READY:SystemTest"
/**
 * 消息可靠性测试
 */
#define SYSTEM_MANAGER             @"READY:SystemManager"
/**
 * 系统账号禁用通知
 */
#define USER_DISABLE             @"READY:UserDisable"
/**
 * 系统禁言通知
 */
#define SYSTEM_MUTE             @"READY:SystemMute"
/**
 * 注册奖励
 */
#define REGISTER_AWARD             @"READY:RegisterAward"
/**
 * 站内信
 */
#define SYSTEM_INMAIL             @"READY:SystemInMail"
/**
 * 订单发货成功
 */
#define ORDER_SENDSUCCESS             @"READY:OrderSendSuccess"
/**
 * 用户申请唱歌
 */
#define AUDIO_SONG_APPLY             @"READY:AudioSongApply"
/**
 * 用户唱歌
 */
#define AUDIO_SONG_READY             @"READY:AudioSongReady"
/**
 * 用户取消唱歌
 */
#define AUDIO_SONG_CANCEL             @"READY:AudioSongCancel"
/**
 * 管理员置顶用户歌曲
 */
#define AUDIO_SONG_UP             @"READY:AudioSongUp"
/**
 * 管理员切歌
 */
#define AUDIO_SONG_CUT             @"READY:AudioSongCut"
/**
 * 管理员删除歌曲
 */
#define AUDIO_SONG_DELETE             @"READY:AudioSongDelete"
/**
 * 管理员暂停歌曲
 */
#define AUDIO_SONG_PAUSE             @"READY:AudioSongPause"
/**
 * 房主同意用户房主连麦消息
 */
#define AUDIO_RADIO_AGREE_UP             @"READY:Audio_radio_agree_up"
/**
 * 电台房提示消息
 */
#define AUDIO_RADIO_RED_TIP             @"READY:AudioRadioRedTip"


// ready new
/**
 * 游戏邀请
 */
#define GAME_INVITE                   @"READY:GameInvite"

#define TaskUpdate                    @"READY:Task"

#define GameReject                    @"READY:GameInviteReject"
/**
 * 聊天室匹配成功
 */
#define GROUP_MATCH_SUCCESS           @"READY:GroupMatchSuccess"
#define GROUP_MATCH_ROBOT            @"READY:GroupMatchRobot"
/**
 * 添加好友
 */
#define FRIEND_ADD                    @"READY:FriendAdd"

#define DanmuMessage                  @"READY:DanmakuNEW"

#define FriendGameStateUpdate         @"READY:FriendGameStateUpdate"

#define FriendGameChange         @"READY:GameChange"

#define BALANCE_UPDATE         @"READY:BalanceUpdate"

#define GameInviteAccept         @"READY:GameInviteAccept"

//奖池活动,倒计时事件,开始和结束使用同一个事件
#define ACTIVITY_AWARD_POOL_COUNTDOWN    @"READY:AwardPool:Countdown"
//跑马灯消息
#define AwardPoolHorseRace  @"READY:AwardPool:HorseRace"


#endif /* FSIMMessageDefine_h */
