//
//  YKInsetLabel.m
//  YikeTalks
//
//  Created by Charles on 2018/4/2.
//  Copyright © 2018年 yike. All rights reserved.
//

#import "FSInsetLabel.h"
@interface FSInsetLabel()
@property(nonatomic,assign)UIEdgeInsets insets;
@end
@implementation FSInsetLabel

- (instancetype)initWithInset:(UIEdgeInsets)insets{
    if (self = [super init]) {
        self.insets = insets;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _insets)];
}
@end
