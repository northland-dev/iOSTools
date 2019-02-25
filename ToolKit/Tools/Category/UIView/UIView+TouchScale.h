//
//  UIView+TouchScale.h
//  Ready
//
//  Created by mac on 2019/1/8.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


typedef void(^FSTouchScaleFinish)(BOOL finished);
@protocol FSAnimationDelegate <NSObject>
@optional
- (void)fs_animationDidStart:(CAAnimation *)anim;
- (void)fs_animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;

@end

@interface UIView (TouchScale)<FSAnimationDelegate>



- (void)playScaleAnimation:(CGFloat)scale complete:(_Nullable FSTouchScaleFinish)complete;
@end

NS_ASSUME_NONNULL_END
