//
//  RCDanmuContent.m
//  Ready
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCDanmuContent.h"

@implementation RCDanmuContent

- (NSData *)encode {
    return [self fs_JSONData];
}

- (void)decodeWithData:(NSData *)data {
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    self.danmuDict =[[NSDictionary alloc] init];
    self.danmuDict =dataDic;
}

+ (NSString *)getObjectName {
    return DanmuMessage;
}

+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_NONE;
}

@end
