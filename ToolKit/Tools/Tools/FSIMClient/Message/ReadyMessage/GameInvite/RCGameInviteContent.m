//
//  RCGameInviteContent.m
//  Ready
//
//  Created by jiapeng on 2018/8/2.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCGameInviteContent.h"

@implementation RCGameInviteContent

- (NSData *)encode {
    NSDictionary *willEncodeInfo = [self willEncodeInfos];
    return [willEncodeInfo fs_JSONData];
}
- (NSDictionary *)willEncodeInfos {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];

    NSDictionary *superInfos = [super willEncodeInfos];
    
    if (self.gameId) {
        [dataDict setValue:self.gameId forKey:@"gameId"];
    }
    if (self.groupType) {
        [dataDict setValue:self.groupType forKey:@"groupType"];
    }
    if (self.gameName) {
        [dataDict setValue:self.gameName forKey:@"gameName"];
    }
    if (self.groupId) {
        [dataDict setValue:self.groupId forKey:@"groupId"];
    }
    
    [dataDict addEntriesFromDictionary:superInfos];
    return dataDict;
}

- (void)decodeWithData:(NSData *)data {
    [super decodeWithData:data];
    
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    self.gameId =[dataDic stringForKey:@"gameId"];
    self.groupType =[dataDic stringForKey:@"groupType"];
    self.gameName =[dataDic stringForKey:@"gameName"];
    self.groupId =[dataDic stringForKey:@"groupId"];

}

+ (NSString *)getObjectName {
    return GAME_INVITE;
}

+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_ISCOUNTED;
}
@end
