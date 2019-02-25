//
//  RCGameInviteAcceptContent.m
//  Ready
//
//  Created by mac on 2018/10/15.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCGameInviteAcceptContent.h"

@implementation RCGameInviteAcceptContent

-(void)decodeWithData:(NSData *)data {
    [super decodeWithData:data];
    
    NSDictionary *jsonInfo = [data mj_JSONObject];
    self.groupId = [jsonInfo stringForKey:@"groupId"];
    self.groupType = [jsonInfo stringForKey:@"groupType"];
    self.userType = [jsonInfo integerForKey:@"userType"];
    
}
+(NSString *)getObjectName{
    return GameInviteAccept;
}
+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_NONE;
}
@end
