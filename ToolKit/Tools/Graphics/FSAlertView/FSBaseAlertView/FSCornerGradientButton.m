//
//  FSCornerGradientButton.m
//  Ready
//
//  Created by mac on 2018/8/21.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSCornerGradientButton.h"

@implementation FSCornerGradientButton{
    CAShapeLayer *_maskShapLayer;
}
- (instancetype)init {
    if(self = [super init]){
        _maskShapLayer = [CAShapeLayer layer];
        _maskShapLayer = [CAShapeLayer layer];
        _maskShapLayer.fillMode = kCAFillModeForwards;
        _maskShapLayer.fillColor =  [[UIColor redColor] CGColor];
        _maskShapLayer.strokeColor  = [[UIColor blueColor] CGColor];
        _maskShapLayer.lineCap = kCALineCapRound;
        _maskShapLayer.lineWidth = 8.0;
        _maskShapLayer.strokeEnd = 0;
        _maskShapLayer.fillRule = kCAFillRuleEvenOdd;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIBezierPath *pathMask = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:18];
    _maskShapLayer.path = pathMask.CGPath;
    [self.layer setMask:_maskShapLayer];
}


@end
