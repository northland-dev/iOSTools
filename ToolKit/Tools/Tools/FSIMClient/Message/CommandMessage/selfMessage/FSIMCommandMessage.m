//
//  FSIMCommandMessage.m
//  testRongYun
//
//  Created by stu on 2017/11/2.
//  Copyright © 2017年 stu. All rights reserved.
//

#import "FSIMCommandMessage.h"

@implementation FSIMCommandMessage

+ (instancetype)messageWithName:(NSString *)name data:(NSString *)data {
    FSIMCommandMessage *message = [[FSIMCommandMessage alloc] init];
    message.name = name;
    message.data = data;
    return message;
}

@end
