//
//  FSAuidoEffectPlayer.h
//  Ready
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSAuidoEffectPlayer : NSObject
+ (void)playMatchEffect;
+ (void)playLoseEffect;
+ (void)playWinEffect;
@end

NS_ASSUME_NONNULL_END
