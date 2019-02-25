//
//  UIView+Corner.m
//  Ready
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "UIView+Corner.h"

@implementation UIView (Corner)
- (CAShapeLayer *)shapeLayer {
    return objc_getAssociatedObject(self,_cmd);
}
- (void)setShapeLayer:(CAShapeLayer *)shapeLayer {
    objc_setAssociatedObject(self, @selector(shapeLayer), shapeLayer, OBJC_ASSOCIATION_RETAIN);
}
- (void)gc_createShapeLayer {
    if (!self.shapeLayer) {
        CAShapeLayer *shaperLayer = [CAShapeLayer layer];
        [shaperLayer setFrame:self.bounds];
        [self setShapeLayer:shaperLayer];
    }
}
- (void)makeCornerAllWithRadious:(CGFloat)radious {
    
    [self gc_createShapeLayer];
    
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radious];
    [self.shapeLayer setPath:cornerPath.CGPath];
    [self.layer setMask:self.shapeLayer];
}
- (void)makeCornerWithCornerRect:(UIRectCorner)corner cornerRadius:(CGFloat)radius {
    
    [self gc_createShapeLayer];
    
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    if (!CGPathEqualToPath(cornerPath.CGPath, self.shapeLayer.path)) {
        
        [self.shapeLayer setPath:cornerPath.CGPath];
    }
    [self.layer setMask:self.shapeLayer];
}
- (void)clearCorner {
    [self.layer setMask:nil];
}
@end
