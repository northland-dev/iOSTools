//
//  FSMessageModalController.m
//  Ready
//
//  Created by mac on 2018/8/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSMessageModalController.h"
#import "FSMessagePadView.h"

@interface FSMessageModalController ()<FSMessagePadViewDelegate>
{
    NSString *_title;
}
@property(nonatomic,copy)MessageModelComplete complete;
@property(nonatomic,strong)FSMessagePadView *messagePadView;
@end

@implementation FSMessageModalController

- (instancetype)initWithTitle:(NSString *)title clickSureCallBack:(MessageModelComplete)complete{
    if (self = [super init]) {
        _title = title;
        // default
        _limitedNum = 50;
        self.complete = complete;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addNotifications];

    [self.view setBackgroundColor:HexRGBAlpha(0x000000, 0.6)];
    WS(weaks);
    [self.messagePadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weaks.view);
        make.height.mas_greaterThanOrEqualTo(196.0);
    }];
    
    [self.messagePadView setLimitedNum:_limitedNum];
    [self.messagePadView setEnableBlankControl:_enableEnptyControl];
    [self.messagePadView setPlaceHolderText:_placeHoldertext];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
- (void)beginEdit {
    [self.messagePadView becomeFirstResponder];
}


#pragma mark - keyborads
- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)removeNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    CGRect keyboardRect;
    [[userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardRect];
    CGFloat keyboardHeight = CGRectGetHeight(keyboardRect);
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:(UIViewAnimationCurve)[curve intValue]];
    [UIView beginAnimations:nil context:NULL];
    // 订到tableview的底部
    [self.messagePadView setTransform:CGAffineTransformMakeTranslation(0, -keyboardHeight)];
    [UIView commitAnimations];
}
- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:(UIViewAnimationCurve)[curve intValue]];
    [UIView beginAnimations:nil context:NULL];
    [self.messagePadView setTransform:CGAffineTransformIdentity];
    [UIView commitAnimations];
}
#pragma mark -
- (void)messagePadViewClickClose {
    if (self.cancleBlock) {
        self.cancleBlock();
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)messagePadViewClickSure:(NSString *)message {
    if (self.complete) {
        self.complete(message);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)messagePadViewArrivalMax:(NSString *)maxMessage {
    if (self.arrivalMaxBlock) {
        self.arrivalMaxBlock();
    }
}

#pragma mark - getter
- (FSMessagePadView *)messagePadView {
    if (!_messagePadView) {
        _messagePadView = [[FSMessagePadView alloc] initWithTitle:_title textPlaceHolder:_placeHolder];
        [_messagePadView setDelegate:self];
        [self.view addSubview:_messagePadView];
    }
    return _messagePadView;
}


- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverCurrentContext;
}


- (void)dealloc {
    [self removeNotifications];
    NSLog(@"FSMessageModal dealloc");
}
@end
