//
//  YKServerAPIConst.h
//  Ready
//
//  Created by jiapeng on 2018/7/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#ifndef YKServerAPIConst_h
#define YKServerAPIConst_h

#define KeyLogin_third                         @"login_third"
#define KeyLogout                              @"logout"
#define KeyUser_self                           @"user_self"
#define KeyJson_infos                          @"static_config_v2"
#define KeyPhoto_update                        @"pic_index_add"
#define KeyUser_init                           @"user_init"

#define KeyUser_info                           @"user_info"
#define KeyUser_info_update                    @"user_update"
#define KeyUser_sign                           @"user_sign"
#define KeyUser_sign_info                      @"user_sign_info"
#define KeyUser_task_info                      @"user_task_info"
#define KeyUser_taks_commit                    @"task_comsumed"

#define keyUser_friends                        @"friend"
#define KeyUser_friends_del                    @"friend_subs"
#define KeyUser_friends_apply                  @"friend_apply"
#define KeyUser_friends_accept                 @"friend_apply_pass"
#define KeyUser_friend_message                 @"friend_message"
#define KeyUser_query_my_balance               @"query_my_balance"


#define KeyUser_chat_token                     @"user_chat_token"
#define key_rong_url                           @"rong_url"
#define key_rong_file                          @"rong_file"
#define key_rong_statistic                     @"rong_statistic"
#define key_con_msg_receipt                    @"con_msg_receipt"

#define key_Game_invite                        @"game_invite"
#define key_Game_invite_reject                 @"game_invite_reject"
#define key_Game_invite_accept                 @"game_invite_accept"

#define game_ranking                           @"game_ranking"            // 游戏排行
#define game_join                              @"game_join"              // 进入游戏
#define game_out                               @"game_out"               // 离开游戏聊天室
#define game_connect_up                        @"game_connect_up"        // 音频上麦
#define game_match                             @"game_match"                // 开始匹配
#define game_match_v2                          @"game_match_v2"            // 付费场匹配
#define game_match_out                         @"game_match_out"          // 退出匹配
#define game_connect_down                      @"game_connect_down"      // 视频下麦
#define game_media_relay                       @"game_media_relay"        // 媒体消息中转
#define send_game_keep                         @"send_game_keep"        // Http保活（测试使用）
#define game_pay_validate                      @"game_pay_validate"        // 游戏付费检测
#define send_game_message                      @"send_game_message"    // 游戏发言
#define send_game_again                        @"send_game_again"        // 游戏再来一局
#define user_invite_address                    @"user_invite_address"        // 获取邀请连接
#define user_info                              @"user_info"

#define KeyPrivacy_policy                      @"privacy_clause"
#define KeyService_policy                      @"service_terms"

#define KeyBalance_echange_policies            @"balance_echange_policies"   //获取虚拟产品兑换列表
#define Keybalance_echange                     @"balance_echange"            //兑换虚拟产品

#define KeyRecharge_Order                      @"recharge_create_order"   // 创建订单
#define KeyRecharge_iap                        @"recharge_apple_iap" // 提交订单

#define KeyInviteFriend                        @"invite_friend"
#define KeyInviteFriend_Share                  @"invite_friend_share"
#define Key_top_ranking                        @"top_ranking"
#define Key_purse_description                  @"purse_description"
#define Key_gole_lists                         @"gole_lists"

#define friend_sub                             @"friend_sub"
#define top_ranking                            @"top_ranking"


#define Key_zuan_lists                         @"zuan_lists"
#define Key_app_batch_record                   @"app_batch_record"

#define Key_reflect_help                       @"reflect_help"

#define Key_send_danmaku_shout_text            @"send_danmaku_shout_text"
#define Key_send_danmaku_shout_voice           @"send_danmaku_shout_voice"
#define Key_shop_h5                            @"shop_h5"
#define Key_get_danmaku_latest_list            @"get_danmaku_latest_list"
#define KeyUser_keep_alive                     @"alive"

#define key_home_GoGameId                      @"get_go_gameId"
#define key_popup_list                         @"popup_list"

#define key_ranking_single_game_begin          @"ranking_single_game_begin" //获取单机游戏开始页信息
#define key_ranking_single                     @"ranking_single"
#define key_single_game_token                  @"single_game_token"  //获取单机游戏token
#define key_single_game_settle                 @"single_game_settle" //单机游戏结算
#define key_single_game_relive                 @"single_game_relive" //单机游戏复活
#define key_single_game_relive_policy          @"single_game_relive_policy" //获取单机游戏复活策略

#define key_activity_list                      @"activity_list"            //活动列表
#define key_activity_info                      @"activity_info"            //活动详情activity_receive_award
#define key_activity_receive_award             @"activity_receive_award"   //活动完成领取奖励
//
#define key_activity_award_pool_list           @"activity_award_pool_list"
#define key_activity_award_pool_detail         @"activity_award_pool_detail"
#define key_activity_award_pool_task_detail    @"activity_award_pool_task_detail"
#define key_activity_awardpool_award_ranking   @"activity_awardpool_award_ranking"
#define key_activity_join                      @"activity_awardpool_award_task_processingAndJoined"
#define key_activity_hourseRace                @"activity_awardpool_horseRace"
#define key_ranking_awardpool                  @"ranking_awardpool"
#define key_buy_ticket                         @"activity_awardpool_buy_ticket"
#define ket_activity_awardpool_award_task_userJoined  @"activity_awardpool_award_task_userJoined" //用户已经参加的，购票的，返回的票据都是有效的，服务器当天时间段内


#endif /* YKServerAPIConst_h */
