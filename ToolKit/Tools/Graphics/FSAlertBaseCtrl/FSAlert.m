//
//  FSAlert.m
//  Ready
//
//  Created by luyee on 2018/9/2.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSAlert.h"

@implementation FSAlert

+ (instancetype)showMessage:(NSString *)msg{
    FSAlert *selfInstance = [[FSAlert alloc] init];
    WeakSelf(selfInstance);
    selfInstance.alertCtrl = FSAlertBaseCtrl.showWith(weakselfInstance).setAppearencePosition(AppearencePositionBottom, nil);
    
    [selfInstance mas_makeConstraints:^(MASConstraintMaker *make) {
        make .center .equalTo( selfInstance.alertCtrl.view);
        make .left .equalTo( selfInstance.alertCtrl.view) .offset( WidthScale(48.0));
        make .height .equalTo( selfInstance .mas_width) .multipliedBy( 428.0/ 278.0);
    }];
    
    return selfInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
