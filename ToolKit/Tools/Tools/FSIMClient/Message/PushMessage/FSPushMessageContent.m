//
//  FSPushMessageContent.m
//  Lolly
//
//  Created by stu on 2017/12/7.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSPushMessageContent.h"

@implementation FSPushMessageContent

+ (instancetype)messageWithName:(NSString *)name data:(NSString *)data {
    FSPushMessageContent *message = [[FSPushMessageContent alloc] init];
    message.name = name;
    message.data = data;
    return message;
}

@end
