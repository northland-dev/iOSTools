//
//  FSJsonInfoDB.m
//  Ready
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSJsonInfoDB.h"

@implementation FSJsonInfoDB
+(FSJsonInfoDB *)getUsedDBHelper
{
    static FSJsonInfoDB* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        db = [[FSJsonInfoDB alloc]init];
    });
    return db;
}

+ (void)clearTableData:(Class)modelClass{
    [super clearTableData:modelClass];
}
@end
