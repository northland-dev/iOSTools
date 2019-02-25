//
//  UITabBar+Awesome.m
//  7nujoom
//
//  Created by Charles on 2017/7/21.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "UITabBar+Awesome.h"
#import <objc/objc.h>
#import "NSString+GC.h"

@implementation UITabBar (Awesome)
static const char overlayKey = '\0';
-(UIView *)overlay{
    return objc_getAssociatedObject(self, &overlayKey);
}
- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//- (void)layoutSubviews{
//
//}
- (void)gc_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        
      
//        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + SafeAreaBottomHeight)];
        self.overlay.userInteractionEnabled = NO;
//        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
//        UIView *view = [self.subviews firstObject];
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;//[UIColor redColor];
}

@end
