//
//  UIScrollView+EdgePan.h
//  Ready
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (EdgePan)

- (void)setupShouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

@end
