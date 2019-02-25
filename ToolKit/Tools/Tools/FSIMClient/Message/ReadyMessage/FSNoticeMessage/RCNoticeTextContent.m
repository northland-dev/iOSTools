//
//  RCNoticeTextContent.m
//  Ready
//
//  Created by mac on 2018/9/9.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCNoticeTextContent.h"

@implementation RCNoticeTextContent
- (NSData *)encode {
    NSDictionary *willEncodeInfo = [self willEncodeInfos];
    return [willEncodeInfo fs_JSONData];
}
- (NSDictionary *)willEncodeInfos {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    NSDictionary *superInfos = [super willEncodeInfos];
    
    if (self.noticeTextKey) {
        [dataDict setValue:self.noticeTextKey forKey:@"noticeTextKey"];
    }
    if (self.noticeTextStr) {
        [dataDict setValue:self.noticeTextStr forKey:@"noticeTextStr"];
    }
    
    [dataDict addEntriesFromDictionary:superInfos];
    return dataDict;
}

- (void)decodeWithData:(NSData *)data {
    [super decodeWithData:data];
    
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    self.noticeTextKey =[dataDic stringForKey:@"noticeTextKey"];
    self.noticeTextStr =[dataDic stringForKey:@"noticeTextStr"];

}

+ (NSString *)getObjectName {
    return @"Ready:LocalNotice";
}

+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_ISPERSISTED;
}
@end
