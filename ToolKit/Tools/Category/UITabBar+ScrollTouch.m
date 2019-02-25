//
//  UITabBar+ScrollTouch.m
//  Ready
//
//  Created by mac on 2018/9/19.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "UITabBar+ScrollTouch.h"

@implementation UITabBar (ScrollTouch)
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.hidden) {
        return NO;
    }
    return [super pointInside:point withEvent:event];
}
@end
