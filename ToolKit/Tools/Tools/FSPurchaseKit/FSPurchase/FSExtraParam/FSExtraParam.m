//
//  FSExtraParam.m
//  FSPurchase
//
//  Created by Charles on 2017/11/2.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSExtraParam.h"

@implementation FSExtraParam
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        [self setRoomId:[aDecoder decodeObjectForKey:@"roomId"]];
        [self setCoupon_code:[aDecoder decodeObjectForKey:@"coupon_code"]];

    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.roomId forKey:@"roomId"];
    [aCoder encodeObject:self.coupon_code forKey:@"coupon_code"];
}

- (id)copyWithZone:(NSZone *)zone {
    FSExtraParam *extraParam = [FSExtraParam allocWithZone:zone];
    extraParam.roomId = self.roomId;
    extraParam.coupon_code = self.coupon_code;
    return extraParam;
}
@end
