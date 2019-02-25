//
//  FSBaseAlertView.h
//  Ready
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSBaseView.h"
#import "FSCornerGradientButton.h"

typedef void(^FSAlertFunction)(void);
@interface FSBaseAlertView : FSBaseView

@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,strong)FSCornerGradientButton *defaultButton;
@property(nonatomic,strong)FSCornerGradientButton *cancleButton;

- (instancetype)initWithMessage:(NSString *)message
              defautButtonTitle:(NSString *)defaultTitle
                    cancleTitle:(NSString *)cancleTitle;

- (void)addDefultButtonFunction:(FSAlertFunction)defaultFunction;
- (void)addCancleButtonFunction:(FSAlertFunction)cancleFunction;
@end
