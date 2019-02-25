//
//  FSPlistManager.m
//  7nujoom
//
//  Created by 王明 on 16/9/6.
//  Copyright © 2016年 Fission. All rights reserved.
//

#import "FSPlistManager.h"
#import "MJExtension.h"

@implementation FSPlistManager
+ (void)clearPlist:(NSString *)fileName
{
    
}
+ (id )readPlistDataWithFileName:(NSString *)fileName {
//    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //还要指定存储文件的文件名称,仍然使用字符串拼接
    if ([self isFileExistAtBundle:fileName]) {
        NSString *filePath = [self getFilePathAtBundle:fileName];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        if(dict != nil)
            return dict;
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        if(array!= nil)
            return array;

    }
    else {
        NSString *filePath = [self getFilePathAtDocument:fileName];
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        if(array!= nil)
            return array;
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        if(dict != nil)
            return dict;
    }
    return nil;
}

+ (BOOL )saveToPlistFileWithData:(id )dataDic fileName:(NSString *)fileName {
    //NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //还要指定存储文件的文件名称,仍然使用字符串拼接
    NSString *filePath = nil;
    
    NSString *bundlePath = [self getFilePathAtBundle:fileName];

    if ([self isFileExistAtBundle:bundlePath]) {
        filePath = bundlePath;
    }
    else {
        filePath = [self getFilePathAtDocument:fileName];
    }
    
    //将数组存储到文件中
    NSDictionary *dict = @{@"code":@"0",@"dataInfo":@{},@"a":@"1"};
   BOOL saved = [dict writeToFile:filePath atomically:YES];
    
   return saved;
}

+(void)saveToPlistFileWithModel:(id)object{
    NSDictionary *dic = [self dictWithModel:object];
    [self saveToPlistFileWithData:dic fileName:NSStringFromClass([object class])];
}

+ (NSArray *)saveToPlistFileWithModels:(NSArray *)objects{
    
    NSMutableArray *dictArray = [NSMutableArray array];
    
    for (id object in objects) {
        if ([object isKindOfClass:[NSDictionary class]]) {
            [dictArray addObject:object];
        }else{
            [dictArray addObject:[FSPlistManager dictWithModel:object]];
        }
    }
    
    return dictArray;
}
+ (void)clearPlistWithClass:(Class )className fileName:(NSString *)filename
{
    NSFileManager *fileMger = [NSFileManager defaultManager];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:NSStringFromClass(className) ofType:@"plist"];
    
    //如果文件路径存在的话
    BOOL bRet = [fileMger fileExistsAtPath:filePath];
    
    if (bRet) {
        
        NSError *err;
        
        [fileMger removeItemAtPath:filePath error:&err];
    }

}
+ (BOOL)writeToPlistDictOrArray:(id)dictOrArray fileName:(NSString *)filename
{
    BOOL saved = NO;
    
    if([dictOrArray isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = [FSPlistManager saveToPlistFileWithModelKeyValues:dictOrArray];
        saved = [FSPlistManager saveToPlistFileWithData:dict fileName:filename];
    }
    
    if([dictOrArray isKindOfClass:[NSArray class]]){
        NSArray* willSaveArray = [FSPlistManager saveToPlistFileWithModels:dictOrArray];
        saved = [FSPlistManager saveToPlistFileWithData:willSaveArray fileName:filename];
    }
    
    return saved;
}

+ (NSDictionary *)saveToPlistFileWithModelKeyValues:(NSDictionary *)objectKeyValues
{
    return objectKeyValues;
}
+ (id)readPlistWithClass:(Class )className fileName:(NSString *)filename
{
    NSString *plistName = nil;
    if ([filename hasSuffix:@".plist"])
        plistName = filename;
    else
        plistName = [filename stringByAppendingString:@".plist"];
    
    id data = [self readPlistDataWithFileName:plistName];
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        return [className mj_objectWithKeyValues:data];
    }
    
    if ([data isKindOfClass:[NSArray class]]) {
        return [className mj_objectArrayWithKeyValuesArray:data];
    }

    return nil;
}
+ (NSDictionary *)dictWithModel:(id)object
{
    NSDictionary *dict = [object mj_keyValues];
    return dict;
}
+ (BOOL)isFileExistAtBundle:(NSString *)filePath {
    NSFileManager *fileMger = [NSFileManager defaultManager];
    
    
    //如果文件路径存在的话
    BOOL bRet = [fileMger fileExistsAtPath:filePath];
    if (bRet) {
        return YES;
    }

    return NO;
}

+ (BOOL)isFileExistAtDocument:(NSString *)fileName {
    NSFileManager *fileMger = [NSFileManager defaultManager];
    
    NSString *filePath = [self getFilePathAtDocument:fileName];
    
    //如果文件路径存在的话
    BOOL bRet = [fileMger fileExistsAtPath:filePath];
    if (bRet) {
        return YES;
    }

    return NO;
}

+ (NSString *)getFilePathAtBundle:(NSString *)fileName {
    
    NSString *filePath = nil;
    if([fileName hasSuffix:@".plist"])
        filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    else
        filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@".plist"];;
    
    return filePath;
}

+ (NSString *)getFilePathAtDocument:(NSString *)fileName {
    
    NSString *filePath = nil;
    
    if([fileName hasSuffix:@".plist"])
        filePath = fileName;
    else
        filePath = [NSString stringWithFormat:@"%@.plist",fileName];
    
    NSString *allPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:filePath];
    
    return allPath;
}



@end
