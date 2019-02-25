//
//  UIViewController+GCPopUp.h
//  Ready
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+LewPopupViewController.h"

typedef void(^GCAction)(void);
@interface UIViewController (GCPopUp)

@property(nonatomic,strong)UIView *gcContainerView;
@property(nonatomic,strong)UIView *gcPopUpBackView;

- (void)gc_presentPopupView:(UIView *)view
          popUpAnimation:(id<LewPopupAnimation>)animation
           backClickAble:(BOOL)clickAble
           dismissAction:(GCAction)dismissAction;

- (void)gc_dissmissPopupview;
- (void)gc_dissmissPopupview:(id<LewPopupAnimation>)animation;
- (void)gc_dissmissPopupview:(id<LewPopupAnimation>)animation complete:(GCAction)complete;


@end
