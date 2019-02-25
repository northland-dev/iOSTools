//
//  FSScrollView.m
//  Ready
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSScrollView.h"
@interface FSScrollView()
{
    BOOL _enable;
}
@end
@implementation FSScrollView
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}


@end
