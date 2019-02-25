//
//  UIView+AniMation.m
//  FlyShow
//
//  Created by gaochao on 15/4/9.
//  Copyright (c) 2015年 高超. All rights reserved.
//

#import "UIView+AniMation.h"
#define ScreenF  CGRectMake(0,0,MIN([[UIScreen mainScreen] bounds].size.height,[[UIScreen mainScreen] bounds].size.width),MAX([[UIScreen mainScreen] bounds].size.height,[[UIScreen mainScreen] bounds].size.width))

@implementation UIView (AniMation)
-(void)keyFrameAnimationWithFlyY:(CGFloat )FlyY
{
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animation];
    keyframeAnimation.keyPath = @"position";
    CGFloat stopX = ScreenF.size.width/2;
    CGPoint p1 = CGPointMake(-CGRectGetWidth(ScreenF), FlyY);
    CGPoint p13 = CGPointMake(-CGRectGetWidth(ScreenF)+ CGRectGetWidth(self.frame), FlyY);
    
    CGPoint p2 = CGPointMake(190, FlyY);
    CGPoint p3 = CGPointMake(130.f, FlyY);
    CGPoint p6 = CGPointMake(stopX, FlyY);
    CGPoint p7 = CGPointMake(stopX, FlyY);
    CGPoint p8 = CGPointMake(stopX, FlyY);
    CGPoint p4 = CGPointMake(stopX, FlyY);
    CGPoint p9 = CGPointMake(stopX, FlyY);
    CGPoint p10 = CGPointMake(stopX, FlyY);
    CGPoint p15 = CGPointMake(stopX, FlyY);
    CGPoint p16 = CGPointMake(stopX, FlyY);
    CGPoint p17 = CGPointMake(stopX, FlyY);
    CGPoint p18 = CGPointMake(stopX, FlyY);
    CGPoint p11 = CGPointMake(stopX, FlyY);
    CGPoint p12 = CGPointMake(stopX, FlyY);
    CGPoint p14 = CGPointMake(CGRectGetWidth(ScreenF), FlyY);
    CGPoint p5 = CGPointMake(CGRectGetWidth(ScreenF)*1.5, FlyY);
    keyframeAnimation.values = @[[NSValue valueWithCGPoint:p1],[NSValue valueWithCGPoint:p13], [NSValue valueWithCGPoint:p2], [NSValue valueWithCGPoint:p3],[NSValue valueWithCGPoint:p6],[NSValue valueWithCGPoint:p7],[NSValue valueWithCGPoint:p8],[NSValue valueWithCGPoint:p4],[NSValue valueWithCGPoint:p9],[NSValue valueWithCGPoint:p10],[NSValue valueWithCGPoint:p15],[NSValue valueWithCGPoint:p16],
                                 [NSValue valueWithCGPoint:p17],[NSValue valueWithCGPoint:p18],
                                 [NSValue valueWithCGPoint:p11],[NSValue valueWithCGPoint:p12],
                                 [NSValue valueWithCGPoint:p14],[NSValue valueWithCGPoint:p5]];
    keyframeAnimation.duration = 1.8f;
    keyframeAnimation.fillMode = kCAFillModeForwards;
    keyframeAnimation.removedOnCompletion = NO;
    keyframeAnimation.repeatCount = 1;
    [keyframeAnimation setDelegate:self];
    [self.layer addAnimation:keyframeAnimation forKey:nil];
}

-(void)boxaddShakeAnimation:(CGFloat)distance
{
    CALayer*viewLayer=[self layer];
    CAKeyframeAnimation*animation=[CAKeyframeAnimation
                                   
                                   animationWithKeyPath:@"transform"];
    animation.duration = 0.35;
    animation.repeatCount = MAXFLOAT; // 最大
    animation.autoreverses = NO;
    NSValue *value1 = [NSValue valueWithCATransform3D:CATransform3DRotate
                       (viewLayer.transform, - distance, 0.0, 0.0, distance)];
    NSValue *value2 = [NSValue valueWithCATransform3D:CATransform3DRotate
                       (viewLayer.transform,0.0, 0.0, 0.0, distance)];
    NSValue *value3 =[NSValue valueWithCATransform3D:CATransform3DRotate
                      (viewLayer.transform, distance, 0.0, 0.0, distance)];
    NSValue *value4 = [NSValue valueWithCATransform3D:CATransform3DRotate
                       (viewLayer.transform,0.0, 0.0, 0.0, distance)];
    NSValue *value5 =[NSValue valueWithCATransform3D:CATransform3DRotate
                      (viewLayer.transform, 0.0, 0.0, 0.0, distance)];
    animation.values = @[value2,value1,value3,value4,value5];
    animation.keyTimes = @[@(0.0),@(1.0/7.0),@(2.0/7.0),@(3.0/7.0),@(1.0)];
    [viewLayer addAnimation:animation forKey:@"wiggle"];
}
-(void)addShakeAnimation:(CGFloat)distance
{
    CALayer*viewLayer=[self layer];
    CABasicAnimation*animation=[CABasicAnimation
                                
                                animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    animation.repeatCount = MAXFLOAT; // 最大
    animation.autoreverses = YES;
    animation.fromValue=[NSValue valueWithCATransform3D:CATransform3DRotate
                    
                         (viewLayer.transform, - distance, 0.0, 0.0, distance)];
    animation.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate
                       
                       (viewLayer.transform, distance, 0.0, 0.0, distance)];
    [viewLayer addAnimation:animation forKey:@"wiggle"];
}

-(void)addShakeAnimation:(CGFloat)distance time:(CGFloat)time
{
    CALayer*viewLayer=[self layer];
    NSMutableArray* tempArray = [NSMutableArray array];
    for (NSInteger i = 0; i < time*5/3; i++) {
        CABasicAnimation*animation=[CABasicAnimation
                                    
                                    animationWithKeyPath:@"transform"];
        animation.beginTime = i*time/15;
        animation.duration = time/30;
        animation.autoreverses = YES;
        animation.fromValue=[NSValue valueWithCATransform3D:CATransform3DRotate
                             
                             (viewLayer.transform, - distance, 0.0, 0.0, distance)];
        animation.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate
                           
                           (viewLayer.transform, distance, 0.0, 0.0, distance)];
        [tempArray addObject:animation];
        
        CABasicAnimation*animationNew =[CABasicAnimation
                                    
                                    animationWithKeyPath:@"transform"];
        animationNew.beginTime = i*time/15 + time/30;
        animationNew.duration = time/30;
        animationNew.autoreverses = YES;
        animationNew.fromValue=[NSValue valueWithCATransform3D:CATransform3DRotate
                             
                             (viewLayer.transform, distance, 0.0, 0.0, distance)];
        animationNew.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate
                           
                           (viewLayer.transform, -distance, 0.0, 0.0, distance)];
        [tempArray addObject:animationNew];
    }
    CABasicAnimation* animationTwo =[CABasicAnimation
                                
                                animationWithKeyPath:@"transform"];
    animationTwo.beginTime = time/3;
    animationTwo.duration = 2*time/3;
    animationTwo.autoreverses = YES;
    animationTwo.fromValue=[NSValue valueWithCATransform3D:CATransform3DRotate
                         
                         (viewLayer.transform, 0, 0.0, 0.0, 0)];
    animationTwo.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate
                       
                       (viewLayer.transform, 0, 0.0, 0.0, 0)];
    [tempArray addObject:animationTwo];
    
    
    CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
    animaGroup.duration = time;
    animaGroup.repeatCount = MAXFLOAT;
    animaGroup.fillMode = kCAFillModeForwards;
    animaGroup.removedOnCompletion = NO;
    animaGroup.animations = tempArray;
    
    [viewLayer addAnimation:animaGroup forKey:@"newWiggle"];
    
}
-(void)addNewShakeAnimation:(CGFloat)distance Delegate:(id<CAAnimationDelegate>)delegate
{
    CALayer*viewLayer=[self layer];
    CABasicAnimation*animation=[CABasicAnimation
                                
                                animationWithKeyPath:@"transform"];
    animation.duration = 0.01;
    animation.repeatCount = 30; // 最大
    animation.autoreverses = YES;
    animation.fromValue=[NSValue valueWithCATransform3D:CATransform3DRotate
                         
                         (viewLayer.transform, - distance, 0.0, 0.0, distance)];
    animation.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate
                       
                       (viewLayer.transform, distance, 0.0, 0.0, distance)];
    [animation setValue:@"shake" forKey:@"currentAnimation"];
    [animation setDelegate:delegate];
    [viewLayer addAnimation:animation forKey:@"wiggle"];
}
-(void)addScaleAnimation:(CGFloat)scale duration:(CGFloat )duration
{
    CALayer*viewLayer=[self layer];
    CABasicAnimation*animation=[CABasicAnimation
                                
                                animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.repeatCount = MAXFLOAT; // 最大
    animation.autoreverses = NO;
    animation.fromValue=[NSValue valueWithCATransform3D:CATransform3DScale(viewLayer.transform, 0, 0, 1)];
    animation.toValue=[NSValue valueWithCATransform3D:CATransform3DScale(viewLayer.transform, scale, scale, 1)];
    [viewLayer addAnimation:animation forKey:@"scales"];
}

- (void)showScaleAnimation:(void (^)(BOOL finished))completion
{
    self.transform = CGAffineTransformMakeScale(1, 1);
    
    [UIView animateWithDuration:0.3 animations:
     ^(void){
         self.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
     }completion:^(BOOL finished){
         [self bounceOutAnimationStoped1:completion];
     }];
}

-(void)playLighttAnimation:(CGFloat )duration startTime:(CGFloat)startTime{
    
    CALayer*viewLayer=[self layer];
    // 从下往上
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:1.0f];//这是透明度。
    animation.beginTime = startTime;
    animation.duration = duration/4;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *hideAnimation =[CABasicAnimation animationWithKeyPath:@"opacity"];
    hideAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    hideAnimation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    hideAnimation.beginTime = startTime + duration/4;
    hideAnimation.duration = duration/4;
    hideAnimation.removedOnCompletion = NO;
    hideAnimation.fillMode = kCAFillModeForwards;
    hideAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
    [aniGroup setAnimations:[NSArray arrayWithObjects:animation,hideAnimation,nil]];
    aniGroup.duration = duration;
    aniGroup.removedOnCompletion = NO;
    aniGroup.repeatCount = MAXFLOAT;
    aniGroup.fillMode = kCAFillModeForwards;
    [viewLayer addAnimation:aniGroup forKey:nil];
}


- (void)bounceOutAnimationStoped1:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:0.3 animations:
     ^(void){
         self.transform = CGAffineTransformIdentity;
     }completion:^(BOOL finished){
         if (completion) {
             completion(YES);
         }
     }];
}
-(void)addFromRightToLeft:(CGFloat )duration
{
    CALayer*viewLayer=[self layer];
    // 从下往上
    CABasicAnimation *animationToTop = [CABasicAnimation animationWithKeyPath:@"position.x"];
     animationToTop.duration = duration;
    
     animationToTop.repeatCount = MAXFLOAT;
     animationToTop.removedOnCompletion = NO;
    animationToTop.fromValue = [NSNumber numberWithFloat:-CGRectGetWidth(self.frame)];
     animationToTop.toValue = [NSNumber numberWithFloat:CGRectGetWidth(self.frame)];
    [animationToTop setValue:[NSNumber numberWithFloat:-CGRectGetWidth(self.frame)] forKey:@"KCBasicAnimationLocation"];

    [viewLayer addAnimation:animationToTop forKey:nil];
}

-(void)addFromBottomToTop:(CGFloat )duration
{
    CALayer*viewLayer=[self layer];
    // 从下往上
    CABasicAnimation *animationToTop = [CABasicAnimation animationWithKeyPath:@"transform"];
    [animationToTop setDelegate:self];
    animationToTop.duration = duration;
    animationToTop.repeatCount = 1;
    animationToTop.removedOnCompletion = NO;
    animationToTop.fromValue=[NSValue valueWithCATransform3D:CATransform3DTranslate(viewLayer.transform, 0, self.frame.size.height, 0)];
    animationToTop.toValue=[NSValue valueWithCATransform3D:CATransform3DTranslate(viewLayer.transform, 0, 0, 0)];
    animationToTop.autoreverses = YES;
    CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
    [aniGroup setAnimations:[NSArray arrayWithObjects:animationToTop,nil]];
    [aniGroup setDelegate:self];
    [viewLayer addAnimation:aniGroup forKey:nil];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.layer performSelector:@selector(removeAllAnimations) withObject:nil afterDelay:3.0f];
    [self performSelector:@selector(removeFromSuperview) withObject:self afterDelay:0.1f];
}
// 向下
-(void)addFromTopToBottom:(CGFloat )duration
{
    CALayer *ViewLayer = [self layer];
    // 从下往上
    CABasicAnimation *animationToTop = [CABasicAnimation animationWithKeyPath:@"transform"];
    animationToTop.duration = 2.0;
    animationToTop.repeatCount = 1;
    animationToTop.toValue=[NSValue valueWithCATransform3D:CATransform3DTranslate(ViewLayer.transform, 0, self.frame.size.height, 0)];
    animationToTop.fromValue=[NSValue valueWithCATransform3D:CATransform3DTranslate(ViewLayer.transform, 0, 0, 0)];
    [animationToTop setDelegate:self];
    [ViewLayer addAnimation:animationToTop forKey:nil];
}


-(void)playGiftAnimation:(CGFloat )duration{
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
    //2.设置动画属性初始值和结束值
    basicAnimation.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.center.x,self.center.y + self.frame.size.height)];//可以不设置，默认为图层初始状态
    basicAnimation.toValue=[NSValue valueWithCGPoint:self.center];
    //设置其他动画属性
    basicAnimation.duration = duration;//动画时间5秒
    //3.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [self.layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Translation"];
}


-(void)sendFollowWithDuration:(NSTimeInterval)duration{
    [self groupAnimation:duration];
}



#pragma mark 基础透明度动画
-(CABasicAnimation *)opacityAnimation{
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    CGFloat toValue=0;
    
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:toValue];
    
    [opacityAnimation setValue:[NSNumber numberWithFloat:toValue] forKey:@"KCBasicAnimationProperty_ToValue"];
    
    return opacityAnimation;
}

#pragma mark 关键帧移动动画
-(CAKeyframeAnimation *)translationAnimation{
    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint endPoint;
    if (ScreenF.size.height > ScreenF.size.width) {
       endPoint  = CGPointMake(self.frame.origin.x, self.frame.origin.y - (ScreenF.size.height - ScreenF.size.width*0.75));
    }else{
        endPoint  = CGPointMake(self.frame.origin.x, 0);
    }
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.layer.position.x, self.layer.position.y);
    
    
    //第一个坐标点随机数
    int y1 = (arc4random() % 100);
    int x1 = (arc4random() % 20);
    //第二个左边点随机数
    int x2 = (arc4random() % 30);
    int y2 = (arc4random() % 100) + 200;
    
    
    CGPathAddCurveToPoint(path, NULL, self.layer.position.x + x1, self.layer.position.y - y1, self.layer.position.x - x2,  self.layer.position.y - y2, endPoint.x, endPoint.y);
    
    keyframeAnimation.path=path;
    CGPathRelease(path);
    
    [keyframeAnimation setValue:[NSValue valueWithCGPoint:endPoint] forKey:@"KCKeyframeAnimationProperty_EndPosition"];
    
    return keyframeAnimation;
}

#pragma mark 创建动画组
-(void)groupAnimation:(NSTimeInterval)duration{
    //1.创建动画组
    CAAnimationGroup *animationGroup=[CAAnimationGroup animation];
    
    //2.设置组中的动画和其他属性
    CABasicAnimation *basicAnimation=[self opacityAnimation];
    CAKeyframeAnimation *keyframeAnimation=[self translationAnimation];
    animationGroup.animations=@[basicAnimation,keyframeAnimation];
    
    animationGroup.delegate = self;
    animationGroup.duration = duration;//设置动画时间，如果动画组中动画已经设置过动画属性则不再生效
    animationGroup.beginTime = CACurrentMediaTime();//延迟五秒执行
    
    //3.给图层添加动画
    [self.layer addAnimation:animationGroup forKey:nil];
}
-(void)addRotateAnimation:(CGFloat)duration
{
    [self.layer removeAllAnimations];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotationAnimation.duration = duration;
    rotationAnimation.repeatCount = INT64_MAX; //旋转次数
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:rotationAnimation forKey:@"transform.rotation.z"];
}

-(void)addAnimationOnViewEndPoint:(CGPoint)endPoint delegate:(id)delegate
{
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.2, 0.2, 1.0)];
    scaleAnim.repeatCount = MAXFLOAT;
    
    CABasicAnimation *rotate =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    rotate.fromValue = [NSNumber numberWithFloat:0.f];
    rotate.toValue =  [NSNumber numberWithFloat: M_PI *2];
    rotate.autoreverses = NO;
    rotate.repeatCount = MAXFLOAT;
    rotate.speed = 2.0f;
    
    CAKeyframeAnimation *positionAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:self.layer.position];
    [bezierPath addQuadCurveToPoint:endPoint controlPoint:CGPointMake(endPoint.x, 0)];
    positionAnim.path = bezierPath.CGPath;
    positionAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    positionAnim.autoreverses = NO;
    positionAnim.repeatCount = 1;
    
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.duration = 1.0;
    
    [group setAnimations:@[scaleAnim,rotate,positionAnim]];
    [group setDelegate:delegate];
    [self.layer addAnimation:group forKey:@"dropAnimation"];
}
-(void)bounceAnimation_twoDelegate:(id<CAAnimationDelegate>)delegate bounceHeight:(CGFloat)bounceHeight
{
    //Y
    NSArray *times = @[@(0.0),@(0.33),@(0.6),@(0.75),@(1)];//,@(1)];

    CAKeyframeAnimation *trans = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    NSArray *values = @[@(-15),@(-bounceHeight),@(0),@(5),@(0)];//
    trans.values = values;
    trans.keyTimes = times;
    trans.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    //Alpha
    CAKeyframeAnimation *alpha = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    NSArray *alphaValues = @[@(0.0),@(0.2),@(0.4),@(0.6),@(1)];
    alpha.values = alphaValues;
    alpha.keyTimes = times;
    alpha.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAKeyframeAnimation *scaleXAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    NSArray *scaleXValues = @[@(0.12),@(1.2),@(1),@(1),@(1)];
    scaleXAnimation.values = scaleXValues;
    scaleXAnimation.keyTimes = times;// @[@(0.0),@(1.0/3.0),@(9.0/15.0),@(12.0/15.0),@(1)];//,@(1)];scaleXtimes;
    scaleXAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAKeyframeAnimation *scaleYAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    NSArray *scaleYValues = @[@(0.12),@(1.2),@(1),@(0.9),@(1)];
    scaleYAnimation.values = scaleYValues;
    scaleYAnimation.keyTimes = times;//@[@(0.0),@(1.0/3.0),@(9.0/15.0),@(12.0/15.0),@(1)];//,@(1)];scaleYtimes;
    scaleYAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAAnimationGroup *aGroup = [CAAnimationGroup animation];
    [aGroup setAnimations:@[trans,scaleXAnimation,scaleYAnimation,alpha]];
    aGroup.repeatCount = 1;
    aGroup.duration = 0.53;
    aGroup.fillMode = kCAFillModeForwards;
    [aGroup setDelegate:delegate];
    [aGroup setValue:@"bounces" forKey:@"currentAnimation"];

    [self.layer addAnimation:aGroup forKey:nil];
    
}

@end
