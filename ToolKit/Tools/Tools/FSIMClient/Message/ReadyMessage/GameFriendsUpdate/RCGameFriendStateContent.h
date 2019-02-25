//
//  RCGameFriendStateContent.h
//  Ready
//
//  Created by mac on 2018/8/29.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCBaseModelContent.h"

@interface RCGameFriendStateContent : RCBaseModelContent
//"fromUserId":1554,"gameId":6,"gameRoomId":"1042018082900000189","gameState":100,"st":1535556742794
@property(nonatomic,strong)NSString *gameId;
@property(nonatomic,strong)NSString *gameRoomId;

// public static final int PLAYING = 100;

// public static final int COMPLETED = 200;
@property(nonatomic,assign)NSInteger gameState;

@end
