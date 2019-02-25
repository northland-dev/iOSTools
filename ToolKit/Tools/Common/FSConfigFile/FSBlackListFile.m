//
//  FSBlackListFile.m
//  Ready
//
//  Created by jiapeng on 2018/10/11.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSBlackListFile.h"

@implementation FSBlackListFile

+ (void)saveConfigInfo:(NSString *)reportUserId {
    
    if (!reportUserId) return;
    
    NSMutableArray *allArray =[self ConfigInfo];
    
    NSMutableArray *saveArray =[[NSMutableArray alloc] initWithCapacity:0];
    [saveArray addObjectsFromArray:allArray];
    [saveArray addObject:reportUserId];
    
    [NSKeyedArchiver archiveRootObject:saveArray toFile:FSBlackListFilepath];
}

+ (NSMutableArray *)ConfigInfo {
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:FSBlackListFilepath];
}

+ (void)removeConfigInfo {
    
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:FSBlackListFilepath];
    if (blHave) {
        [[NSFileManager defaultManager] removeItemAtPath:FSBlackListFilepath error:nil];
    }
}

+ (BOOL)isConfigInfo {
    
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:FSBlackListFilepath];
    if (!fileExist) {
        return NO;
    }
    
    BOOL mflage;
    NSMutableArray *saveArray =[FSBlackListFile ConfigInfo];
    if (saveArray.count !=0) {
        mflage =YES;
    }else{
        mflage=NO;
    }
    return mflage;
}

@end
