//
//  NSDictionary+Query.m
//  Ready
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "NSDictionary+Query.h"

@implementation NSString (QueryCombine)

- (NSString *)combineWithValue:(NSString *)value{
    return [NSString stringWithFormat:@"%@=%@",[self isEqualToString:@"_id"] ? @"id" : self, value];
}

@end

@implementation NSArray (Query)

- (NSString *)gc_queryWithKey:(NSString *)key {
    // key:[1,2]     to    key=1&key=2;
    NSMutableArray *tempArray = [NSMutableArray array];
    if (self.count == 0) {
        return @"";
    }
    for (NSString *value in self) {
        [tempArray addObject:[key combineWithValue:value]];
    }
    NSString *final = [tempArray componentsJoinedByString:@"&"];
    return final;
}

@end

@implementation NSDictionary (Query)

- (NSString *)gc_query {
    // {a:1,b:2}     to    a=1&b=2;
    NSMutableArray *tempArray = [NSMutableArray array];
    NSArray *keys = [self allKeys];
    if (keys.count == 0) {
        return @"";
    }
    for (NSString *key in keys) {
        NSString *value = [self valueForKey:key];
        if ([value isKindOfClass:NSArray.class]) {
            [tempArray addObject:[((NSArray *)value) gc_queryWithKey:key]];
        }else{
            [tempArray addObject:[key combineWithValue:value]];
        }
    }
    NSString *final = [tempArray componentsJoinedByString:@"&"];
    return final;
}



- (NSDictionary *)gc_dictWithQuery:(NSString *)query {
    if (!query) {
        return nil;
    }
    NSArray *keyValues = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
    for (NSString *keyValue in keyValues) {
        NSArray *kvArray = [keyValue componentsSeparatedByString:@"="];
        [tempDict setValue:kvArray.lastObject forKey:kvArray.firstObject];
    }
    return tempDict;
}
@end
