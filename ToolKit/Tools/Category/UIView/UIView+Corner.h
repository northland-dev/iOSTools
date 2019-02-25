//
//  UIView+Corner.h
//  Ready
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Corner)
@property(nonatomic,strong)CAShapeLayer *shapeLayer;
- (void)makeCornerAllWithRadious:(CGFloat)radious;
- (void)makeCornerWithCornerRect:(UIRectCorner)corner cornerRadius:(CGFloat)radius;
- (void)clearCorner;
@end
