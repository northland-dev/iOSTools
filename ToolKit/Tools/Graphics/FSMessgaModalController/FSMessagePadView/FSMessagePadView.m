//
//  FSMessagePadView.m
//  Ready
//
//  Created by mac on 2018/8/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSMessagePadView.h"
#import "UIView+Corner.h"
#import "GCTextView.h"
@interface FSMessagePadView ()<UITextViewDelegate>
{
    CAShapeLayer *_shapeLayer;
    NSString *_title;
    NSString *_placeHolder;
}
@property(nonatomic,strong)UIButton *cancleButton;
@property(nonatomic,strong)UIButton *sureButton;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)GCTextView *textView;
@end
@implementation FSMessagePadView
-(instancetype)initWithTitle:(NSString *)title textPlaceHolder:(NSString *)placeHolder {
    

    
    if (self = [super init]) {
        _shapeLayer = (CAShapeLayer *)self.layer;
        _shapeLayer.fillColor = UIColor.whiteColor.CGColor;
        _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;//指定path的渲染颜色
        _shapeLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
        _shapeLayer.lineWidth = 1.0;//线的宽度
        _shapeLayer.lineJoin = kCALineJoinRound;
        [self setBackgroundColor:[UIColor clearColor]];
        _title = title;
        _placeHolder = placeHolder;
        // default
        _limitedNum = 50;

    }
    return self;
}


- (void)createSubviews {
    [super createSubviews];
    
    WS(weaks);
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(34, 34));
        make.left.equalTo(weaks.mas_left).offset(12);
        make.top.equalTo(weaks.mas_top).offset(10);
    }];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(34, 34));
        make.right.equalTo(weaks.mas_right).offset(-12);
        make.top.equalTo(weaks.mas_top).offset(10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20.0);
        make.centerX.equalTo(weaks.mas_centerX);
        make.top.equalTo(weaks.mas_top).offset(15);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1.0);
        make.right.left.equalTo(weaks);
        make.top.equalTo(weaks.mas_top).offset(50);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weaks.line.mas_bottom).offset(15);
        make.left.equalTo(weaks.mas_left).offset(19);
        make.right.equalTo(weaks.mas_right).offset(-34);
        make.bottom.equalTo(weaks.mas_bottom).offset(33);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(12, 12)];
    [_shapeLayer setPath:path.CGPath];
    
    [self.titleLabel setText:_title];
    [self.textView setPlaceHolderText:_placeHolder];
}

- (void)setEnableBlankControl:(BOOL)enableBlankControl {
    _enableBlankControl = enableBlankControl;
    
    [self.sureButton setEnabled:NO];
}
- (void)setPlaceHolderText:(NSString *)placeHolderText {
    _placeHolderText = placeHolderText;
    [self.textView setText:placeHolderText];
    
    [self.sureButton setEnabled:placeHolderText.length];
}
- (void)setLimitedNum:(NSInteger)limitedNum {
    _limitedNum = limitedNum;
    [self.textView setLimitedNumber:limitedNum];
}
- (void)becomeFirstResponder {
    if ([self.textView canBecomeFirstResponder]) {
        [self.textView becomeFirstResponder];
    }
}
#pragma mark -
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    BOOL shouldChange = [self.textView textView:textView shouldChangeTextInRange:range replacementText:text];
    if (textView.text.length >= _limitedNum && !shouldChange) {
        if ([self.delegate respondsToSelector:@selector(messagePadViewArrivalMax:)]) {
            [self.delegate messagePadViewArrivalMax:textView.text];
        }
        
        NSLog(@"textView.text %@",textView.text);
    }
    return shouldChange;
}

- (void)textViewDidChange:(UITextView *)textView {
    [self.textView textViewDidChange:textView];
    
    if (_enableBlankControl) {
        //
        NSString *trimText = [textView.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        [self.sureButton setEnabled:trimText.length >= 1];
    }
}
#pragma mark -
- (void)clickClose {
    if ([self.delegate respondsToSelector:@selector(messagePadViewClickClose)]) {
        [self.delegate messagePadViewClickClose];
    }
}
- (void)clickSure {
    NSString *text = self.textView.text;
    if ([self.delegate respondsToSelector:@selector(messagePadViewClickSure:)]) {
        [self.delegate messagePadViewClickSure:text];
    }
}
#pragma mark - getter
- (UIButton *)cancleButton {
    if (!_cancleButton) {
         _cancleButton = [[UIButton alloc] init];
        [_cancleButton setImage:[UIImage imageNamed:@"msgModalClose"] forState:(UIControlStateNormal)];
        [_cancleButton setContentMode:(UIViewContentModeScaleAspectFit)];
        [_cancleButton setBackgroundColor:[UIColor clearColor]];
        [_cancleButton addTarget:self action:@selector(clickClose) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_cancleButton];
    }
    return _cancleButton;
}
- (UIButton *)sureButton {
    if (!_sureButton) {
         _sureButton = [[UIButton alloc] init];
        [_sureButton setImage:[UIImage imageNamed:@"msgModalSure"] forState:(UIControlStateNormal)];
        [_sureButton setContentMode:(UIViewContentModeScaleAspectFit)];
        [_sureButton setBackgroundColor:[UIColor clearColor]];
        [_sureButton addTarget:self action:@selector(clickSure) forControlEvents:(UIControlEventTouchUpInside)];
        [_sureButton setAdjustsImageWhenDisabled:YES];
        [self addSubview:_sureButton];
    }
    return _sureButton;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        [_line setBackgroundColor:HexRGBAlpha(0xFCDA16, 1.0)];
        [self addSubview:_line];
    }
    return _line;
}
- (GCTextView *)textView {
    if (!_textView) {
        _textView = [[GCTextView alloc] init];
        [_textView setTextColor:HexRGB(0x9D8F6A)];
        [_textView setPlaceHolderColor:HexRGBAlpha(0x5C4406,0.5)];
        [_textView setFont:[UIFont systemFontOfSize:14.0]];
        [_textView setPlaceHolderText:_placeHolder];
        [_textView setPlaceHolderFont:[UIFont systemFontOfSize:14.0]];
        [_textView setReturnKeyType:(UIReturnKeyDone)];
        [_textView setBackgroundColor:[UIColor clearColor]];
        [_textView setLimitedNumber:300];
        [_textView setClipsToBounds:NO];
        [_textView setDelegate:self];
        [self addSubview:_textView];
    }
    return _textView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:GTFixWidthFlaot(18)];
        _titleLabel.textColor = HexRGB(0x5C4406);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
+ (Class)layerClass {
    return [CAShapeLayer class];
}
@end
