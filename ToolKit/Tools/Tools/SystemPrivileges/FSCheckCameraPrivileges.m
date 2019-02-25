//
//  FSCheckCameraPrivileges.m
//  7nujoom
//
//  Created by 王明 on 16/6/29.
//  Copyright © 2016年 Fission. All rights reserved.
//

#import "FSCheckCameraPrivileges.h"
#import <AVFoundation/AVFoundation.h>


@implementation FSCheckCameraPrivileges

- (void)checkPrivileges:(CheckPermissionResult)result {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
            //isAvailable = NO;
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//                NSString *message = nil;
//
//                if (AR == 1) {
//                    message = [SharedLanguages CustomLocalizedStringWithKey:@"RequestCameraRightAR"];
//                }else if (TR == 1){
//                    message = [SharedLanguages CustomLocalizedStringWithKey:@"RequestCameraRightTR"];
//                }
//                FSNewestAlertView *alertView = [[FSNewestAlertView alloc] initWithFrame:ScreenF titleImage:[UIImage imageNamed:@"help_logo"] message:message cancelButton:[SharedLanguages CustomLocalizedStringWithKey:@"RequestSystemPrivilegesCancelText"] otherButton:[SharedLanguages CustomLocalizedStringWithKey:@"RequestSystemPrivilegesSetText"]];
//                alertView.delegate = self;
//                alertView.tag = 1001;
//                [alertView show];
//            });
            if (result) {
                result(NO);
            }
            
        }
        else if (authStatus == AVAuthorizationStatusNotDetermined) {
            //第一次使用
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                if (result) {
                    result(granted);
                }
            }];
        }
        else {
            if (result) {
                result(YES);
            }
            
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
