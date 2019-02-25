//
//  FSBaseView.m
//  Ready
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSBaseView.h"

@implementation FSBaseView

- (instancetype)init {
    if (self = [super init]) {
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews {}

@end
