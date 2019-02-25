//
//  RCBalanceUpdateContent.m
//  Ready
//
//  Created by mac on 2018/9/27.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCBalanceUpdateContent.h"

@implementation RCBalanceUpdateContent
- (void)decodeWithData:(NSData *)data {
    [super decodeWithData:data];
    
    NSDictionary *jsonInfo = [data mj_JSONObject];
    
    self.reasonType = [jsonInfo integerForKey:@"reasonType"];
    
    NSArray *balances = [jsonInfo valueForKey:@"balance"];
    
    self.balance = [FSVpBalanceData mj_objectArrayWithKeyValuesArray:balances];
    
}
+(NSString *)getObjectName{
    return BALANCE_UPDATE;
}
+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_NONE;
}
@end
