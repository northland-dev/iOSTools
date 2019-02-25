//
//  RCTaskUpdateContent.m
//  Ready
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCTaskUpdateContent.h"

@implementation RCTaskUpdateContent

- (NSData *)encode {
    NSDictionary *willEncodeInfo = [self willEncodeInfos];
    return [willEncodeInfo fs_JSONData];
}
- (NSDictionary *)willEncodeInfos {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    NSDictionary *superInfos = [super willEncodeInfos];
    
    if (self.taskId) {
        [dataDict setValue:self.taskId forKey:@"taskId"];
    }
    [dataDict setValue:[NSNumber numberWithInteger:self.mtype] forKey:@"mtype"];
    [dataDict addEntriesFromDictionary:superInfos];
    
    return dataDict;
}

- (void)decodeWithData:(NSData *)data {
    [super decodeWithData:data];
    
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    self.taskId = [dataDic stringForKey:@"id"];
    self.mtype = [dataDic integerForKey:@"state"];
    
}
+ (NSString *)getObjectName {
    return TASK_STATE_UPDATE;
}
+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_NONE;
}
@end
