//
//  FSAlertBaseCtrl.h
//  7nujoom
//
//  Created by luyee on 2018/7/4.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AppearencePosition) {
    AppearencePositionTop,
    AppearencePositionLeft,
    AppearencePositionBottom,
    AppearencePositionRight,
    AppearencePositionCenter,
};

@class FSLiveMicQueueView,FSAlertBaseCtrl;

@interface FSAlertBaseCtrl : UIViewController

@property (nonatomic, strong) UIWindow *alertWindow;

@property (nonatomic, weak) UIView *alertView;

+ (FSAlertBaseCtrl *(^)(UIView *alertView))showWith;

- (FSAlertBaseCtrl *(^)(AppearencePosition position, void (^)()))setAppearencePosition;

- (FSAlertBaseCtrl *(^)(BOOL isTapped))setIsTapped;

- (void)dismiss;

@end
