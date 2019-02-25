//
//  FSWeakFriendBridge.h
//  Ready
//
//  Created by mac on 2018/9/23.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSWeakBridgeDelegate.h"

@protocol FSFriendsManagerDelegate;
@interface FSWeakFriendBridge : FSWeakBridgeDelegate
@property(nonatomic,assign)id<FSFriendsManagerDelegate> delegate;

@end
