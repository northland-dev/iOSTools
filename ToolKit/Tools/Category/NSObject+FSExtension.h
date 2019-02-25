//
//  NSObject+FSExtension.h
//  Lolly
//
//  Created by stu on 2017/11/6.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

@interface NSObject (FSExtension)

/**
 *  通过字典来创建一个模型
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @return 新建的对象
 */
+ (instancetype)fs_objectWithKeyValues:(id)keyValues;

/**
 *  将字典的键值对转成模型属性
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 */
- (instancetype)fs_setKeyValues:(id)keyValues;

#pragma mark - 转换为JSON
/**
 *  转换为JSON Data
 */
- (NSData *)fs_JSONData;

#pragma mark - 字典数组转模型数组
/**
 *  通过字典数组来创建一个模型数组
 *  @param keyValuesArray 字典数组(可以是NSDictionary、NSData、NSString)
 *  @return 模型数组
 */
+ (NSMutableArray *)fs_objectArrayWithKeyValuesArray:(id)keyValuesArray;



@end
