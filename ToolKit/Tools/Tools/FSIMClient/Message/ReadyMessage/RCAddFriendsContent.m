//
//  RCAddFriendsContent.m
//  Ready
//
//  Created by jiapeng on 2018/8/1.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCAddFriendsContent.h"

@implementation RCAddFriendsContent

- (NSData *)encode {
    NSDictionary *willEncodeInfo = [self willEncodeInfos];
    return [willEncodeInfo fs_JSONData];
}
- (NSDictionary *)willEncodeInfos {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    NSDictionary *superInfos = [super willEncodeInfos];
    [dataDict addEntriesFromDictionary:superInfos];
    return dataDict;
}
- (void)decodeWithData:(NSData *)data {
    [super decodeWithData:data];
}

+ (NSString *)getObjectName {
    return FRIEND_ADD;
}
+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_ISPERSISTED;
}

@end
