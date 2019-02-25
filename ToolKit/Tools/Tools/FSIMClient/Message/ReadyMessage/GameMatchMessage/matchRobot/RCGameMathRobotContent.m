//
//  RCGameMathRobotContent.m
//  Ready
//
//  Created by mac on 2018/8/24.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCGameMathRobotContent.h"

@implementation RCGameMathRobotContent
- (void)decodeWithData:(NSData *)data {
    [super decodeWithData:data];
    
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    self.groupId =[dataDic stringForKey:@"groupId"];
    self.groupType = [dataDic stringForKey:@"groupType"];
    self.users = [dataDic valueForKey:@"users"];
    
}
+ (NSString *)getObjectName {
    return GROUP_MATCH_ROBOT;
}
+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_NONE;
}
@end
