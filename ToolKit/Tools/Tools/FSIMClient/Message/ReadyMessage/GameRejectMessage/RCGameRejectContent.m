//
//  RCGameRejectContent.m
//  Ready
//
//  Created by mac on 2018/8/26.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCGameRejectContent.h"

@implementation RCGameRejectContent
- (void)decodeWithData:(NSData *)data {
    [super decodeWithData:data];
    
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    self.groupId =[dataDic stringForKey:@"groupId"];
}
+ (NSString *)getObjectName {
    return GameReject;
}
+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_NONE;
}
@end
