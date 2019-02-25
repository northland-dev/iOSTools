//
//  FSFriendActionButton.m
//  Ready
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSFriendActionButton.h"
#import "UIView+Corner.h"
@interface FSFriendActionButton()
{
    @public
    CAGradientLayer *_gradienLayer;
}
//@property(nonatomic,strong)CAGradientLayer *gradienLayer;

@end
@implementation FSFriendActionButton

- (instancetype)init {
    if (self = [super init]) {
//        _gradienLayer = (CAGradientLayer *)self.layer;
//        [_gradienLayer setStartPoint:CGPointMake(0, 0)];
//        [_gradienLayer setEndPoint:CGPointMake(1, 0)];
//        _selectedColors = @[(__bridge id)HexRGB(0x71FF56).CGColor,(__bridge id)HexRGB(0x2EE77F).CGColor];
//        _normalColors = @[(__bridge id)HexRGB(0xFFF100).CGColor,(__bridge id)HexRGB(0xF8C22D).CGColor];
//        [_gradienLayer setColors:@[(__bridge id)HexRGB(0xFFF100).CGColor,(__bridge id)HexRGB(0xF8C22D).CGColor]];
        
        [self setTitleColor:HexRGB(0x5C4406) forState:(UIControlStateNormal)];
        [self setTitleColor:HexRGB(0x029145) forState:(UIControlStateSelected)];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
//    if (selected) {
//        [_gradienLayer setColors:_selectedColors];
//    }else{
//        [_gradienLayer setColors:_normalColors];
//    }
}
- (void)setNormalColors:(NSArray *)normalColors {
    _normalColors = normalColors;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
//    [self makeCornerAllWithRadious:CGRectGetHeight(self.bounds)/2.0];
}
+ (Class)layerClass {
    return [CAGradientLayer class];
}
@end
