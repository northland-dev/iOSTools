//
//  FSChatTextView.m
//  Ready
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSChatTextView.h"

@interface FSChatTextView()
@end

@implementation FSChatTextView
- (GCTextView *)textView {
    if (!_textView) {
        _textView = [[GCTextView alloc] init];
        [_textView setTextColor:HexRGB(0x5C4406)];
        [_textView setPlaceHolderColor:HexRGBAlpha(0x5C4406,0.5)];
        [_textView setFont:[UIFont systemFontOfSize:14.0]];
        [_textView setPlaceHolderText:[FSSharedLanguages CustomLocalizedStringWithKey:@"ChatPage_SaySomething"]];
        [_textView setPlaceHolderFont:[UIFont systemFontOfSize:14.0]];
        [_textView setReturnKeyType:(UIReturnKeySend)];
        [_textView setBackgroundColor:[UIColor clearColor]];
        [_textView setLimitedNumber:300];
        [_textView setDelegate:self];

        [self addSubview:_textView];
    }
    return _textView;
}
- (void)createSubviews {
    
    [self setBackgroundColor:HexRGB(0xF8F8F0)];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(13.0);
        make.top.equalTo(self.mas_top).offset(5.0);
        make.bottom.equalTo(self.mas_bottom).offset(-5.0);
        make.right.equalTo(self.mas_right).offset(-13.0);
    }];
    
    
    [self.layer setCornerRadius:14.0];
    [self.layer setMasksToBounds:YES];
}
- (NSString *)text {
    return self.textView.text;
}
- (void)setDraftText:(NSString *)text {
    [self.textView setText:text];
}
- (void)setDelegate:(id<UITextViewDelegate>)delegate {
    _delegate = delegate;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (![text isEqualToString:@"\n"]) {
        BOOL canReplace = [self.textView textView:textView shouldChangeTextInRange:range replacementText:text];
        // 不是回车要拦截掉
        if (!canReplace) {
            // 切割之后
            return canReplace;
        }
    }
    
    // 是回车就交给super处理。
    BOOL canReplace = YES;
    if ([self.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
         canReplace = [self.delegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    return canReplace;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([self.delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        [self.delegate textViewShouldBeginEditing:textView];
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    if ([self.delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.delegate textViewDidChange:textView];
    }
    [self.textView textViewDidChange:textView];
}

//- (BOOL)becomeFirstResponder {
//    return [self.textView becomeFirstResponder];
//}
//- (BOOL)canBecomeFirstResponder {
//    return [self.textView canBecomeFirstResponder];
//}
//- (BOOL)canResignFirstResponder {
//    return [self.textView canResignFirstResponder];
//}
//- (BOOL)resignFirstResponder {
//    return [self.textView resignFirstResponder];
//}
@end
