//
//  AppDelegate+Function.m
//  Ready
//
//  Created by mac on 2018/7/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "AppDelegate+Function.h"
#import <Bugly/Bugly.h>
#import <Bugly/BuglyConfig.h>
#import <libRyze/libRyze.h>
#import "FSRyzeUploader.h"
#import <UserNotifications/UserNotifications.h>
#import "FSChatGifSever.h"
#import  <LKDBHelper/LKDBHelper.h>
#import <AppsFlyerLib/AppsFlyerTracker.h>

#import "FSShareKitManager.h"
#import <TwitterKit/TWTRKit.h>

#import "NSString+GC.h"
#import <libSona/SonaHTTPServer.h>
#import <Adjust/Adjust.h>
#import <QQ_XGPush/XGPush.h>

#import "LoginSDKManager.h"
#import "FSUserInfoModel.h"

#import "FSGlobalLauncher.h"

@implementation AppDelegate (Function)
- (void)ConfigAspect {
    // 埋点相关的
    [RyzeAspectManager ryze_enableGzip:NO];
    [RyzeAspectManager ryze_setMaxUpload:50];
    [RyzeAspectManager ryze_configUploader:[FSRyzeUploader new]];
    [RyzeAspectManager ryze_createFuntionHook];
    
    // Crash处理
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}
- (void)ConfigAjust {

    NSString *yourAppToken = @"3umc5s12qe80";
#ifdef DEBUG
    NSString *environment = ADJEnvironmentSandbox;
    ADJConfig *adjustConfig = [ADJConfig configWithAppToken:yourAppToken
                                                environment:environment];
    [adjustConfig setLogLevel:ADJLogLevelVerbose];
#else
    NSString *environment = ADJEnvironmentProduction;
    ADJConfig *adjustConfig = [ADJConfig configWithAppToken:yourAppToken
                                                environment:environment];
    [adjustConfig setLogLevel:ADJLogLevelSuppress];
#endif
    [Adjust appDidLaunch:adjustConfig];
    
    // 测试
//    ADJEvent *event = [ADJEvent eventWithEventToken:@"zbsrru"];
//    [Adjust trackEvent:event];
}

-(void)ConfigBugly{
    BuglyConfig *config = [[BuglyConfig alloc] init];
    [config setBlockMonitorEnable:NO];
    [config setUnexpectedTerminatingDetectionEnable:NO];
    //暂时没有appid
    [Bugly startWithAppId:Bugly_APP_ID config:config];
    // 非正常退出事件无有效信息可以用
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *build_Version = [info valueForKey: @"CFBundleVersion"];
    NSString *appVersion = [NSString stringWithFormat:@"%@_%@",APP_VERSION,build_Version];
    [Bugly updateAppVersion:appVersion];
}

- (void)ConfigSDWebImage {
    [[SDWebImageCodersManager sharedInstance] addCoder:[SDWebImageGIFCoder sharedCoder]];
}

- (void)registerPushNotiifcation:(UIApplication *)application {
    
//    if (@available(iOS 10.0, *)) {
//        if (![application isRegisteredForRemoteNotifications]) {
//            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
////            [center setDelegate:self];
//            [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
//                if (granted) {
//                    //点击允许
//                    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//                        
//                    }];
//                    dispatch_async(dispatch_get_main_queue(), ^{ // Correct
//                        [application registerForRemoteNotifications];
//                    });
//                }
//            }];
//        }else{
//            [application registerForRemoteNotifications];
//        }
//    }else if (@available(iOS 8.0, *)){
//        if (![application isRegisteredForRemoteNotifications]) {
//            [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil]];
//            [application registerForRemoteNotifications];
//        }
//    }
}

void UncaughtExceptionHandler(NSException *exception){
    //  Crash
    [RyzeAspectManager ryze_saveAllUnUploadInfo];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [RyzeAspectManager ryze_saveAllUnUploadInfo];
}
- (void)configLanguage {
   BOOL followSystem = [FSSharedLanguages SharedLanguage].followSystem;
    if (!followSystem) {
        return;
    }
}

- (void)configFMDBFile {
    
//    NSInteger userid = 12345;
//    NSString *inviteCode = [NSString inviteCodeWithInteger:
//    NSLog(@"inviteCode %@",inviteCode);
}
- (void)configAppsflyer {
    [AppsFlyerTracker sharedTracker].appleAppID = APPSTORE_ID; // The Apple app ID. Example 34567899
    [AppsFlyerTracker sharedTracker].appsFlyerDevKey = @"PUroaGMzcnuSbybLtg6Mae";
    [[AppsFlyerTracker sharedTracker] setIsDebug:NO];
    [[AppsFlyerTracker sharedTracker] trackAppLaunch];
    [[AppsFlyerTracker sharedTracker] setUseUninstallSandbox:NO];
}

- (void)configHttpServer{
    if (WEBPath.creatPath) {
        WEBPath.creatPath;
        [[SonaHTTPServer sharedHTTPServer] start];
        [[SonaHTTPServer sharedHTTPServer] setFilePath:WEBPath];
    }else{
        NSLog(@"Web路径未创建成功， http server未配置");
    }
}

- (void)configShareKit {

}
- (void)configQQPush:(NSDictionary *)launchOptions{
    [[XGPush defaultManager] startXGWithAppID:2200315731 appKey:@"I4T13EZ9Y4UX" delegate:self];
#ifdef DEBUG
    [[XGPush defaultManager] setEnableDebug:YES];
#endif
    [[XGPush defaultManager] setXgApplicationBadgeNumber:0];
    [[XGPush defaultManager] reportXGNotificationInfo:launchOptions];
    
    if ([LoginSDKManager shareManager].isLogined) {
        
        [[XGPushTokenManager defaultTokenManager] clearAllIdentifiers:(XGPushTokenBindTypeAccount)];
        [[XGPushTokenManager defaultTokenManager] clearAllIdentifiers:(XGPushTokenBindTypeTag)];
        
        NSString *currentLanguage = [FSSharedLanguages SharedLanguage].language;
        FSUserInfoModel *userInfo = (FSUserInfoModel *)[LoginSDKManager shareManager].user;
        
        [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:currentLanguage type:(XGPushTokenBindTypeTag)];
        [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:userInfo.hometown type:(XGPushTokenBindTypeTag)];
        [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:userInfo.userId type:(XGPushTokenBindTypeAccount)];
    }

}
- (void)applicationDidReceiveDeviceToken:(NSData *)deviceToken {
    [Adjust setDeviceToken:deviceToken];
}
- (void)requestTenor{
    [[FSChatGifSever sharedSever] requestTenor:nil];
}

#pragma mark - XGPushDelegate
- (void)xgPushDidFinishStart:(BOOL)isSuccess error:(NSError *)error {
    NSLog(@"%s, result %@, error %@", __FUNCTION__, isSuccess?@"OK":@"NO", error);
}

- (void)xgPushDidFinishStop:(BOOL)isSuccess error:(NSError *)error {
    NSLog(@"%s, result %@, error %@", __FUNCTION__, isSuccess?@"OK":@"NO", error);
}

- (void)xgPushDidRegisteredDeviceToken:(NSString *)deviceToken error:(NSError *)error {
    NSLog(@"%s, result %@, error %@", __FUNCTION__, error?@"NO":deviceToken, error);
}

// iOS 10 新增 API
// iOS 10 会走新 API, iOS 10 以前会走到老 API
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// App 用户点击通知
// App 用户选择通知中的行为
// App 用户在通知中心清除消息
// 无论本地推送还是远程推送都会走这个回调
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    [[XGPush defaultManager] reportXGNotificationResponse:response];
    NSDictionary *userInfo = [response notification].request.content.userInfo;
    
    id customInfo = [userInfo objectForKey:@"custom"];
    if([customInfo isKindOfClass:[NSString class]]){
        NSString *custom = (NSString *)customInfo;
        if([custom isEqualToString:@"READY:RankPK"] || [custom isEqualToString:@"READY:RankHQ"]){
            // 跳转排行榜
            if(![FSGlobalLauncher launcher].isInChatting && ![FSGlobalLauncher launcher].isInPlayGame){
                // 跳转
                [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationChangeToRankPK object:nil];
            }
        }
    }
    
    completionHandler();
}

// App 在前台弹通知需要调用这个接口
//- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
//    [[XGPush defaultManager] reportXGNotificationInfo:notification.request.content.userInfo];
//    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
//}
#endif

- (void)xgPushDidReceiveRemoteNotification:(id)notification withCompletionHandler:(void (^)(NSUInteger))completionHandler {
    if ([notification isKindOfClass:[NSDictionary class]]) {
        [[XGPush defaultManager] reportXGNotificationInfo:(NSDictionary *)notification];
        completionHandler(UIBackgroundFetchResultNewData);
    } else if (@available(iOS 10.0, *)) {
        if ([notification isKindOfClass:[UNNotification class]]) {
            [[XGPush defaultManager] reportXGNotificationInfo:((UNNotification *)notification).request.content.userInfo];
            completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
        }
    } else {
        // Fallback on earlier versions
        completionHandler(UIBackgroundFetchResultNewData);
    }
}

- (void)xgPushDidSetBadge:(BOOL)isSuccess error:(NSError *)error {
    NSLog(@"%s, result %@, error %@", __FUNCTION__, error?@"NO":@"OK", error);
}

@end
