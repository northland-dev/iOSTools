//
//  FSCircleAnimationView.m
//  Ready
//
//  Created by luyee on 2018/9/2.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSCircleAnimationView.h"

@interface FSCircleAnimationViews ()

@property (nonatomic, strong) CAShapeLayer * progressLayer;
@property (nonatomic, strong) CAGradientLayer * gradientLayer;

@end

@implementation FSCircleAnimationViews{
    CGFloat _lineWidth;
}

- (instancetype)initWithLineWidth:(CGFloat)lineWidth{
    if (self = [super init]) {
        _lineWidth = lineWidth;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!_gradientLayer && self.width) {        
        [self.layer addSublayer:self.gradientLayer];
        [self.layer setMask:self.progressLayer];
    }
}

- (CAGradientLayer *)gradientLayer{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        [_gradientLayer setColors:[NSArray arrayWithObjects:UIColor.cpHex( @"#E261FA").CGColor,UIColor.cpHex( @"#FF5353").CGColor, nil]];
        [_gradientLayer setLocations:@[@0.5]];
        [_gradientLayer setStartPoint:CGPointMake(0, 0)];
        [_gradientLayer setEndPoint:CGPointMake(1, 1)];
        _gradientLayer.type = kCAGradientLayerAxial;
    }
    return _gradientLayer;
}

- (CAShapeLayer *)progressLayer{
    if (!_progressLayer) {
        CGRect rect = self.bounds;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.center radius:(self.width -_lineWidth)/2 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeColor = UIColor.cpHex( @"#FF5353").CGColor;
        _progressLayer.lineWidth = _lineWidth;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.path = path.CGPath;
        _progressLayer.strokeEnd = 0.0f;
        self.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }
    return _progressLayer;
}

- (void)updateProgress:(NSString *)process {
    if (process.integerValue == 1) {
    }
    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [CATransaction setAnimationDuration:0.01];
    CGFloat processValue = process.integerValue / 100.0;
    NSLog(@"\n\n%f\n", processValue);
    self.progressLayer.strokeEnd = processValue;
    
    [CATransaction commit];
}

@end


