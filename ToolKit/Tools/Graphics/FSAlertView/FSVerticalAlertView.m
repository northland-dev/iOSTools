//
//  FSVerticalAlertView.m
//  Lolly
//
//  Created by mac on 2018/8/21.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSVerticalAlertView.h"

@implementation FSVerticalAlertView

- (void)createSubviews {
    [super createSubviews];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(23);
        make.left.equalTo(self.mas_left).offset(34);
        make.right.equalTo(self.mas_right).offset(-34);
    }];
    
    [self.defaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.mas_bottom).offset(41);
        make.size.mas_equalTo(CGSizeMake(GTFixWidthFlaot(180), 36));
        make.centerX.equalTo(self);
    }];
    
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.defaultButton.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(GTFixWidthFlaot(180), 36));
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-14);
    }];
}
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    
    if (self.superview) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.superview.mas_left).offset(41);
            make.right.equalTo(self.superview.mas_right).offset(-41);
            make.centerY.equalTo(self.superview.mas_centerY);
        }];
    }
}
- (void)dealloc {
    NSLog(@"FSVerticalAlertView dealloc");
}
@end
