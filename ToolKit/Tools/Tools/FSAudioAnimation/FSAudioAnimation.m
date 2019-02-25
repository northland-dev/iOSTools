//
//  FSAudioAnimation.m
//  Ready
//
//  Created by jiapeng on 2018/8/16.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSAudioAnimation.h"

@implementation FSAudioAnimation

- (void)drawRect:(CGRect)rect {
    
    //半径
    CGFloat redbius =_CGfrom_x/2;
    //开始角度
    CGFloat startAngle = 0;
    //中心点
    CGPoint point = CGPointMake(_CGfrom_x/2, _CGfrom_x/2);
    //结束角
    CGFloat endAngle = 2*M_PI;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:redbius startAngle:startAngle endAngle:endAngle clockwise:YES];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path=path.CGPath;   //添加路径
    if ([_tagString isEqualToString:@"DanMu"]) {
        layer.strokeColor=HexRGB(0x61E8FA).CGColor;
        layer.fillColor=HexRGB(0x61E8FA).CGColor;
    }else if ([_tagString isEqualToString:@"Game"]){
        layer.strokeColor=HexRGB(0xFFFFFF).CGColor;
        layer.fillColor=HexRGB(0xFFFFFF).CGColor;
    }else{
        layer.strokeColor=HexRGB(0xFFF100).CGColor;
        layer.fillColor=HexRGB(0xFFF100).CGColor;
    }
    [self.layer addSublayer:layer];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
