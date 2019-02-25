//
//  RCUnFriendContent.m
//  Ready
//
//  Created by mac on 2018/11/12.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCUnFriendContent.h"

@implementation RCUnFriendContent
- (NSData *)encode {
    NSDictionary *willEncodeInfo = [self willEncodeInfos];
    return [willEncodeInfo fs_JSONData];
}
- (NSDictionary *)willEncodeInfos {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    NSDictionary *superInfos = [super willEncodeInfos];
    [dataDict setInteger:self.tipType forKey:@"tipType"];
    [dataDict addEntriesFromDictionary:superInfos];
    return dataDict;
}
- (void)decodeWithData:(NSData *)data {
    NSDictionary *json = [data mj_JSONObject];
    
    self.tipType = [json integerForKey:@"tipType"];
}
+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_ISPERSISTED;
}
+ (NSString *)getObjectName {
    return @"READY:unfriendShipContent";
}
@end
