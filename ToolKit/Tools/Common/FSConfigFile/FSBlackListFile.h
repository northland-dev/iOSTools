//
//  FSBlackListFile.h
//  Ready
//
//  Created by jiapeng on 2018/10/11.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSBlackListFile : NSObject
// 存储信息
+ (void)saveConfigInfo:(NSString *)reportUserId;

// 读取信息
+ (NSMutableArray *)ConfigInfo;

// 删除信息
+ (void)removeConfigInfo;

// 检查是有数据
+ (BOOL)isConfigInfo;

@end
