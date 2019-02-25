//
//  UIViewController+Alert.m
//  Lolly
//
//  Created by Charles on 2017/11/9.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "UIViewController+Alert.h"
#import <objc/runtime.h>
#import "FSAlertView.h"
#import "FSToasManager.h"
static char gc_alertView;
@interface UIViewController(GCAlert)<FSAlertViewDelegate>

@end

@implementation UIViewController (Alert)
@dynamic dismissDelayTime;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
// 要在添加子视图的时候把alert 放到最上面
//- (void)viewWillLayoutSubviews {
//    FSAlertView *alert = objc_getAssociatedObject(self, &gc_alertView);
//    if (alert) {
//        NSInteger alertIndex = [self.view indexOfAccessibilityElement:alert];
//        if (alertIndex != [self.view.subviews count]) {
//            [self.view bringSubviewToFront:alert];
//        }
//    }
//}
#pragma clang diagnostic pop

- (void)showAlertWithMessage:(NSString *)message {
    if (!message) {
        return;
    }
    [self showSelfDissmissAlert:message];
}
- (void)showSelfDissmissAlert:(NSString *)willShowedAlert{
    // 添加
//    FSAlertView *alertView = [[FSAlertView alloc] initWithFrame:self.view.bounds withMessage:willShowedAlert];
//    UIView *topView = [self viewControllerTopView];
//    [topView addSubview:alertView];
//    objc_setAssociatedObject(self, &gc_alertView, alertView, OBJC_ASSOCIATION_RETAIN);
    
    [[FSToasManager sharedManager] showToastWithTitle:nil message:willShowedAlert];
}
- (UIView *)viewControllerTopView {
    if (self.navigationController) {
        return self.navigationController.view;
    }
    return self.view;
}
@end
