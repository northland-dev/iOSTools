//
//  FSMarqueeLabel.m
//  Ready
//
//  Created by mac on 2019/1/4.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import "FSMarqueeLabel.h"

static void* MyBasicAnimationKey = "MyBasicAnimationKey";

@interface CABasicAnimation(BUG)<CAAnimationDelegate>

- (void)setDebugDelegate:(id)delegate;

@end

@implementation CABasicAnimation(BUG)

- (void)setDebugDelegate:(id)delegate
{
    self.delegate =  self;//将委托指向自己，并实现委托方法
    
    objc_setAssociatedObject(self, MyBasicAnimationKey, delegate, OBJC_ASSOCIATION_ASSIGN);//这里通过对象关联来实现，注意这里必须是OBJC_ASSOCIATION_ASSIGN，而不能用OBJC_ASSOCIATION_RETAIN，否则仍然是强引用环。
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    id obj = objc_getAssociatedObject ( self, MyBasicAnimationKey );
    [obj animationDidStop:anim finished:flag];//这里将实现转给关联对象
}
@end

@interface FSMarqueeLabel()<CAAnimationDelegate>{
    BOOL _inAnimation;
    BOOL _userStop;
}
@end
@implementation FSMarqueeLabel
- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"FSMarqueeLabel init %p",self);
    }
    return self;
}

- (void)setText:(NSString *)text {
    if (_inAnimation) {
        return;
    }
    [super setText:text];
}
- (void)start {
    if (_inAnimation) {
        return;
    }
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self addRightToLeftAnimation];
    
    _inAnimation = YES;
    [self.layer setSpeed:0.5];
}
- (void)stop {
    _inAnimation = NO;
    [self setText:nil];
    [self.layer removeAllAnimations];
    [self.layer setSpeed:0];
    _userStop = YES;
}
- (void)pause {
    [self.layer setSpeed:0];
}
- (void)resume {
    [self.layer setSpeed:0.5];
}
- (BOOL)isInPlay {
    return _inAnimation;
}
- (void)addRightToLeftAnimation {
    [self.layer  removeAllAnimations];
    // 位置移动到左变
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.removedOnCompletion = NO;
    animation.repeatCount = 1;
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(_superWidth, 0, 0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-_offWidth, 0, 0)];
    animation.duration = 5.0f;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [animation setDelegate:self];
    [self.layer addAnimation:animation forKey:@"transformAnim"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    _inAnimation = NO;
    
    if (_userStop) {
        // 外部主动停止时不需要代理通知
        return;
    }
    
    if (flag) {
        if ([self.delegate respondsToSelector:@selector(marqueeLabelDidStopAnimation)]) {
            [self.delegate marqueeLabelDidStopAnimation];
        }
        
        if ([self.delegate respondsToSelector:@selector(marqueeLabelDidStop:)]) {
            [self.delegate marqueeLabelDidStop:self];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(marqueeLabelDidPause:)]) {
            [self.delegate marqueeLabelDidPause:self];
        }
        // 销毁当前动画
        [self.layer removeAllAnimations];
    }

}
- (void)releasePointers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.layer removeAllAnimations];
}
- (void)dealloc {
    [self releasePointers];
    
//    GCDEALLOCLOG;
    NSLog(@"FSMarqueeLabel dealloc %p",self);

}
@end
