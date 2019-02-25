//
//  UIScrollView+EdgePan.m
//  Ready
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "UIScrollView+EdgePan.h"

@implementation UIScrollView (EdgePan)

- (void)setOtherGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    objc_setAssociatedObject(self, @selector(otherGestureRecognizer), otherGestureRecognizer, OBJC_ASSOCIATION_RETAIN);
}
- (UIGestureRecognizer *)otherGestureRecognizer {
    UIGestureRecognizer *otherGesture = objc_getAssociatedObject(self, _cmd);;
    return otherGesture;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([otherGestureRecognizer isEqual:[self otherGestureRecognizer]]) {
        return YES;
    }
    return NO;
}


- (void)setupShouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    [self setOtherGestureRecognizer:otherGestureRecognizer];
}

@end
