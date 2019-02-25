//
//  FSSvgaPlayer.m
//  ButterFly
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSSvgaPlayer.h"
#import <SVGAPlayer/SVGAPlayer.h>
#import <SVGAPlayer/SVGAParser.h>
#import <AudioToolbox/AudioToolbox.h>

@interface FSSvgaPlayer()<SVGAPlayerDelegate>

@property(nonatomic,strong)SVGAPlayer *svgaPlayer;
@property(nonatomic,strong)SVGAParser *svgaParser;
@property(nonatomic,assign)BOOL isPlaying;
@end
@implementation FSSvgaPlayer
@synthesize delegate;
- (SVGAParser *)svgaParser {
    if (!_svgaParser) {
        _svgaParser = [[SVGAParser alloc] init];
    }
    return _svgaParser;
}
- (SVGAPlayer *)svgaPlayer {
    if (!_svgaPlayer) {
         _svgaPlayer = [[SVGAPlayer alloc] init];
        [_svgaPlayer setDelegate:self];
        [_svgaPlayer setLoops:1];
    }
    return _svgaPlayer;
}
- (void)setLoopCount:(NSInteger)loopCount {
    [self.svgaPlayer setLoops:loopCount];
}
- (UIView *)svgePlayerView {
    return self.svgaPlayer;
}
- (void)playWithPath:(NSString *)path {
    if (self.isPlaying) {
        // 正在播放
        return;
    }
    
    if (!_shouldNotPlayVibrate) {
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }

    NSString *name = [[path lastPathComponent] stringByDeletingPathExtension];
    __weak typeof(self) weakS = self;
    [self.svgaParser parseWithNamed:name inBundle:[NSBundle mainBundle] completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
        [weakS.svgaPlayer setVideoItem:videoItem];
        [weakS.svgaPlayer startAnimation];
        // 通知开始
        if ([weakS.delegate respondsToSelector:@selector(animationDidStart)]) {
            [weakS.delegate animationDidStart];
        }
        
        weakS.isPlaying = YES;
    } failureBlock:^(NSError * _Nonnull error) {
        // 通知报错
        if ([weakS.delegate respondsToSelector:@selector(animationDidFinish:)]) {
            [weakS.delegate animationDidFinish:error];
        }
        weakS.isPlaying = NO;
    }];
    
}

- (void)playWithUrl:(NSString *)url {
    if (self.isPlaying) {
        // 正在播放
        return;
    }
    
    NSURL *rurl = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:rurl];
    __weak typeof(self) weakS = self;
    [self.svgaParser parseWithURLRequest:request completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
        [weakS.svgaPlayer setVideoItem:videoItem];
        [weakS.svgaPlayer startAnimation];
        // 通知开始
        if ([weakS.delegate respondsToSelector:@selector(animationDidStart)]) {
            [weakS.delegate animationDidStart];
        }
        
        weakS.isPlaying = YES;
    } failureBlock:^(NSError * _Nullable error) {
        // 通知报错
        if ([weakS.delegate respondsToSelector:@selector(animationDidFinish:)]) {
            [weakS.delegate animationDidFinish:error];
        }
        weakS.isPlaying = NO;
    }];
}
- (void)stop {
    [self.svgaPlayer setClearsAfterStop:YES];
    [self.svgaPlayer stopAnimation];
    self.isPlaying = NO;
}
- (void)stopAndClear:(BOOL)clear {
    [self.svgaPlayer setClearsAfterStop:clear];
    [self.svgaPlayer stopAnimation];
    self.isPlaying = NO;
}
#pragma mark - SVGAPlayerDelegate
- (void)svgaPlayerDidFinishedAnimation:(SVGAPlayer *)player{
    if ([self.delegate respondsToSelector:@selector(animationDidFinish:)]) {
        [self.delegate animationDidFinish:nil];
    }
    if (!_shouldRemainOnFinish) {
        // 移除
        [player removeFromSuperview];
    }
    self.isPlaying = NO;
}
- (void)svgaPlayerDidAnimatedToFrame:(NSInteger)frame {
    if ([self.delegate respondsToSelector:@selector(animationDidToFrame:)]) {
        [self.delegate animationDidToFrame:frame];
    }
}
- (void)svgaPlayerDidAnimatedToPercentage:(CGFloat)percentage {
    
}
@end
