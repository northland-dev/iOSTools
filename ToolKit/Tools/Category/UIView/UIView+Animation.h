//
//  UIView+Animation.h
//  Lolly
//
//  Created by Charles on 2017/11/21.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)
// 旋转动画
- (void)addRotateAnimation:(CGFloat)duration;
// 呼吸动画
- (void)addBreathAnimation:(CGFloat)duration;
// 位移动画
- (void)addMoveAnimation:(CGFloat)duration fromPoint:(CGPoint)fromPoint endPoint:(CGPoint)endPoint;
// 位移动画，重复
- (void)addMoveAnimation:(CGFloat)duration fromPoint:(CGPoint)fromPoint endPoint:(CGPoint)endPoint andRepeatCount:(NSInteger)repeatCount;
//透明度动画
- (void)addLayerAnimationOpacity:(CGFloat)duration fromAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)endAlpha;

@end
