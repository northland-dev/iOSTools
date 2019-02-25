//
//  UIViewController+FSAlertView.h
//  Ready
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LewPopupBackgroundView.h"
#import "LewPopupViewAnimationDrop.h"
#import "LewPopupViewAnimationSpring.h"
#import "LewPopupViewAnimationFade.h"

#import "FSVerticalAlertView.h"
#import "FSHorizontalAlertView.h"

@interface UIViewController (FSAlertView)
- (void)showVerticalWithMessage:(NSString *)message
                  defaultButton:(NSString *)defaultButton
                   cancleButton:(NSString *)cancleButton
                    defaultFunc:(FSAlertFunction)defaultFunc
                     cancleFunc:(FSAlertFunction)cancleFuc;

- (void)showHorizontalWithMessage:(NSString *)message
                  defaultButton:(NSString *)defaultButton
                   cancleButton:(NSString *)cancleButton
                    defaultFunc:(FSAlertFunction)defaultFunc
                     cancleFunc:(FSAlertFunction)cancleFuc;
@end
