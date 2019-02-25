//
//  FSAlertView.h
//  Alert
//
//  Created by Charles on 2017/11/28.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSAlertView;
@protocol FSAlertViewDelegate<NSObject>
@optional
- (void)alertViewDidRemoveFromSuperView:(FSAlertView *)alertView;
@end

@interface FSAlertView : UIView
@property(nonatomic,assign)id<FSAlertViewDelegate> delegate;
@property(nonatomic,strong)NSString *message;

- (instancetype)initWithFrame:(CGRect)frame withMessage:(NSString *)message;
@end
