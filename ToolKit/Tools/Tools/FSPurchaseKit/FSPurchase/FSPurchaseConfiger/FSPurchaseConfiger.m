//
//  FSPurchaseConfiger.m
//  FSPurchase
//
//  Created by Charles on 2017/10/27.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSPurchaseConfiger.h"

@interface FSPurchaseConfiger()
{
    NSTimeInterval _checkInterval;
    NSTimeInterval _immediatelyCheckInterval;
}
@end

@implementation FSPurchaseConfiger
static id configer;
- (NSTimeInterval)localCheckInterval {
    return _checkInterval;
}
- (void)setLocalCheckInterval:(NSTimeInterval)localCheckInterval {
    _checkInterval = localCheckInterval;
}
- (NSTimeInterval)immediatelyCheckInterval {
    return _immediatelyCheckInterval;
}
- (void)setImmediatelyCheckInterval:(NSTimeInterval)immediatelyCheckInterval {
    _immediatelyCheckInterval = immediatelyCheckInterval;
}

#pragma mark - init
+ (instancetype)sharedConfiger {
    return [[FSPurchaseConfiger alloc] init];
}
- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((configer = [super init]) != nil) {
            _checkInterval = 300.0;
            _immediatelyCheckInterval = 60.0;
        }
    });
    self = configer;
    return self;
}
+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configer = [super allocWithZone:zone];
    });
    return configer;
}
+ (id)copyWithZone:(struct _NSZone *)zone {
    return configer;
}
@end
