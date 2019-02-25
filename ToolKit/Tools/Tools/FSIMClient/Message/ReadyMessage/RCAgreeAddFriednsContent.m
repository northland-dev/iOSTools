//
//  RCAgreeAddFriednsContent.m
//  Ready
//
//  Created by jiapeng on 2018/8/2.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCAgreeAddFriednsContent.h"

@implementation RCAgreeAddFriednsContent

- (NSData *)encode {
    return [self fs_JSONData];
}

- (void)decodeWithData:(NSData *)data {
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    self.mExtern =[dataDic stringForKey:@"extern"];
//    self.fromUserId =[dataDic integerForKey:@"fromUserId"];
//    self.st =[dataDic int32ForKey:@"st"];
    self.type =[dataDic stringForKey:@"type"];
}

+ (NSString *)getObjectName {
    return FRIEND_AGREE;
}

+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_ISCOUNTED;
}

@end
