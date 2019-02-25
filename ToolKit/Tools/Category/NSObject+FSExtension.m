//
//  NSObject+FSExtension.m
//  Lolly
//
//  Created by stu on 2017/11/6.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "NSObject+FSExtension.h"

@implementation NSObject (FSExtension)

+ (instancetype)fs_objectWithKeyValues:(id)keyValues{
   return  [[self class] mj_objectWithKeyValues:keyValues];
}
+ (NSMutableArray *)fs_objectArrayWithKeyValuesArray:(id)keyValuesArray {
    return [[self class] mj_objectArrayWithKeyValuesArray:keyValuesArray];
}

- (instancetype)fs_setKeyValues:(id)keyValues {
    return  [self mj_setKeyValues:keyValues];
}

- (NSData *)fs_JSONData {
    return [self mj_JSONData];
}




@end
