//
//  RCSystemContent.m
//  Ready
//
//  Created by gongruike on 2018/9/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCSystemContent.h"

@implementation RCSystemContent

- (NSData *)encode {
    return [self mj_JSONData];
}

- (void)decodeWithData:(NSData *)data {
    //
    [super decodeWithData:data];
    
    NSDictionary *dataDict = [data mj_JSONObject];
    
    self.systemTemplate = [dataDict integerForKey:@"template"];
    
    self.image = [dataDict stringForKey:@"img"];
    
    self.link = [dataDict stringForKey:@"link"];
    self.linkContent = [[dataDict stringForKey:@"linkContent"] mj_JSONObject];;
    
    self.titleContent = [[dataDict stringForKey:@"title"] mj_JSONObject];
    
    self.content = [[dataDict stringForKey:@"content"] mj_JSONObject];
}

+ (NSString *)getObjectName {
    return SYSTEM_INMAIL;
}

+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_ISCOUNTED;
}


@end
