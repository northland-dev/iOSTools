//
//  UIViewController+TopVisioClass.m
//  Ready
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "UIViewController+TopVisioClass.h"

@implementation UIViewController (TopVisioClass)

- (UIViewController *)topControlllerWithRootController:(UIViewController *)controller {
    if(!controller) return nil;
    
    if (controller.presentedViewController != nil) {
        return [self topControlllerWithRootController:controller.presentedViewController];
    }else if ([controller isKindOfClass:[UITabBarController class]]){
        return [self topControlllerWithRootController:[(UITabBarController *)controller selectedViewController]];
    }else if ([controller isKindOfClass:[UINavigationController class]]){
        return [self topControlllerWithRootController:[(UINavigationController *)controller visibleViewController]];
    }else{
        return controller;
    }
}


- (UIWindow *)topVisibleWindow {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window.windowLevel != UIWindowLevelNormal) {
        for (UIWindow *childWindow in [UIApplication sharedApplication].windows) {
            if (childWindow.windowLevel == UIWindowLevelNormal) {
                window = childWindow;
                break;
            }
        }
    }
    return window;
}
@end
