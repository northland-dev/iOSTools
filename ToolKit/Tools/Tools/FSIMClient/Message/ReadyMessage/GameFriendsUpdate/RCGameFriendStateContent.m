//
//  RCGameFriendStateContent.m
//  Ready
//
//  Created by mac on 2018/8/29.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCGameFriendStateContent.h"
#import "NSDictionary+FSSafeAccess.h"

@implementation RCGameFriendStateContent

- (void)decodeWithData:(NSData *)data {
    [super decodeWithData:data];
    
    NSDictionary *jsonValue = [data mj_JSONObject];
    self.gameId = [jsonValue stringForKey:@"gameId"];
    self.gameRoomId = [jsonValue stringForKey:@"gameRoomId"];
    self.gameState = [jsonValue integerForKey:@"gameState"];

}
+ (NSString *)getObjectName {
    return FriendGameStateUpdate;
}
+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_NONE;
}
@end
