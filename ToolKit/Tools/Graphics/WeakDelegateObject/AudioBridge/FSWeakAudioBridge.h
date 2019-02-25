//
//  FSWeakAudioDelegate.h
//  Ready
//
//  Created by mac on 2018/9/23.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GCAudioPlayerDelegate;
@interface FSWeakAudioBridge : NSObject
@property(nonatomic,assign)id<GCAudioPlayerDelegate> delegate;
@end
