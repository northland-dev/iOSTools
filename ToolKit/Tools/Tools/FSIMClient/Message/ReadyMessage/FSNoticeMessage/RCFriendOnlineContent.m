//
//  RCFriendOnlineContent.m
//  Ready
//
//  Created by gongruike on 2018/9/12.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCFriendOnlineContent.h"

@implementation RCFriendOnlineContent

- (void)decodeWithData:(NSData *)data {
    [super decodeWithData:data];
    
    NSDictionary *jsonValue = [data mj_JSONObject];
    self.online = [jsonValue boolForKey:@"online"];
}
+ (NSString *)getObjectName {
    return ONLINE_STATE_UPDATE;
}
+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_NONE;
}

@end
