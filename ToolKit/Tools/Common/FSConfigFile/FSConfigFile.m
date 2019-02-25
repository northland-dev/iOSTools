//
//  FSConfigFile.m
//  Lolly
//
//  Created by jiapeng on 2017/11/8.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSConfigFile.h"



@implementation FSConfigFile

+ (void)saveConfigInfo:(NSDictionary *)Info {
    
    if (!Info) return;
    
    [NSKeyedArchiver archiveRootObject:Info toFile:FSConfigInfoFilepath];
}

+ (NSDictionary *)ConfigInfo {
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:FSConfigInfoFilepath];
}

+ (void)removeConfigInfo {
    
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:FSConfigInfoFilepath];
    if (blHave) {
        [[NSFileManager defaultManager] removeItemAtPath:FSConfigInfoFilepath error:nil];
    }
}

+ (BOOL)isConfigInfo {
    
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:FSConfigInfoFilepath];
    if (!fileExist) {
        return NO;
    }
    
    BOOL mflage;
    NSDictionary *tempDict =[FSConfigFile ConfigInfo];
    if (tempDict.allKeys.count !=0) {
        mflage =YES;
    }else{
        mflage=NO;
    }
    return mflage;
}


@end
