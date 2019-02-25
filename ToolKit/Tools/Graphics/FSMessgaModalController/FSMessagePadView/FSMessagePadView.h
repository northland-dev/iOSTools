//
//  FSMessagePadView.h
//  Ready
//
//  Created by mac on 2018/8/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSBaseView.h"

@protocol FSMessagePadViewDelegate<NSObject>
@optional
- (void)messagePadViewClickClose;
- (void)messagePadViewClickSure:(NSString *)message;
- (void)messagePadViewArrivalMax:(NSString *)maxMessage;
@end

@interface FSMessagePadView : FSBaseView
// default 50
@property(nonatomic,assign)NSInteger limitedNum;
@property(nonatomic,assign)BOOL enableBlankControl;
@property(nonatomic,assign)id<FSMessagePadViewDelegate>delegate;
@property(nonatomic,strong)NSString *placeHolderText;

-(instancetype)initWithTitle:(NSString *)title textPlaceHolder:(NSString *)placeHolder;

- (void)becomeFirstResponder;
@end
