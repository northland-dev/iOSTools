//
//  FSCheckPhotosPrivileges.m
//  7nujoom
//
//  Created by 王明 on 2017/9/13.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSCheckPhotosPrivileges.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@implementation FSCheckPhotosPrivileges

- (void)checkPrivileges:(CheckPermissionResult)result {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        int author = [ALAssetsLibrary authorizationStatus];
        //ALAuthorizationStatus author = [ALAssetsLibraryauthorizationStatus];
        if(author == AVAuthorizationStatusRestricted || author == AVAuthorizationStatusDenied){
            //isAvailable = NO;
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//                NSString *message = nil;
//
//                if (AR == 1) {
//                    message = [SharedLanguages CustomLocalizedStringWithKey:@"MessageNoAccess"];
//                }else if (TR == 1){
//                    message = [SharedLanguages CustomLocalizedStringWithKey:@"MessageNoAccess"];
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
        else if (author == AVAuthorizationStatusNotDetermined) {
            //第一次使用
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    if (result) {
                        result(YES);
                    }
                }else {
                    if (result) {
                        result(NO);
                    }
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
