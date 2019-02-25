//
//  FSConfigFile.h
//  Lolly
//
//  Created by jiapeng on 2017/11/8.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSConfigFile : NSObject
// 存储信息
+ (void)saveConfigInfo:(NSDictionary *)Info;

// 读取信息
+ (NSDictionary *)ConfigInfo;

// 删除信息
+ (void)removeConfigInfo;

// 检查是有数据
+ (BOOL)isConfigInfo;

@end
