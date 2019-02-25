//
//  UIViewController+Alert.h
//  Lolly
//
//  Created by Charles on 2017/11/9.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alert)
@property(nonatomic,assign)NSTimeInterval dismissDelayTime;

- (void)showAlertWithMessage:(NSString *)message;
@end
