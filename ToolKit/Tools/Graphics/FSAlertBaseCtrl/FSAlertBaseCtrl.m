//
//  FSAlertBaseCtrl.m
//  7nujoom
//
//  Created by luyee on 2018/7/4.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSAlertBaseCtrl.h"

@interface FSAlertBaseCtrl ()<UIGestureRecognizerDelegate>

@end

@implementation FSAlertBaseCtrl{
    AppearencePosition _position;
    CGRect _alertViewFrame;
    void (^_showFinishedFun)();
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self updateInitWith];
    }
    return self;
}

- (void)updateInitWith{
    WeakSelf(self);
    self.view.cpBgColor([UIColor clearColor]);
    self.alertWindow = UIWindow .new .cpWindowLevel(UIWindowLevelAlert) .cpFrame(UIScreen.mainScreen.bounds) .cpHidden(NO) .cpBgColor(HexRGBAlpha(0x000000, 0.3));
    [self.alertWindow makeKeyAndVisible];
    self.alertWindow .cpAdd(self.view);
//    addNoticeObserver(self, @selector(didReceivePopViewNotification:), kNSNotificationUserLoginOut, nil);
}

- (FSAlertBaseCtrl *(^)(BOOL))setIsTapped{
    return ^(BOOL isTap){
        if (isTap) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
            tap.delegate = self;
            [self.view addGestureRecognizer:tap];
        }
        return self;
    };
}

+ (FSAlertBaseCtrl *(^)(UIView *alertView))showWith{
    return ^(UIView *alertView){
        FSAlertBaseCtrl *alertCtrl = FSAlertBaseCtrl.new;
        [alertCtrl.view addSubview:alertView];
        alertCtrl.alertView = alertView;
        return alertCtrl;
    };
    
}

- (FSAlertBaseCtrl *(^)(AppearencePosition, void (^)()))setAppearencePosition{
    return ^(AppearencePosition position, void (^showFinishedFun)()){
        _position = position;
        _showFinishedFun = showFinishedFun;
        switch (position) {
            case AppearencePositionTop:
                self.alertView.y = - self.view.height;
                break;
            case AppearencePositionLeft:
                self.alertView.x = - self.view.width;
                break;
            case AppearencePositionBottom:
                self.alertView.y = self.view.height;
                break;
            case AppearencePositionRight:
                self.alertView.x = self.view.width;
                break;
            case AppearencePositionCenter:{
                CGPoint point = self.alertView.center;
                _alertViewFrame = self.alertView.frame;
                self.alertView.frame = CGRectZero;
                self.alertView.center = point;
            }
                break;
        }
        [self show];
        return self;
    };
}

- (void)animateIsShow:(BOOL)isShow{
    CGRect frame = self.alertView.frame;
    switch (_position) {
        case AppearencePositionTop:{
            if (isShow) {
                frame.origin.y += frame.size.height;
            }else{
                frame.origin.y -= frame.size.height;
            }
        }
            break;
        case AppearencePositionLeft:{
            if (isShow) {
                frame.origin.x += frame.size.width;
            }else{
                frame.origin.x -= frame.size.width;
            }
        }
            break;
        case AppearencePositionBottom:{
            if (isShow) {
                frame.origin.y -= frame.size.height;
            }else{
                frame.origin.y += frame.size.height;
            }
        }
            break;
        case AppearencePositionRight:{
            if (isShow) {
                frame.origin.x -= frame.size.width;
            }else{
                frame.origin.x += frame.size.width;
            }
        }
            break;
        case AppearencePositionCenter:{
            if (isShow) {
                frame = _alertViewFrame;
            }else{
                frame = CGRectMake(self.alertView.centerX, self.alertView.centerY, 0, 0);
            }
        }
            break;
            
        default:
            break;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.alertView.frame = frame;
    } completion:^(BOOL finished) {
        if (isShow && _showFinishedFun) {
            _showFinishedFun();
        }else if(!isShow){
            [self.alertView removeFromSuperview];
            self.alertWindow.hidden = YES;
            [self.alertWindow resignKeyWindow];
            [self.view removeFromSuperview];
            self.alertWindow = nil;
        }
    }];
}

- (void)show{
    [self animateIsShow:YES];
}

- (void)dismiss{
    [self animateIsShow:NO];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return [touch.view isEqual:self.view];
}

- (void)didReceivePopViewNotification:(NSNotification *)notice{
//    if ([notice.name isEqualToString:kNSNotificationUserLoginOut]) {
        WeakSelf(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself dismiss];
        });
//    }
}

@end
