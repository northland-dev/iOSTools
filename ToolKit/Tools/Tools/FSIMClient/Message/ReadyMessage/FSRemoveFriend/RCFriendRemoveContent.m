//
//  RCFriendRemoveContent.m
//  Ready
//
//  Created by mac on 2018/11/9.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCFriendRemoveContent.h"

@implementation RCFriendRemoveContent

-(void)decodeWithData:(NSData *)data {
    [super decodeWithData:data];
    
    NSDictionary *jsonInfo = [data mj_JSONObject];
    self.userId = [jsonInfo stringForKey:@"userId"];
}
+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_NONE;
}
+(NSString *)getObjectName {
    return @"READY:FriendRemove";
}
@end
