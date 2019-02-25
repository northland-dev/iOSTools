//
//  FSHorizontalAlertView.m
//  Ready
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSHorizontalAlertView.h"

@implementation FSHorizontalAlertView

- (void)createSubviews {
    [super createSubviews];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(23);
        make.left.equalTo(self.mas_left).offset(34);
        make.right.equalTo(self.mas_right).offset(-34);
    }];
    
    [self.defaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.mas_bottom).offset(51);
//        make.size.mas_equalTo(CGSizeMake(98, 36));
        make.height.mas_equalTo(36);
        make.left.equalTo(self.mas_centerX).offset(10);
        make.right.equalTo(self.messageLabel.mas_right);
    }];
    
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.mas_bottom).offset(51);
//        make.size.mas_equalTo(CGSizeMake(98, 36));
        make.left.equalTo(self.messageLabel.mas_left);
        make.height.mas_equalTo(36);
        make.right.equalTo(self.mas_centerX).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-14);
    }];
}
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    
    if (self.superview) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.superview.mas_left).offset(49);
            make.right.equalTo(self.superview.mas_right).offset(-49);
            make.centerY.equalTo(self.superview.mas_centerY);
        }];
    }
}
- (void)dealloc {
    NSLog(@"FSHorizontalAlertView dealloc");
}
@end
