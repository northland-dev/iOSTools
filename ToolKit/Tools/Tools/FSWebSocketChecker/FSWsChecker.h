//
//  FSWsChecker.h
//  Ready
//
//  Created by mac on 2018/12/12.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSWsChecker : NSObject
+ (instancetype)sharedChecker;
- (void)checkWsPath:(NSString *)filePath;
@end

NS_ASSUME_NONNULL_END
