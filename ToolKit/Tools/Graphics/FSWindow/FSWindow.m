//
//  FSWindow.m
//  Ready
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSWindow.h"
#import "FSUpgradeView.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationDrop.h"

#import "FSUpgradeEvent.h"
#import "FSSerialEventBuilder.h"


@interface FSWindow()<FSUpgradeServerDelegate,FSUpgradeEventDelegate>{
    BOOL _haveRequested;
}

@end

@implementation FSWindow

#pragma mark - override
- (void)becomeKeyWindow {
    [super becomeKeyWindow];
    
    if (!_haveRequested) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestAppUpgradeInfo];
            _haveRequested = YES;
        });
    }

}

- (void)requestAppUpgradeInfo {
    [FSUpgradeServer sharedInstance].delegate = self;
    [[FSUpgradeServer sharedInstance] requestUpgradeInfo];
}

#pragma mark - FSUpgradeServerDelegate
- (void)onGetUpgradeInfo:(FSAppUpgradeInfo *)appUpgradeInfo error:(NSError *)error {
    // 
    FSUpgradeEvent *upgradeEvent = [[FSUpgradeEvent alloc] initWithInfo:appUpgradeInfo];
    [upgradeEvent setEventDelegate:self];
    // 注入事件
    [[FSSerialEventBuilder sharedBuilder] insertEvent:upgradeEvent];
    [[FSSerialEventBuilder sharedBuilder] startEvent];
}
- (void)upgradeEventDoEvent:(FSUpgradeEvent *)upgradeEvent {

    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    BOOL installBefore = [udf boolForKey:FirstInstallAppKey];
    if (!installBefore) {
        return;
    }
    
    FSAppUpgradeInfo *appUpgradeInfo = upgradeEvent.upgradeInfo;
    
    NSString *message = [appUpgradeInfo getContentString]?:@"服务端没有配置当前语言的数据";
    FSUpgradeView *upgradeView = [[FSUpgradeView alloc] initWithMessage:message defautButtonTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"Upgrade"] cancleTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"Cancle"]];
    NSComparisonResult compareMin = [APP_VERSION compare:appUpgradeInfo.supportMinVersionCode];
    NSComparisonResult compareAdvice = [APP_VERSION compare:appUpgradeInfo.adviceMinVersionCode];
    if (compareMin == NSOrderedAscending) {
        // 强制升级
        [upgradeView setMessageTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@" "]];
        [upgradeView addDefultButtonFunction:^{
            //
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APPSTORE_DOWNLOAD,APPSTORE_ID]];
            
            if([[UIApplication sharedApplication] canOpenURL:url]){
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        [upgradeView addCancleButtonFunction:^{
            exit(0);
        }];
        [self.rootViewController lew_presentPopupView:upgradeView animation:[LewPopupViewAnimationDrop new] backgroundClickable:NO];
    }else if (compareAdvice == NSOrderedAscending){
        [upgradeView setMessageTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@" "]];
        
        [upgradeView addDefultButtonFunction:^{
            //
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APPSTORE_DOWNLOAD,APPSTORE_ID]];
            
            if([[UIApplication sharedApplication] canOpenURL:url]){
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        [upgradeView addCancleButtonFunction:^{
            [self.rootViewController lew_dismissPopupView];
            [upgradeEvent finishEvent];
        }];
        [self.rootViewController lew_presentPopupView:upgradeView animation:[LewPopupViewAnimationDrop new] backgroundClickable:NO];
    }else{
        // 没有操作
        [upgradeEvent finishEvent];
    }
}

#pragma mark - private methods
- (void)showUpdateView {

}

@end
