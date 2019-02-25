//
//  NSString+GamePath.h
//  Lolly
//
//  Created by stu on 2017/11/14.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GamePath)

- (NSString *)toZipPath;
- (NSString *)toWebPath;
- (NSString *)toGameFolderName;
- (NSString *)toGameVersionName;
- (NSString *)toGameVersionFloderPath;
- (BOOL)versionMatch;
- (BOOL)creatPath;

- (NSString *)toGameConfig_dataPath;

@end
