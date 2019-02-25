//
//  FSSystemShareManage.m
//  7nujoom
//
//  Created by 王明 on 16/6/24.
//  Copyright © 2016年 Fission. All rights reserved.
//

#import "FSSystemShareManage.h"

@implementation FSSystemShareManage

+ (void)fsSystemShareViewShowWithContent:(NSString *)shareContent image:(UIImage *)shareImage url:(NSURL *)shareUrl fromController:(UIViewController *)viewController result:(ShareResult)shareResult {
    NSMutableArray *contentArray = [NSMutableArray arrayWithCapacity:0];
    if (shareContent != nil) {
        [contentArray addObject:shareContent];
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
    }
    else {
        if (shareImage != nil) {
            [contentArray addObject:shareImage];
        }
    }
    
    if (shareUrl != nil) {
        [contentArray addObject:shareUrl];
    }
    
    if (!viewController) {
        viewController = [FSSystemShareManage getCurrentVC];
    }
    
    UIActivityViewController *activeViewController = [[UIActivityViewController alloc]initWithActivityItems:contentArray applicationActivities:nil];
    //不显示哪些分享平台(具体支持那些平台，可以查看Xcode的api)
    [viewController presentViewController:activeViewController animated:YES completion:nil];
    //分享结果回调方法
    UIActivityViewControllerCompletionWithItemsHandler myblock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        NSLog(@"%d %@",completed,activityType);
        BOOL isSuccess = NO;
        if (completed) {
            isSuccess = YES;
//            [GlobelHttpTool shareRoom:(int)self.roomId shareType:3 isLogin:[[SharedUser SharedUser] Logined] withCallback:^(int errorCode, NSDictionary *datainfo) {
//                
//            }];
        }
        else {
            if (activityType == UIActivityTypePostToTwitter) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"NoTwitterTitle"] message:[FSSharedLanguages CustomLocalizedStringWithKey:@"NoTwitterMessage"] delegate:nil cancelButtonTitle:[FSSharedLanguages CustomLocalizedStringWithKey:@"NoTwitterOK"] otherButtonTitles:nil];
                [alertView show];
            }
            
        }
        if (shareResult) {
            shareResult(isSuccess,activityType);
        }
    };
    activeViewController.completionWithItemsHandler = myblock;
}

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


@end
