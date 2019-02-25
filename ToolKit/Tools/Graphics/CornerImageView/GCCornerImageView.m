//
//  GCCornerImageView.m
//  Ready
//
//  Created by mac on 2018/12/21.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "GCCornerImageView.h"

@implementation GCCornerImageView

- (instancetype)init {
    if(self = [super init]){
        _shapeLayer = (CAShapeLayer *)self.layer;
        _shapeLayer.lineCap = kCALineCapRound;
        _shapeLayer.lineWidth = 3.0;
        _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.fillColor = [UIColor redColor].CGColor;
        
        //        _shapeLayer.shadowColor = [UIColor redColor].CGColor;
        //        _shapeLayer.shadowRadius = 15;
        //        _shapeLayer.shadowOffset = CGSizeMake(0, 0);
        //        _shapeLayer.shadowOpacity = 1.0;
        
        [_shapeLayer setMask:_maskLayer];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}
- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    _shapeLayer.lineWidth = lineWidth;
}
//- (void)setCornerRadius:(CGFloat)cornerRadius {
//    _cornerRadius = cornerRadius;
//    
//    if (_shapeLayer.cornerRadius != cornerRadius) {
//        _shapeLayer.cornerRadius = cornerRadius;
//        _maskLayer.cornerRadius = cornerRadius;
//    }
//
//}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_cornerRadius].CGPath;
    _maskLayer.path = _shapeLayer.path;
    //    _shapeLayer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:20].CGPath;
}
+ (Class)layerClass {
    return [CAShapeLayer class];
}

@end
