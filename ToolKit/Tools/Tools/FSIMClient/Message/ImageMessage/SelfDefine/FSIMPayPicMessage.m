//
//  FSIMPayPicMessage.m
//  Lolly
//
//  Created by stu on 2017/11/7.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSIMPayPicMessage.h"
#import <MJExtension/MJExtension.h>
#import "NSDictionary+FSSafeAccess.h"

@implementation FSIMPayPicMessage

+ (instancetype)messageWithName:(NSString *)name data:(NSString *)data {
    FSIMPayPicMessage *message = [[FSIMPayPicMessage alloc] init];
    message.name = name;
    message.data = data;
    return message;
}

- (void)setData:(NSString *)data {
    _data = data;
    
    NSDictionary *info = [data mj_JSONObject];
    [self setImgUrl:[info stringForKey:@"s"]];
    [self setOriginalUrl:[info stringForKey:@"o"]];
    [self setGold:[info integerForKey:@"p"]];
    [self setPhotoId:[info stringForKey:@"rid"]];
    [self setMid:[info integerForKey:@"mid"]];
}

@end
