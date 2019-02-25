//
//  FSSoundAnimationView.m
//  Ready
//
//  Created by mac on 2018/10/25.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSSoundAnimationView.h"
@interface FSSoundAnimationView(){
    CAShapeLayer *_shapeLayer;
}
@end
@implementation FSSoundAnimationView
- (void)createSubviews {
    [super createSubviews];
    
    [self setClipsToBounds:NO];
    [self setUserInteractionEnabled:NO];
    
    _scale = 1.0;
    
    _shapeLayer = (CAShapeLayer *)self.layer;
    
    [self setFillType:(FSFillTypeUnKown)];
    
    [self setBackgroundColor:[UIColor clearColor]];
}
- (void)setFillType:(FSFillType)fillType {
    _fillType = fillType;
    
    switch (fillType) {
        case FSFillTypeGame:
            _shapeLayer.strokeColor=HexRGB(0xFFFFFF).CGColor;
            _shapeLayer.fillColor=HexRGB(0xFFFFFF).CGColor;
            break;
        case FSFillTypeDanmu:
            _shapeLayer.strokeColor=HexRGB(0x61E8FA).CGColor;
            _shapeLayer.fillColor=HexRGB(0x61E8FA).CGColor;
            break;
        case FSFillTypeUnKown:
            _shapeLayer.strokeColor=HexRGB(0xFFF100).CGColor;
            _shapeLayer.fillColor=HexRGB(0xFFF100).CGColor;
            break;
        default:
            break;
    }
}
- (void)setScale:(CGFloat)scale {
    
    float changed = MAX(0,1.0 - fabs(scale - _scale));
    
    _scale = scale;
    
    [UIView animateWithDuration:changed delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.transform = CGAffineTransformMakeScale(scale, scale);
    } completion:^(BOOL finished) {
//
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //半径
    CGFloat redbius = CGRectGetWidth(self.bounds)/2;
    //开始角度
    CGFloat startAngle = 0;
//    中心点
//    CGPoint point =  self.center; //CGPointMake(redbius, _CGfrom_x/2);
    //结束角
    CGFloat endAngle = 2*M_PI;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(redbius, redbius) radius:redbius startAngle:startAngle endAngle:endAngle clockwise:YES];
    _shapeLayer.path= path.CGPath;   //添加路径
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

+ (Class)layerClass {
    return [CAShapeLayer class];
}
@end
