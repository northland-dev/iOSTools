//
//  FSBaseAlertView.m
//  Ready
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSBaseAlertView.h"

@interface FSBaseAlertView(){
    CAShapeLayer *_shapeLayer;
    NSString *_message;
    NSString *_defaultTitle;
    NSString *_cancleTitle;
}

@property(nonatomic,copy)FSAlertFunction defaultFunction;
@property(nonatomic,copy)FSAlertFunction cancleFuntion;
@end
@implementation FSBaseAlertView

- (instancetype)initWithMessage:(NSString *)message
              defautButtonTitle:(NSString *)defaultTitle
                    cancleTitle:(NSString *)cancleTitle {
    if (self = [super init]) {
        _shapeLayer = (CAShapeLayer *)self.layer;
        _shapeLayer.fillColor = UIColor.whiteColor.CGColor;
        _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;//指定path的渲染颜色
        _shapeLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
        _shapeLayer.lineWidth = 8.0;//线的宽度
        _shapeLayer.lineJoin = kCALineJoinRound;
        _message = message;
        _defaultTitle = defaultTitle;
        _cancleTitle = cancleTitle;
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:12].CGPath;
    
    [_messageLabel setPreferredMaxLayoutWidth:CGRectGetWidth(self.bounds) - 65];
    [_messageLabel setText:_message];
    [_defaultButton setTitle:_defaultTitle forState:(UIControlStateNormal)];
    [_cancleButton setTitle:_cancleTitle forState:(UIControlStateNormal)];
    
}
- (void)addDefultButtonFunction:(FSAlertFunction)defaultFunction {
    self.defaultFunction = defaultFunction;
}
- (void)addCancleButtonFunction:(FSAlertFunction)cancleFunction {
    self.cancleFuntion = cancleFunction;
}
#pragma mark -
- (void)clickDefultButton {
    if (self.defaultFunction) {
        self.defaultFunction();
    }
}
- (void)clickCancleButton {
    if (self.cancleFuntion) {
        self.cancleFuntion();
    }
}
#pragma mark -
- (FSCornerGradientButton *)defaultButton {
    if (!_defaultButton) {
        _defaultButton = [[FSCornerGradientButton alloc] init];
        [_defaultButton setColors:@[(id)[HexRGB(0xFFF100) CGColor], (id)[HexRGB(0xF8C22D) CGColor]]];
        [_defaultButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [_defaultButton setTitleColor:HexRGB(0x5C4406) forState:(UIControlStateNormal)];
        [_defaultButton addTarget:self action:@selector(clickDefultButton) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_defaultButton];
    }
    return _defaultButton;
}
- (FSCornerGradientButton *)cancleButton {
    if (!_cancleButton) {
        _cancleButton = [[FSCornerGradientButton alloc] init];
        [_cancleButton setColors:@[(id)[HexRGB(0xEFEDE7) CGColor], (id)[HexRGB(0xE0E0DA) CGColor]]];
        [_cancleButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [_cancleButton setTitleColor:HexRGB(0x5C4406) forState:(UIControlStateNormal)];
        [_cancleButton addTarget:self action:@selector(clickCancleButton) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_cancleButton];
    }
    return _cancleButton;
}
- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        [_messageLabel setFont:[UIFont systemFontOfSize:14]];
        [_messageLabel setTextColor:HexRGB(0x5C4406)];
        [_messageLabel setNumberOfLines:0];
        [_messageLabel setTextAlignment:(NSTextAlignmentLeft)];
        [_messageLabel setLineBreakMode:(NSLineBreakByWordWrapping)];
        [self addSubview:_messageLabel];
    }
    return _messageLabel;
}
+(Class)layerClass {
    return [CAShapeLayer class];
}

@end
