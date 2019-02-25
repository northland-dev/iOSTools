//
//  RCActivityAwardPoolEnd.m
//  Ready
//
//  Created by jiapeng on 2019/1/3.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import "RCActivityAwardPoolEnd.h"

@implementation RCActivityAwardPoolEnd

- (NSData *)encode {
    return [self fs_JSONData];
}

- (void)decodeWithData:(NSData *)data {
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    self.awardPoolDict =[[NSDictionary alloc] init];
    self.awardPoolDict =dataDic;
}

+ (NSString *)getObjectName {
    return ACTIVITY_AWARD_POOL_COUNTDOWN;
}

+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_NONE;
}

@end
