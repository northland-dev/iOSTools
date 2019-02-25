//
//  GCAudioPlayer.h
//  Ready
//
//  Created by mac on 2018/8/21.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GCAudioPlayerDelegate <NSObject>
@optional
//播放完回调
-(void)playerFinishMethod:(BOOL)flage;

-(void)playerFinishMethod:(BOOL)flage messageId:(NSString *)messageId;

@end


@interface GCAudioPlayer : NSObject
+ (instancetype)sharedPlayer;
@property (nonatomic,weak) id <GCAudioPlayerDelegate> delegate;

@property (nonatomic,strong)NSString *messageId;

- (void)addDelegate:(id<GCAudioPlayerDelegate>)delegate;

- (void)removeDelegate:(id<GCAudioPlayerDelegate>)delegate;

- (BOOL)isPlaying;

- (void)playWithData:(NSData *)data;

- (void)stop;
@end
