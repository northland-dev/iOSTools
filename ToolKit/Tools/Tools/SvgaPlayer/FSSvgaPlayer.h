//
//  FSSvgaPlayer.h
//  ButterFly
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSAnimationPlayProtocol.h"
#import <UIKit/UIKit.h>

@interface FSSvgaPlayer : NSObject<FSAnimationPlayProtocol>

@property(nonatomic,assign)BOOL shouldRemainOnFinish;

@property(nonatomic,assign)BOOL shouldNotPlayVibrate;

@property(nonatomic,assign)NSInteger loopCount;

- (UIView *)svgePlayerView;


- (void)stop;

- (void)stopAndClear:(BOOL)clear;
@end
