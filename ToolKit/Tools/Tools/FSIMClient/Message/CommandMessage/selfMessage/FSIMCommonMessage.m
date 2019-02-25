//
//  FSIMCommonMessage.m
//  Lolly
//
//  Created by stu on 2017/11/7.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSIMCommonMessage.h"

@implementation FSIMCommonMessage

- (NSData *)encode {
    NSDictionary *json = [self mj_keyValues];
    
    return [json fs_JSONData];
}

- (void)decodeWithData:(NSData *)data {
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [self fs_setKeyValues:dataDic];
}

+ (NSString *)getObjectName {
    return @"LOLLY:100004";
}

+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_NONE;
}

+ (instancetype)messageWithName:(NSString *)name data:(NSString *)data {
    FSIMCommonMessage *message = [[FSIMCommonMessage alloc] init];
    message.name = name;
    message.data = data;
    return message;
}

@end
