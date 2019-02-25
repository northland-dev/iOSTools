//
//  FSMarqueeLabel.h
//  Ready
//
//  Created by mac on 2019/1/4.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FSMarqueeLabel;
@protocol FSMarqueeLabelDelegate <NSObject>
@optional
- (void)marqueeLabelDidStartAnimation;
- (void)marqueeLabelDidStopAnimation;
- (void)marqueeLabelDidPause:(FSMarqueeLabel *)label;
- (void)marqueeLabelDidStop:(FSMarqueeLabel *)label;

@end
@interface FSMarqueeLabel : UILabel
@property(nonatomic,assign)id<FSMarqueeLabelDelegate> delegate;
/**
 父视图的w
 */
@property(nonatomic,assign)CGFloat superWidth;
/**
 在x坐标轴 移动的距离
 */
@property(nonatomic,assign)CGFloat offWidth;

- (BOOL)isInPlay;
- (void)start;
- (void)stop;
- (void)pause;
- (void)resume;
- (void)releasePointers;
@end

NS_ASSUME_NONNULL_END
