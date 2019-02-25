//
//  FSAlertView.m
//  Alert
//
//  Created by Charles on 2017/11/28.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSAlertView.h"
#import "UIFont+FSProxima.h"
//#import <TTTAttributedLabel/TTTAttributedLabel.h>

@interface FSAlertView()
@property(nonatomic,strong)UIView *enableView;
@property(nonatomic,strong)UIVisualEffectView *effectView;
@property(nonatomic,strong)UILabel *textLable;
@property(nonatomic,strong)UIView *contentView;
@end

@implementation FSAlertView
- (UIView *)enableView {
    if (!_enableView) {
         _enableView = [[UIView alloc] init];
    }
    return _enableView;
}
- (UILabel *)textLable {
    if (!_textLable) {
        _textLable = [[UILabel alloc] initWithFrame:CGRectZero];
        [_textLable setTextColor:HexRGB(0x000000)];
        [_textLable setFont:[UIFont systemFontOfSize:16.0]];
        [_textLable setTextAlignment:(NSTextAlignmentCenter)];
        [_textLable setNumberOfLines:0];
        [_textLable setLineBreakMode:(NSLineBreakByWordWrapping)];
//        [_textLable setMinimumLineHeight:18.0];
    }
    return _textLable;
}
- (UIView *)contentView {
    if (!_contentView) {
         _contentView = [[UIView alloc] init];
        [_contentView.layer setCornerRadius:7.0];
        [_contentView.layer setMasksToBounds:YES];
    }
    return _contentView;
}
- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    }
    return _effectView;
}
- (instancetype)initWithFrame:(CGRect)frame withMessage:(NSString *)message{
    if (self = [super initWithFrame:frame]) {
         _message = message;
        [self addSubview:self.enableView];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.effectView];
        [self.contentView addSubview:self.textLable];
        CGFloat maxLayout = CGRectGetWidth(self.bounds)*0.85 - 38;
        [self.textLable setPreferredMaxLayoutWidth:maxLayout];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.textLable setText:_message];
    [self.enableView setFrame:self.bounds];
    CGFloat maxLayout = self.textLable.preferredMaxLayoutWidth;
    CGSize textSize = [self.textLable sizeThatFits:CGSizeMake(maxLayout, MAXFLOAT)];
    [self.textLable sizeToFit];
    CGFloat textLabelWidth = textSize.width;
    CGFloat textLabelHeight = textSize.height;
    CGFloat contentX = (CGRectGetWidth(self.bounds) - textLabelWidth - 38)/2.0;
    CGFloat contentY = (CGRectGetHeight(self.bounds) - textLabelHeight - 30)/2.0;
    [self.contentView setFrame:CGRectMake(contentX, contentY, textLabelWidth + 38, textLabelHeight + 30)];
    [self.effectView setFrame:self.contentView.bounds];
    [self.textLable setFrame:CGRectMake(19, 15,textLabelWidth,textLabelHeight)];
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self setAlpha:0];
    [super willMoveToSuperview:newSuperview];
}
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:1.0];
    } completion:^(BOOL finished) {
        [self performSelector:@selector(remove) withObject:nil afterDelay:2.0];
    }];
}
- (void)remove{
    [UIView animateWithDuration:0.3 animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    if ([self.delegate respondsToSelector:@selector(alertViewDidRemoveFromSuperView:)]) {
        [self.delegate alertViewDidRemoveFromSuperView:self];
    }
}

@end
