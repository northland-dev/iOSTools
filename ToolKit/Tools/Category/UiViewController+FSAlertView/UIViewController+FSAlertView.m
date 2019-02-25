//
//  UIViewController+FSAlertView.m
//  Ready
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "UIViewController+FSAlertView.h"


@implementation UIViewController (FSAlertView)
- (void)showVerticalWithMessage:(NSString *)message
                  defaultButton:(NSString *)defaultButton
                   cancleButton:(NSString *)cancleButton
                    defaultFunc:(FSAlertFunction)defaultFunc cancleFunc:(FSAlertFunction)cancleFuc {
    FSVerticalAlertView *alertView = [[FSVerticalAlertView alloc] initWithMessage:message defautButtonTitle:defaultButton cancleTitle:cancleButton];
    
    WS(weaks);
    FSAlertFunction containCancleFunc = ^(void){
        if (cancleFuc) {
            cancleFuc();
        }
        [weaks lew_dismissPopupView];
    };
    
    [alertView addCancleButtonFunction:containCancleFunc];
    
    FSAlertFunction containDefaultFunc = ^(void){
        if (defaultFunc) {
            defaultFunc();
        }
        [weaks lew_dismissPopupView];
    };
    
    [alertView addDefultButtonFunction:containDefaultFunc];
    
    id<LewPopupAnimation> animation = [LewPopupViewAnimationSpring new];
    [self lew_presentPopupView:alertView animation:animation];
}

- (void)showHorizontalWithMessage:(NSString *)message
                    defaultButton:(NSString *)defaultButton
                     cancleButton:(NSString *)cancleButton
                      defaultFunc:(FSAlertFunction)defaultFunc
                       cancleFunc:(FSAlertFunction)cancleFuc {
    
    FSHorizontalAlertView *alertView = [[FSHorizontalAlertView alloc] initWithMessage:message defautButtonTitle:defaultButton cancleTitle:cancleButton];
    
    WS(weaks);
    FSAlertFunction containCancleFunc = ^(void){
        if (cancleFuc) {
            cancleFuc();
        }
        [weaks lew_dismissPopupView];
    };
    
    [alertView addCancleButtonFunction:containCancleFunc];
    
    FSAlertFunction containDefaultFunc = ^(void){
        if (defaultFunc) {
            defaultFunc();
        }
        [weaks lew_dismissPopupView];
    };
    
    [alertView addDefultButtonFunction:containDefaultFunc];
    
    id<LewPopupAnimation> animation = [LewPopupViewAnimationSpring new];
    [self lew_presentPopupView:alertView animation:animation];
    
}
@end
