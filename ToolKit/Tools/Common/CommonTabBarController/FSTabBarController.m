//
//  FSTabBarController.m
//  Ready
//
//  Created by mac on 2018/7/19.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSTabBarController.h"
#import "UITabBar+CustomBadge.h"
#import "FSIMClientSever.h"
#import "FSGameInvitedAlertView.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationDrop.h"
#import "FSIMGameInviteContent.h"
#import "FSIMClientSever.h"
#import "FSGameInfoSever.h"
#import "FSMatchdUserInfo.h"
#import "FSFriendsManager.h"
#import "FSGameServer.h"
#import "FSGameVC.h"
#import "FSLocalNotificationMananger.h"
#import "FSIMMessageSever.h"
#import <XGPush.h>
#import "FSMessageController.h"
#import "FSNavigationController.h"
#import "UITabBar+SvgaItem.h"



@interface FSTabBarController ()
@property(nonatomic,strong)FSGameServer *gameSever;
@end

@implementation FSTabBarController
- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveInviteMessage:) name:kNSNotificationGAME_INVITEMessage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMessageNumber:) name:kNSNotificationCurrentMessageNumber object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginSuccess) name:KNOTIFICATION_REQUESTPERSONINFOSUCCESS object:nil];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
//    [self.tabBar layoutContainers];
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    
    [self.tabBar layoutContainers];
    [self.tabBar playSvgaWithName:@"home_tab_game" atIndex:selectedIndex];
}
- (void)userLoginSuccess {
    
    [[XGPushTokenManager defaultTokenManager] clearAllIdentifiers:(XGPushTokenBindTypeAccount)];
    [[XGPushTokenManager defaultTokenManager] clearAllIdentifiers:(XGPushTokenBindTypeTag)];
    
    NSString *currentLanguage = [FSSharedLanguages SharedLanguage].language;
    FSUserInfoModel *userInfo = (FSUserInfoModel *)[LoginSDKManager shareManager].user;

    [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:currentLanguage type:(XGPushTokenBindTypeTag)];
    [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:userInfo.hometown type:(XGPushTokenBindTypeTag)];
    [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:userInfo.userId type:(XGPushTokenBindTypeAccount)];

}
- (void)receiveInviteMessage:(NSNotification *)notification {
    FSIMMessage *message = [notification object];
    FSIMGameInviteContent *inviteContent = (FSIMGameInviteContent *)message.content;
    
    if ([FSGlobalLauncher launcher].isInPlayGame) {
        return;
    }
    
    if ([FSGlobalLauncher launcher].isInChatting && [[FSGlobalLauncher launcher].chatingId isEqualToString:message.targetId]) {
        // 不是发给当前的人的。
        return;
    }
    
    long long disTime = message.receivedTime - message.sentTime;
    if (disTime >= 60000) {
        // 时间超过60秒
        return;
    }
    

    NSDictionary *messageExtra = [inviteContent.mExtern mj_JSONObject];
    NSString *gameId = inviteContent.gameId;
    FSGameInfoModel *gameInfo = [[FSGameInfoSever new] gameInfoWithGameId:gameId];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // 非活动状态 显示本地推送
        UIApplicationState applicationState = [[UIApplication sharedApplication] applicationState];
        BOOL canShowNotification = (applicationState != UIApplicationStateActive);
        if (canShowNotification) {
//            NSString *name = [messageExtra stringForKey:MessageExtraKeyName];
            NSString *invite = [FSSharedLanguages CustomLocalizedStringWithKey:@"AllPage_Invitation"];
            NSString *inviteText = gameInfo.currentName?:@"";
            invite = [invite stringByReplacingOccurrencesOfString:@"(s)" withString:inviteText];
            NSString *gameInviteMessage = [NSString stringWithFormat:@"%@",invite];
            [FSLocalNotificationMananger showNotificationWithMessage:gameInviteMessage];
        }
        
        [messageExtra stringForKey:MessageExtraKeyGameName];
        NSString *gameName = gameInfo.currentName;
        NSString *userHeader = [messageExtra stringForKey:MessageExtraKeyAvatar];
        NSString *userName = [messageExtra stringForKey:MessageExtraKeyName];
    
        // 不在以上状态就显示弹窗
        FSGameInvitedAlertView *gameInvite = [[FSGameInvitedAlertView alloc] init];
        [gameInvite.nameLabel setText:userName];
        [gameInvite.headPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HeadeResourceUrl,userHeader]] placeholderImage:SmallPlaceHolderImage];
        [gameInvite setGameName:gameName?:@""];
        gameInvite.ignoreBlock = ^{
            [self lew_dismissPopupViewWithanimation:[LewPopupViewAnimationDrop new]];
        };
        
        gameInvite.agreeBlock = ^{
            // 接受邀请
            NSDictionary *mesageExtra = @{MessageExtraKeyGameMsgState:[NSNumber numberWithInteger:FSGameMesageStateOutOfDate]};
            NSString *jsonString = [mesageExtra mj_JSONString];
            [[FSIMClientSever sharedService] setMessageExtra:inviteContent.messageId.longLongValue value:jsonString];
            
            FSIMMessageSever *messagserver = [[FSIMMessageSever alloc] init];
            [messagserver acceptGameWithMessage:inviteContent];
            
            FSGameInfoModel *model  = [[FSGameInfoSever new] gameInfoWithGameId:gameId];
            if (!model) {
                return ;
            }
            FSMatchdUserInfo *other = [[FSMatchdUserInfo alloc] init];
            other.nickName = userName;
            other.headPic = userHeader; //_info.headPic;
            other.userId = [NSString stringWithFormat:@"%ld",inviteContent.fromUserId];
            
            self.gameSever = [[FSGameServer alloc] init];
            self.gameSever.otherUser = other;
            self.gameSever.setGroupId(inviteContent.groupId);
            
            [self.gameSever gameServerPlayWithGameInfo:gameInfo completeBlock:^(FSGameServer *server, FSGameInfoModel *gameInfo) {
                [server checkIsPayable];
                if (server.isPayable) {
                    UINavigationController *nav = [self.selectedViewController isKindOfClass:UINavigationController.class]?self.selectedViewController:self.selectedViewController.navigationController;
                    if (nav) {
                        FSGameVC *gameVc = FSGameVC.newVC(server);
                        [nav pushViewController:gameVc animated:YES];
                    }
                }else{
                    [self.selectedViewController showVerticalWithMessage:locStrBy(@"RandowMatchPage_GoldNotEnough") defaultButton:locStrBy(@"RandowMatchPage_Task") cancleButton:locStrBy(@"RandowMatchPage_Quit") defaultFunc:^{
                        // go to做任务页面
                        [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationNeedJumpToTask object:nil];
                    } cancleFunc:^{
                        
                    }];
                }
            }];
            
            [self lew_dismissPopupViewWithanimation:[LewPopupViewAnimationDrop new]];
    
        };
        
        [self lew_presentPopupView:gameInvite animation:[LewPopupViewAnimationDrop new] backgroundClickable:NO dismissed:^{
        }];
    });

}

- (void)showMessageNumber:(NSNotification *)notification {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSNumber *tempAllNumber =(NSNumber *)notification.object;
        [self showMessageBadgeValue:[tempAllNumber integerValue]];
        
    });
    
}

- (void)showMessageBadgeValue:(NSInteger)badge {
    NSInteger mindex = -1;
    for (NSInteger index = 0; index < self.childViewControllers.count;index ++ ) {
        FSNavigationController *navigationController = [self.childViewControllers objectAtIndex:index];
        UIViewController *root = [navigationController.childViewControllers firstObject];
        if ([root isKindOfClass:[FSMessageController class]]) {
            mindex = index;
            break;
        }
    }
    
    if (mindex == -1) {
        return;
    }
    
    if (badge==0) {
        [self.tabBar setBadgeStyle:(kCustomBadgeStyleNone) value:badge atIndex:mindex];
    }else{
        [self.tabBar setBadgeStyle:(kCustomBadgeStyleNumber) value:badge atIndex:mindex];
    }
}
- (void)tabBar:(UITabBar *)tabBar willBeginCustomizingItems:(NSArray<UITabBarItem *> *)items {
    
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    // 做动画切换
    if ([item isKindOfClass:[FSTabBarItem class]]) {
        FSTabBarItem *svgaItem = (FSTabBarItem *)item;
        [tabBar playSvgaWithItem:svgaItem];
    }
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.selectedViewController;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"fsTabbarController dealloc");
}

@end
