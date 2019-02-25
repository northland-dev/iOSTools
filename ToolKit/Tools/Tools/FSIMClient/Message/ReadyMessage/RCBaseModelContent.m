//
//  RCBaseModelContent.m
//  Ready
//
//  Created by jiapeng on 2018/8/2.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCBaseModelContent.h"

@implementation RCBaseModelContent
- (NSData *)encode {
    return [[self willEncodeInfos] fs_JSONData];
}
- (NSDictionary *)willEncodeInfos {
    NSMutableDictionary *dictInfos = [NSMutableDictionary dictionary];
    if (self.mExtern) {
        [dictInfos setValue:self.mExtern forKey:@"extern"];
    }
    
    NSString *fromUserId = [NSString stringWithFormat:@"%ld",self.fromUserId];
    if (fromUserId) {
        [dictInfos setValue:fromUserId forKey:@"fromUserId"];
    }
    
    NSString *sendTime = [NSString stringWithFormat:@"%ld",self.st];
    if (sendTime) {
        [dictInfos setValue:sendTime forKey:@"st"];
    }
    
    if (self.type) {
        [dictInfos setValue:self.type forKey:@"type"];
    }
    
    if (self.senderUserInfo) {
        
        NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] init];
        if (self.senderUserInfo.name) {
            [userInfoDic setObject:self.senderUserInfo.name
                 forKeyedSubscript:@"name"];
        }
        if (self.senderUserInfo.portraitUri) {
            [userInfoDic setObject:self.senderUserInfo.portraitUri
                 forKeyedSubscript:@"portrait"];
        }
        if (self.senderUserInfo.userId) {
            [userInfoDic setObject:self.senderUserInfo.userId
                 forKeyedSubscript:@"id"];
        }
        [dictInfos setObject:userInfoDic forKey:@"user"];
    }
    return dictInfos;
}
- (void)decodeWithData:(NSData *)data {
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    self.mExtern =[dataDic stringForKey:@"extern"];
    self.fromUserId =[dataDic integerForKey:@"fromUserId"];
    self.st =[dataDic int32ForKey:@"st"];
    self.type =[dataDic stringForKey:@"type"];
    NSDictionary *userDict = [dataDic valueForKey:@"user"];
    RCUserInfo *userInfo = [[RCUserInfo alloc] init];
    userInfo.name = [userDict valueForKey:@"name"];
    userInfo.portraitUri = [userDict valueForKey:@"portrait"];
    userInfo.userId = [userDict valueForKey:@"id"];
    
    self.senderUserInfo = userInfo;
}
@end
