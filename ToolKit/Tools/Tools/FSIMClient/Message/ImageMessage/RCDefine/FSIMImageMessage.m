//
//  FSIMImageMessage.m
//  testRongYun
//
//  Created by stu on 2017/11/2.
//  Copyright © 2017年 stu. All rights reserved.
//

#import "FSIMImageMessage.h"

@implementation FSIMImageMessage

+ (instancetype)messageWithImage:(UIImage *)image {
    FSIMImageMessage *message = [[FSIMImageMessage alloc] init];
    message.originalImage = image;
    return message;
}

+ (instancetype)messageWithImageURI:(NSString *)imageURI {
    FSIMImageMessage *message = [[FSIMImageMessage alloc] init];
    message.imageUrl = imageURI;
    return message;
}

@end
