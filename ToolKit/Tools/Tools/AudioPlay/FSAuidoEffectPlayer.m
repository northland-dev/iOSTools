//
//  FSAuidoEffectPlayer.m
//  Ready
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import "FSAuidoEffectPlayer.h"
#import <AVFoundation/AVFoundation.h>
@interface FSAuidoEffectPlayer()<AVAudioPlayerDelegate>
@property(nonatomic,strong)AVAudioPlayer *player;
@end
@implementation FSAuidoEffectPlayer
static FSAuidoEffectPlayer *sharedPlayer;
+ (instancetype)sharedPlayer {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPlayer = [[FSAuidoEffectPlayer alloc] init];
    });
    return sharedPlayer;
}
+ (void)playMatchEffect {
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSString *urlString = [bundle pathForResource:@"matching_success" ofType:@"mp3"];
    
    /* 初始化url */
    NSURL *url = [[NSURL alloc] initFileURLWithPath:urlString];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [FSAuidoEffectPlayer sharedPlayer].player = player;
    [player prepareToPlay];
    [player play];
}
+ (void)playLoseEffect {
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSString *urlString = [bundle pathForResource:@"icon_game_lose" ofType:@"mp3"];
    
    /* 初始化url */
    NSURL *url = [[NSURL alloc] initFileURLWithPath:urlString];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [FSAuidoEffectPlayer sharedPlayer].player = player;
    [player prepareToPlay];
    [player play];
}
+ (void)playWinEffect {
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSString *urlString = [bundle pathForResource:@"icon_game_win" ofType:@"mp3"];
    
    /* 初始化url */
    NSURL *url = [[NSURL alloc] initFileURLWithPath:urlString];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [FSAuidoEffectPlayer sharedPlayer].player = player;
    [player prepareToPlay];
    [player play];
}
@end
