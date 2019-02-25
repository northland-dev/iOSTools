//
//  FSJsonInfoDB.h
//  Ready
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <LKDBHelper/LKDBHelper.h>

@interface FSJsonInfoDB : LKDBHelper
+(FSJsonInfoDB *)getUsedDBHelper;

+ (void)clearTableData:(Class)modelClass;
@end
