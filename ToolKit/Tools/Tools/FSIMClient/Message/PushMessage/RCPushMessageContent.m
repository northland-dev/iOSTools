//
//  RCPushMessageContent.m
//  Lolly
//
//  Created by stu on 2017/12/7.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "RCPushMessageContent.h"

@implementation RCPushMessageContent

- (NSData *)encode {
    return [self fs_JSONData];
}

- (void)decodeWithData:(NSData *)data {
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [self fs_setKeyValues:dataDic];
}

+ (NSString *)getObjectName {
    return @"LOLLY:100008";
}

+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_NONE;
}

+ (instancetype)messageWithName:(NSString *)name data:(NSString *)data {
    RCPushMessageContent *message = [[RCPushMessageContent alloc] init];
    message.name = name;
    message.data = data;
    return message;
}


@end
