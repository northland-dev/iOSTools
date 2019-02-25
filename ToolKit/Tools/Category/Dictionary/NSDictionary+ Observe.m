//
//  NSDictionary+Observe.m
//  Ready
//
//  Created by luyee on 2018/8/24.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "NSDictionary+Observe.h"

@implementation FSObserveObj

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"newly" : @"new"
             };
}

@end

@implementation NSDictionary (Observe)

- (FSObserveObj *)observeObj{
    return [FSObserveObj mj_objectWithKeyValues:self];
}

@end
