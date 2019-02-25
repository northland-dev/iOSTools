//
//  UIView+GC.h
//  FlyShow
//
//  Created by 高超的开发 on 14-8-27.
//  Copyright (c) 2014年 牟亚军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GC)
+ (UIView *)titleBgView:(NSString *)titletText;
-(void) setMaskByRoundingCorners:(UIRectCorner)corners CornerSize:(CGSize)size;

- (void)addShadow;

-(UIImage *)shooootView;

@end
