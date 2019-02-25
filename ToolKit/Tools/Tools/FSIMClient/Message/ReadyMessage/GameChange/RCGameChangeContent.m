//
//  RCGameChangeContent.m
//  Ready
//
//  Created by mac on 2018/9/25.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCGameChangeContent.h"

@implementation RCGameChangeContent
- (NSData *)encode {
    NSDictionary *encodeInfo = [self willEncodeInfos];
    return [encodeInfo mj_JSONData];
}
- (void)decodeWithData:(NSData *)data {
    [super decodeWithData:data];
}

+ (NSString *)getObjectName {
    return FriendGameChange;
}

+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_NONE;
}
@end
