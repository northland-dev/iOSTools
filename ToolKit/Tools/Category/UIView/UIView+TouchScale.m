//
//  UIView+TouchScale.m
//  Ready
//
//  Created by mac on 2019/1/8.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import "UIView+TouchScale.h"


@interface FSBaseAnimation : CAKeyframeAnimation<CAAnimationDelegate>
@property(nonatomic,assign)id<FSAnimationDelegate> fsdelegate;
@end
@implementation FSBaseAnimation
- (instancetype)init {
    if (self = [super init]) {
        [self setDelegate:self];
    }
    return self;
}
- (void)animationDidStart:(CAAnimation *)anim {
    if ([_fsdelegate respondsToSelector:@selector(fs_animationDidStart:)]) {
        [_fsdelegate fs_animationDidStart:anim];
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([_fsdelegate respondsToSelector:@selector(fs_animationDidStop:finished:)]) {
        [_fsdelegate fs_animationDidStop:anim finished:flag];
    }
}

GCDEALLOC()

@end


static NSString *touchScaleKey = @"\0";
@implementation UIView (TouchScale)

- (void)playScaleAnimation:(CGFloat)scale complete:(_Nullable FSTouchScaleFinish)complete {
    FSTouchScaleFinish finishBlock = objc_getAssociatedObject(self, &touchScaleKey);
    if (finishBlock) {
        // 正在执行动画
        NSLog(@"正在执行动画");
        return;
    }
    
    FSBaseAnimation *baseAnimaton = [FSBaseAnimation animationWithKeyPath:@"transform.scale"];
    [baseAnimaton setFsdelegate:self];
    [baseAnimaton setDuration:0.2];
    [baseAnimaton setValues:@[@1.0,@0.9,@1.0]];
    [baseAnimaton setKeyTimes:@[@0.0,@0.5,@1.0]];
    [baseAnimaton setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [baseAnimaton setRepeatCount:1];
    [self.layer addAnimation:baseAnimaton forKey:@"fs_scaleAnim"];
    
    if(complete){
        objc_setAssociatedObject(self, &touchScaleKey, complete, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}
- (void)fs_animationDidStart:(CAAnimation *)anim {
}
- (void)fs_animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    FSTouchScaleFinish finishBlock = objc_getAssociatedObject(self, &touchScaleKey);
    if (finishBlock) {
        finishBlock(flag);
        objc_removeAssociatedObjects(self);
    }
 }
@end
