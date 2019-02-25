//
//  FSReportFile.m
//  Ready
//
//  Created by jiapeng on 2018/10/11.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSReportFile.h"

@implementation FSReportFile

+ (void)saveConfigInfo:(NSString *)reportUserId {
    
    if (!reportUserId) return;
    
    NSMutableArray *allArray =[self ConfigInfo];
    
    NSMutableArray *saveArray =[[NSMutableArray alloc] initWithCapacity:0];
    [saveArray addObjectsFromArray:allArray];
    [saveArray addObject:reportUserId];
    
    [NSKeyedArchiver archiveRootObject:saveArray toFile:FSReportFilepath];
}

+ (NSMutableArray *)ConfigInfo {
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:FSReportFilepath];
}

+ (void)removeConfigInfo {
    
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:FSReportFilepath];
    if (blHave) {
        [[NSFileManager defaultManager] removeItemAtPath:FSReportFilepath error:nil];
    }
}

+ (BOOL)isConfigInfo {
    
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:FSReportFilepath];
    if (!fileExist) {
        return NO;
    }
    
    BOOL mflage;
    NSMutableArray *saveArray =[FSReportFile ConfigInfo];
    if (saveArray.count !=0) {
        mflage =YES;
    }else{
        mflage=NO;
    }
    return mflage;
}


@end
