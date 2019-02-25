//
//  RCPayPicMessage.m
//  Lolly
//
//  Created by stu on 2017/11/7.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "RCPayPicMessage.h"

@implementation RCPayPicMessage

/// NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.data = [aDecoder decodeObjectForKey:@"data"];
//        self.soureImage = [aDecoder decodeObjectForKey:@"soureImage"];
//        self.thumbImage = [aDecoder decodeObjectForKey:@"thumbImage"];
        self.localSoureImage = [aDecoder decodeObjectForKey:@"localsoureImage"];
        self.localThumbImage = [aDecoder decodeObjectForKey:@"localThumbImage"];
    }
    return self;
}

/// NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.data forKey:@"data"];
//    [aCoder encodeObject:self.soureImage forKey:@"soureImage"];
//    [aCoder encodeObject:self.thumbImage forKey:@"thumbImage"];
    [aCoder encodeObject:self.localSoureImage forKey:@"localSoureImage"];
    [aCoder encodeObject:self.localThumbImage forKey:@"localThumbImage"];

}

///将消息内容编码成json
- (NSData *)encode {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict setObject:self.data forKey:@"data"];
    if (self.name) {
        [dataDict setObject:self.name forKey:@"name"];
    }
    
//    if (self.soureImage) {
//        NSData *data = UIImagePNGRepresentation(self.soureImage);
//        NSString *dataStr = [data base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
//        [dataDict setObject:dataStr forKey:@"soureImage"];
//    }
//    if (self.thumbImage) {
//        NSData *data = UIImagePNGRepresentation(self.thumbImage);
//        NSString *dataStr = [data base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
//        [dataDict setObject:dataStr forKey:@"thumbImage"];
//    }
    
    if (self.localSoureImage) {
        [dataDict setObject:self.localSoureImage forKey:@"localSoureImage"];
    }
    
    if (self.localThumbImage) {
        [dataDict setObject:self.localThumbImage forKey:@"localThumbImage"];
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
        [dataDict setObject:userInfoDic forKey:@"user"];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:dataDict
                                                   options:kNilOptions
                                                     error:nil];
    return data;
}

///将json解码生成消息内容
- (void)decodeWithData:(NSData *)data {
    if (data) {
        __autoreleasing NSError *error = nil;
        
        NSDictionary *dictionary =
        [NSJSONSerialization JSONObjectWithData:data
                                        options:kNilOptions
                                          error:&error];
        
        if (dictionary) {
            self.data = dictionary[@"data"];
            self.name = dictionary[@"name"];
            
            
            NSDictionary *dataJSON = [self.data mj_JSONObject];
            NSString *originalUrl = [dataJSON valueForKey:@"o"];
            
            NSString *sourceimageDataStr = dictionary[@"localSoureImage"];
            if (sourceimageDataStr.length && originalUrl.length == 0) {
//                NSData *sourceImageData = [[NSData alloc] initWithBase64EncodedString:sourceimageDataStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
//                self.soureImage = [UIImage imageWithData:sourceImageData];
                self.localSoureImage = sourceimageDataStr;
            }
//
//
            NSString *thumbimageDataStr = dictionary[@"localThumbImage"];
            NSString *thumbUrl = [dataJSON valueForKey:@"s"];
            if (thumbimageDataStr.length && thumbUrl.length == 0) {
//                NSData *thumbImageData = [[NSData alloc] initWithBase64EncodedString:thumbimageDataStr options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
//                self.thumbImage = [UIImage imageWithData:thumbImageData];
                self.localThumbImage = thumbimageDataStr;
            }

            NSDictionary *userinfoDic = dictionary[@"user"];
            [self decodeUserInfo:userinfoDic];
        }
    }
}


+ (NSString *)getObjectName {
    return @"LOLLY:400001";
}

+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_ISCOUNTED;
}

+ (instancetype)messageWithName:(NSString *)name data:(NSString *)data {
    RCPayPicMessage *message = [[RCPayPicMessage alloc] init];
    message.name = name;
    message.data = data;
    return message;
}

@end
