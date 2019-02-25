//
//  RCFriendsMessageContent.m
//  Ready
//
//  Created by jiapeng on 2018/8/2.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCFriendsMessageContent.h"

@implementation RCFriendsMessageContent

- (NSData *)encode {
    NSDictionary *willEncodeInfo = [self willEncodeInfos];
    return [willEncodeInfo fs_JSONData];
}
- (NSDictionary *)willEncodeInfos {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    NSDictionary *superInfos = [super willEncodeInfos];
    
    if (self.message) {
        [dataDict setValue:self.message forKey:@"message"];
    }
    if (self.messageType) {
        [dataDict setValue:self.messageType forKey:@"messageType"];
    }
    
    [dataDict addEntriesFromDictionary:superInfos];
    return dataDict;
}

- (void)decodeWithData:(NSData *)data {
    [super decodeWithData:data];
    
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
    self.messageType =[dataDic stringForKey:@"messageType"];
    self.message =[dataDic stringForKey:@"message"];
}

+ (NSString *)getObjectName {
    return FRIEND_CUSTOM_MESSAGE;
}

+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_ISCOUNTED;
}

@end
