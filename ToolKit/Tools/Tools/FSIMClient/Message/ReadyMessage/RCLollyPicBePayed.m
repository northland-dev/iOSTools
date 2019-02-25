//
//  RCLollyPicBePayed.m
//  Lolly
//
//  Created by Charles on 2017/11/19.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "RCLollyPicBePayed.h"

@implementation RCLollyPicBePayed

- (NSData *)encode {
    return [self fs_JSONData];
}

- (void)decodeWithData:(NSData *)data {
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [self fs_setKeyValues:dataDic];
}

+ (NSString *)getObjectName {
    return @"LOLLY:400002";
}

+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_ISCOUNTED;
}

+ (instancetype)messageWithName:(NSString *)name data:(NSString *)data {
    RCLollyPicBePayed *message = [[RCLollyPicBePayed alloc] init];
    message.name = name;
    message.data = data;
    return message;
}

@end
