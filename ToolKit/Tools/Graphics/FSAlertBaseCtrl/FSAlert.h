//
//  FSAlert.h
//  Ready
//
//  Created by luyee on 2018/9/2.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSAlertBaseCtrl.h"

typedef NS_ENUM(NSInteger, FSAlertType) {
    FSAlertTypeHud
};

@interface FSAlert : UIView

@property (nonatomic, strong) FSAlertBaseCtrl *alertCtrl;

+ (void)showMessage:(NSString *)msg;

@end
