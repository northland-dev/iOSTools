//
//  RCGameMatchMessage.m
//  Ready
//
//  Created by mac on 2018/8/24.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCGameMatchMessage.h"

@implementation RCGameMatchMessage
//- (NSData *)encode {
//    NSDictionary *willEncodeInfo = [self willEncodeInfos];
//    return [willEncodeInfo fs_JSONData];
//}
//- (NSDictionary *)willEncodeInfos {
//    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
//    
//    NSDictionary *superInfos = [super willEncodeInfos];
//    
//    if (self.groupId) {
//        [dataDict setValue:self.groupId forKey:@"groupId"];
//    }
//    if (self.groupType) {
//        [dataDict setValue:self.groupType forKey:@"groupType"];
//    }
//    
//    [dataDict addEntriesFromDictionary:superInfos];
//    return dataDict;
//}

- (void)decodeWithData:(NSData *)data {
    [super decodeWithData:data];
    
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    self.groupId =[dataDic stringForKey:@"groupId"];
    self.groupType = [dataDic stringForKey:@"groupType"];
    self.users = [dataDic valueForKey:@"users"];
    
}
+ (NSString *)getObjectName {
    return GROUP_MATCH_SUCCESS;
}
+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_NONE;
}
@end
