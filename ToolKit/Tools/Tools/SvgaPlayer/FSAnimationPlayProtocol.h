//
//  FSAnimationPlayProtocol.h
//  ButterFly
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FSAnimationStateProtocol;
@protocol FSAnimationPlayProtocol <NSObject>
@property(nonatomic,assign)id <FSAnimationStateProtocol> delegate;
- (void)playWithPath:(NSString *)path;
@optional
- (void)playWithUrl:(NSString *)url;
- (void)playWithData:(NSData *)data;
- (void)stop;
- (void)pause;
- (void)resume;
@end


@protocol FSAnimationStateProtocol <NSObject>
@optional
- (void)animationDidStart;
- (void)animationDidFinish:(NSError *)error;
- (void)animationDidPause;
- (void)animationDidResume;

- (void)animationDidToFrame:(NSInteger)frame;
@end
