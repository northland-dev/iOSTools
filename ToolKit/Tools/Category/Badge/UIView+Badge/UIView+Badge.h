//
//  UIView+Badge.h
//  Ready
//
//  Created by mac on 2018/8/30.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewBadgeDefine.h"

@interface UIView (Badge)

-(void)setTabIconWidth:(CGFloat)width;

-(void)setBadgeTop:(CGFloat)top;

-(void)setBadgeStyle:(ButtonCustomBadgeType)type value:(NSInteger)badgeValue;
@end
