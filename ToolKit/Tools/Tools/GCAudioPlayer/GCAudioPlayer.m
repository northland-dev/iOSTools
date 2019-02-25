//
//  GCAudioPlayer.m
//  Ready
//
//  Created by mac on 2018/8/21.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "GCAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "amrFileCodec.h"
#import "CDPAudioRecorder.h"
#import "FSWeakAudioBridge.h"

@interface GCAudioPlayer()<AVAudioPlayerDelegate>
{
    BOOL _isPlaying;
}
@property(nonatomic,strong)AVAudioPlayer *audioplayer;
@property(nonatomic,strong)NSMutableArray *delegates;
@end
@implementation GCAudioPlayer
static GCAudioPlayer *sharePlayer = nil;
+ (instancetype)sharedPlayer {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharePlayer = [[GCAudioPlayer alloc] init];
    });
    return sharePlayer;
}
- (void)playWithData:(NSData *)data {
    
    if(_isPlaying) return;
    
    NSError *error;
    
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    //设置为播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
    NSString *filePath = [DocumentPath stringByAppendingPathComponent:@"/Audios/Amrs/willPlay.amr"];
    //判断是否存在,不存在则创建

    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:&error];
    }

    NSString *audioRecordDirectories = [filePath stringByDeletingLastPathComponent];
    [fileManager createDirectoryAtPath:audioRecordDirectories withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    BOOL success = [data writeToFile:filePath atomically:YES];
    if (!success) {
        return;
    }
    NSString *converfilePath = [DocumentPath stringByAppendingPathComponent:@"/Audios/Amrs/shouldPlay.wav"];
    [CDPAudioRecorder convertAMRtoWAV:filePath savePath:converfilePath];
    NSData *fileData = [NSData dataWithContentsOfFile:converfilePath options:NSDataReadingMapped error:nil];

    self.audioplayer = [[AVAudioPlayer alloc] initWithData:fileData error:&error];
    self.audioplayer.delegate=self;
    if (error) {
        NSLog(@"%@",error);
        return;
    }
    
    [self.audioplayer prepareToPlay];
    [self.audioplayer play];
    _isPlaying = YES;
}
- (BOOL)isPlaying {
    return _isPlaying;
}
- (void)stop {
    _isPlaying = NO;
    [self.audioplayer stop];
    for (id<GCAudioPlayerDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(playerFinishMethod:messageId:)]) {
            [delegate playerFinishMethod:YES messageId:self.messageId];
        }
    }    
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    _isPlaying = NO;
    
    if ([_delegate respondsToSelector:@selector(playerFinishMethod:)]) {
        [_delegate playerFinishMethod:flag];
    }
    
    WS(weaks);
    [self.delegates enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FSWeakAudioBridge *bridge = (FSWeakAudioBridge *)obj;
        if (bridge.delegate == nil) {
            [weaks.delegates removeObject:obj];
        }else{
            if ([bridge.delegate respondsToSelector:@selector(playerFinishMethod:messageId:)]) {
                [bridge.delegate playerFinishMethod:flag messageId:self.messageId];
            }
        }
    }];
}

- (void)addDelegate:(id<GCAudioPlayerDelegate>)delegate {
    
    for (FSWeakAudioBridge *bridge in self.delegates) {
        if ([bridge.delegate isEqual:delegate]) {
            // 已存在
            return;
        }
    }
    
    FSWeakAudioBridge *bridge = [[FSWeakAudioBridge alloc] init];
    bridge.delegate = delegate;
    [self.delegates addObject:bridge];
}
- (void)removeDelegate:(id<GCAudioPlayerDelegate>)delegate {
    WS(weaks);
    [self.delegates enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FSWeakAudioBridge *audioBridge = (FSWeakAudioBridge *)obj;
        if ([audioBridge.delegate isEqual:delegate]) {
            [weaks.delegates removeObject:audioBridge];
            *stop = YES;
        }
    }];
}
- (NSMutableArray *)delegates {
    if (!_delegates) {
        _delegates = [NSMutableArray array];
    }
    return _delegates;
}

@end
