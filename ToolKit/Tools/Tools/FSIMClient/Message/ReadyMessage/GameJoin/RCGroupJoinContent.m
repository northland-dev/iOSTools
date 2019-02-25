//
//  RCGroupJoinContent.m
//  Ready
//
//  Created by jiapeng on 2018/8/2.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCGroupJoinContent.h"

@implementation RCGroupJoinContent

- (void)decodeWithData:(NSData *)data {
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    self.mExtern =[dataDic stringForKey:@"extern"];
//    self.fromUserId =[dataDic integerForKey:@"fromUserId"];
//    self.st =[dataDic int32ForKey:@"st"];
    self.type =[dataDic stringForKey:@"type"];
    self.onlineNumber =[dataDic integerForKey:@"online"];
    self.roomNumber =[dataDic integerForKey:@"number"];
    self.userInfo =[dataDic valueForKey:@"userInfo"];
    self.groupType =[dataDic stringForKey:@"groupType"];
    self.groupId =[dataDic stringForKey:@"groupId"];
    self.userId =[dataDic integerForKey:@"userId"];
}

+ (NSString *)getObjectName {
    return GROUP_JOIN;
}

+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_NONE;
}

@end
