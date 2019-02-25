//
//  UIViewController+GCPopUp.m
//  Ready
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "UIViewController+GCPopUp.h"
#import <objc/NSObjCRuntime.h>

static NSString *viewDissmissActionKey = @"viewDissmissActionKey";
static NSString *viewLewPopupAnimationKey = @"viewLewPopupAnimationKey";

@interface UIViewController(GCPopUpPorperties)
@property(nonatomic,strong)UIView *currentPopUpView;
@end

@implementation UIViewController (GCPopUp)

#pragma mark -
- (void)setGcContainerView:(UIView *)gcContainerView {
    objc_setAssociatedObject(self, @selector(gcContainerView), gcContainerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)gcContainerView {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setGcPopUpBackView:(UIView *)gcPopUpBackView {
    objc_setAssociatedObject(self, @selector(gcPopUpBackView), gcPopUpBackView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)gcPopUpBackView {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setCurrentPopUpView:(UIView *)currentPopUpView {
    objc_setAssociatedObject(self, @selector(currentPopUpView), currentPopUpView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)currentPopUpView {
    return objc_getAssociatedObject(self, _cmd);
}
#pragma mark -
- (void)gc_presentPopupView:(UIView *)view popUpAnimation:(id<LewPopupAnimation>)animation backClickAble:(BOOL)clickAble dismissAction:(GCAction)dismissAction {
    
    if (!view) return;
    if ([self.gcContainerView.subviews containsObject:view]) return;
    
    if (self.currentPopUpView) {
        [self gc_removePopedView];
    }
    
    objc_setAssociatedObject(view, &viewLewPopupAnimationKey, animation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(view, &viewDissmissActionKey, dismissAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
    view.tag = 8002;
    self.currentPopUpView = view;

    
    UIView *sourceView = [self ancestorView];
    
    if (self.gcContainerView == nil) {
        UIView *containerView = [[UIView alloc] initWithFrame:sourceView.bounds];
        containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        containerView.tag = 8003;
        // BackgroundView
        UIView *backgroundView = [[UIView alloc] initWithFrame:sourceView.bounds];
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [backgroundView setBackgroundColor:HexRGBAlpha(0x000000, 0.8)];
        self.gcPopUpBackView = backgroundView;
        [containerView addSubview:backgroundView];
        
        if (clickAble) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gc_dissmissPopupview)];
            [backgroundView addGestureRecognizer:tap];
        }
        self.gcContainerView = containerView;
    }
    
    [self.gcContainerView addSubview:view];
    [sourceView addSubview:self.gcContainerView];

    if (animation) {
        [animation showView:self.currentPopUpView overlayView:self.gcContainerView];
    }
}
- (void)gc_dissmissPopupview {
    [self gc_dissmissPopupview:nil];
}
- (void)gc_dissmissPopupview:(id<LewPopupAnimation>)animation {
    [self gc_dissmissPopupview:animation complete:nil];
}
- (void)gc_dissmissPopupview:(id<LewPopupAnimation>)animation complete:(GCAction)complete {
    __weak typeof(self) weaks = self;
    if (animation) {
        [animation dismissView:self.currentPopUpView overlayView:self.gcContainerView completion:^{
            [weaks gc_removePopedView];
            
            if (complete) {
                complete();
            }
        }];
    }else {
        id<LewPopupAnimation> popUpAnimation = objc_getAssociatedObject(self.currentPopUpView, &viewLewPopupAnimationKey);
        if (popUpAnimation) {
            [popUpAnimation dismissView:self.currentPopUpView overlayView:self.gcPopUpBackView completion:^{
                [weaks gc_removePopedView];
                
                if (complete) {
                    complete();
                }
            }];
        }else{
            [weaks gc_removePopedView];
            
            if (complete) {
                complete();
            }
        }
    }
}

- (void)gc_removePopedView{
    GCAction dismissAction = objc_getAssociatedObject(self.currentPopUpView, &viewDissmissActionKey);
    [self.gcContainerView removeFromSuperview];
    [self.currentPopUpView removeFromSuperview];
    objc_removeAssociatedObjects(self.currentPopUpView);
    self.gcContainerView = nil;
    self.currentPopUpView = nil;
    
    if (dismissAction) {
        dismissAction();
    }
}


- (UIView *)ancestorView {
    UIView *ancestoreView = self.view;
    UIViewController *parentController = self.parentViewController;
    while (parentController) {
        ancestoreView = parentController.view;
        parentController = parentController.parentViewController;
    }
    return ancestoreView;
}
@end
