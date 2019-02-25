//
//  FSBaseGradientView.m
//  Ready
//
//  Created by mac on 2018/9/23.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSBaseGradientView.h"
@interface FSBaseGradientView(){
    CAGradientLayer *_gradienLayer;
}
@end
@implementation FSBaseGradientView
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
