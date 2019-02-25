//
//  GCTextView.m
//  7nujoom
//
//  Created by Charles on 9/6/16.
//  Copyright © 2016 Fission. All rights reserved.
//

#import "GCTextView.h"
#import "FSInsetLabel.h"
@interface GCTextView ()
@property(nonatomic,strong)UILabel *placeHolderLable;
@end
@implementation GCTextView
-(void)dealloc
{
    [self removeNotification];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self creatPlaceHolder:frame];
        [self addNotifictaion];
        [self setScrollEnabled:NO];
    }
    return self;
}
- (instancetype)init {
    if (self = [super init]) {
        [self creatPlaceHolder:CGRectZero];
        [self addNotifictaion];
        [self setScrollEnabled:NO];
    }
    return self;
}
-(void)addNotifictaion
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
}
-(void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}
-(void)textDidChange:(NSNotification *)notification
{
    [self.placeHolderLable setHidden:self.hasText];    
}
-(void)setPlaceHolderText:(NSString *)placeHolderText{
    
    _placeHolderText = [placeHolderText copy];
    
    [self.placeHolderLable setText:placeHolderText];
}

-(void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    [self.placeHolderLable setTextColor:placeHolderColor];
}
-(void)setPlaceHolderFont:(UIFont *)placeHolderFont
{
    [self.placeHolderLable setFont:placeHolderFont];
}
-(void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange:nil];
}
-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    
    [self.placeHolderLable setTextAlignment:textAlignment];
}
-(void)creatPlaceHolder:(CGRect)frame
{
    WS(weaks);
    [self.placeHolderLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weaks).offset(13);
        make.top.equalTo(weaks).offset(7);
        make.right.equalTo(weaks).offset(-20);
    }];
}
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self.placeHolderLable setFont:[UIFont fontWithName:font.fontName size:font.pointSize+1]];
}
-(void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    
    if(!_placeHolderColor)
        [self.placeHolderLable setTextColor:textColor];
}
-(void)setLimitedNumber:(NSInteger)limitedNumber
{
    _limitedNumber = limitedNumber;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.placeHolderLable setPreferredMaxLayoutWidth:CGRectGetWidth(self.bounds)];
}
- (void)setPlaceHolderMoreLines {
    [self.placeHolderLable setNumberOfLines:0];
    [self.placeHolderLable setLineBreakMode:(NSLineBreakByWordWrapping)];
}
#pragma mark - 
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (_limitedNumber <= 0) {
        return YES;
    }
    
    NSString *toBestring = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if(toBestring.length > _limitedNumber && range.length != 1)
    {
        textView.text = [toBestring substringToIndex:_limitedNumber];
        return NO;
    }
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > _limitedNumber) {
        textView.text = [textView.text substringToIndex:_limitedNumber];
    }
}
#pragma mark -
- (UILabel *)placeHolderLable {
    if (!_placeHolderLable) {
        _placeHolderLable = [[UILabel alloc]  init];//a:UIEdgeInsetsMake(0, 13, 0, 13)];
        [_placeHolderLable setNumberOfLines:0];
        [_placeHolderLable setLineBreakMode:(NSLineBreakByWordWrapping)];
        [self addSubview:_placeHolderLable];
    }
    return _placeHolderLable;
}
@end
