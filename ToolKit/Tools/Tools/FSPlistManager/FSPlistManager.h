//
//  FSPlistManager.h
//  7nujoom
//
//  Created by 王明 on 16/9/6.
//  Copyright © 2016年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSPlistManager : NSObject

+ (NSDictionary *)readPlistDataWithFileName:(NSString *)fileName;
+ (void)clearPlist:(NSString *)fileName;
+ (BOOL)writeToPlistDictOrArray:(id)dictOrArray fileName:(NSString *)filename;


+ (void)saveToPlistFileWithModel:(id)object;


+ (void)clearPlistWithClass:(Class )className fileName:(NSString *)filename;
+ (id)readPlistWithClass:(Class )className fileName:(NSString *)filename;


+ (NSArray *)saveToPlistFileWithModels:(NSArray *)objects;
+ (NSDictionary *)saveToPlistFileWithModelKeyValues:(NSDictionary *)objectKeyValues;
@end
