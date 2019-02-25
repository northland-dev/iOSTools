//
//  FSGradientButton.m
//  Ready
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSGradientButton.h"
@interface FSGradientButton()
{
    CAGradientLayer *_gradienLayer;
}
@end
@implementation FSGradientButton

- (instancetype)init {
    if (self = [super init]) {
         _gradienLayer = (CAGradientLayer *)self.layer;
        [_gradienLayer setStartPoint:CGPointMake(0, 0)];
        [_gradienLayer setEndPoint:CGPointMake(1, 0)];
    }
    return self;
}
- (void)setColors:(NSArray *)colors {
    _colors = colors;
    [_gradienLayer setColors:colors];
}
+(Class)layerClass {
    return [CAGradientLayer class];
}
@end
