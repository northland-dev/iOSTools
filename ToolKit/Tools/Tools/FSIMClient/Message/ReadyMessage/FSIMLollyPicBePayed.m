//
//  FSIMLollyPicBePayed.m
//  Lolly
//
//  Created by Charles on 2017/11/19.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSIMLollyPicBePayed.h"

@implementation FSIMLollyPicBePayed

+ (instancetype)messageWithName:(NSString *)name data:(NSString *)data {
    FSIMLollyPicBePayed *message = [[FSIMLollyPicBePayed alloc] init];
    message.name = name;
    message.data = data;
    return message;
}

- (void)setData:(NSString *)data {
    _data = data;
    // {"p":100,"s":"group1/M00/12/5E/CgogmFow7I-AODowAA137yxQC8k936.png","mid":-1,"ic":1,"rid":3309,"o":"group1/M00/12/5E/CgogmFow7I-AfhjXAAgPCj2cgjI974.png"}

    NSDictionary *info = [data mj_JSONObject];
    [self setHostId:[info stringForKey:@"hostId"]];
    [self setPreviewUrl:[info stringForKey:@"s"]];
    [self setOriginalUrl:[info stringForKey:@"o"]];
    [self setPrice:[info integerForKey:@"p"]];
    [self setPhotoId:[info stringForKey:@"rid"]];
    [self setOriginalMessageId:[info integerForKey:@"mid"]];
}

@end
