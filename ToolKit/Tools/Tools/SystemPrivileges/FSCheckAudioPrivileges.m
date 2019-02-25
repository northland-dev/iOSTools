//
//  FSCheckAudioPrivileges.m
//  7nujoom
//
//  Created by 王明 on 16/6/29.
//  Copyright © 2016年 Fission. All rights reserved.
//

#import "FSCheckAudioPrivileges.h"
#import <AVFoundation/AVFoundation.h>

@implementation FSCheckAudioPrivileges

- (void)checkPrivileges:(CheckPermissionResult)result {
    //第一次调用这个方法的时候，系统会提示用户让他同意你的app获取麦克风的数据
    // 其他时候调用方法的时候，则不会提醒用户
    // 而会传递之前的值来要求用户同意
    AVAudioSessionRecordPermission permission = [[AVAudioSession sharedInstance] recordPermission];
    if (permission == AVAudioSessionRecordPermissionUndetermined) {
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            if (result) {
                result(granted);
            }
        }];
    } else {
        if (result) {
            result(AVAudioSessionRecordPermissionGranted == permission);
        }
    }

}

//#pragma mark - FSNewestAlertViewDelegate
//- (void)FSNewestAlertView:(FSNewestAlertView *)alertView didSelectButtonIndex:(NSInteger)index {
//    if (index == 1) {
//        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//            
//        if([[UIApplication sharedApplication] canOpenURL:url]) {
//            
//            [[UIApplication sharedApplication] openURL:url];
//        }
//    }
//}

@end
