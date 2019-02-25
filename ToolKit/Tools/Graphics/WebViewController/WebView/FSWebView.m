//
//  FSWebView.m
//  Ready
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSWebView.h"
#import "UIScrollView+EdgePan.h"

@interface FSWebView()
@end
@implementation FSWebView

- (void)setupShouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    [self.scrollView setupShouldRequireFailureOfGestureRecognizer:otherGestureRecognizer];
}

@end
