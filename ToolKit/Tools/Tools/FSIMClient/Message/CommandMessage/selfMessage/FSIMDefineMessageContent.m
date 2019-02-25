//
//  FSIMDefineMessageContent.m
//  Lolly
//
//  Created by stu on 2017/11/7.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSIMDefineMessageContent.h"

@implementation FSIMDefineMessageContent

+ (instancetype)messageWithName:(NSString *)name data:(NSString *)data {
    FSIMDefineMessageContent *message = [[FSIMDefineMessageContent alloc] init];
    message.name = name;
    message.data = data;
    return message;
}

@end
