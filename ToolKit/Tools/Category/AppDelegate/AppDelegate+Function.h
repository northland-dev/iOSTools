//
//  AppDelegate+Function.h
//  Ready
//
//  Created by mac on 2018/7/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "AppDelegate.h"

@protocol XGPushDelegate;
@interface AppDelegate (Function)<XGPushDelegate>
- (void)registerPushNotiifcation:(UIApplication *)application;
- (void)ConfigAspect;
- (void)ConfigBugly;
- (void)ConfigAjust;
- (void)requestTenor;
- (void)ConfigSDWebImage;
- (void)configFMDBFile;
- (void)configAppsflyer;
- (void)configShareKit;
- (void)configHttpServer;
- (void)configLanguage;
- (void)configQQPush:(NSDictionary *)launchOptions;

- (void)applicationDidReceiveDeviceToken:(NSData *)deviceToken;

@end
