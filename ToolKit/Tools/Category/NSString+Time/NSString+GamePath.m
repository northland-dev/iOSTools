//
//  NSString+Time.m
//  Lolly
//
//  Created by stu on 2017/11/14.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "NSString+GamePath.h"

@implementation NSString (GamePath)

- (NSString *)toZipPath{
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSString *zipPath = ZIPPath;
    if (![defaultManager fileExistsAtPath:zipPath]) {
        BOOL success = [defaultManager createDirectoryAtPath:zipPath withIntermediateDirectories:NO attributes:nil error:nil];
        if (success) {
            NSLog(@"zip文件夹创建成功 %@",zipPath);
        }
    }
    zipPath = [NSString stringWithFormat:@"%@/%@.zip", zipPath, [self toFileName]];
    return zipPath;
}

- (NSString *)toFileName{
    NSString *file_and_Type_Name = [self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]].lastObject;
    NSString *fileName = [file_and_Type_Name substringWithRange:NSMakeRange(0, file_and_Type_Name.length >= 4?file_and_Type_Name.length - 4:0)];
    return fileName;
}

- (BOOL)creatPath{
    BOOL success = NO;
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    success = [defaultManager fileExistsAtPath:self];
    if (!success) {
        success = [defaultManager createDirectoryAtPath:self withIntermediateDirectories:NO attributes:nil error:nil];
        if (success) {
            NSLog(@"web文件夹创建成功 %@",self);
        }
    }
    return success;
}

- (NSString *)toWebPath{
    NSString *folderName = [self toGameFolderName];
    NSString *gamePath = [NSString stringWithFormat:@"%@/%@/", WEBPath, folderName];
    NSLog(@"\ntoWebPath : %@", gamePath);
    return gamePath;
}
- (NSString *)toGameConfig_dataPath{
    NSString *assetPath = [self toGameAssetDataPath];
    NSString *config = [assetPath stringByAppendingPathComponent:@"config_data.json"];
    return config;
}
- (NSString *)toGameAssetDataPath {
    NSString *resource = [self toGameResousePath];
    NSString *assetData = [resource stringByAppendingPathComponent:@"assets/data"];
    return assetData;
}
- (NSString *)toGameResousePath{
    NSString *gameVersionPath = [self toGameVersionFloderPath];
    NSString *resource = [gameVersionPath stringByAppendingPathComponent:@"resource"];
    return resource;
}
- (NSString *)toGameFolderName{
    NSString *folderName = [[self toFileName] componentsSeparatedByString:@"_"].firstObject;
    NSLog(@"\ntoGameFolderName : %@", folderName);
    return folderName;
}

- (NSString *)toGameVersionName{
    NSString *versionName = [[self toFileName] componentsSeparatedByString:@"_"].lastObject;
    NSLog(@"\ntoGameVersionName : %@", versionName);
    return versionName;
}

- (NSString *)toGameVersionFloderPath{
    NSString *gamePath = self.toWebPath;
    NSString *gameVersion = self.toGameVersionName;
    NSString *gameVersionFolderPath = [NSString stringWithFormat:@"%@%@/", gamePath, gameVersion];
    NSLog(@"\ntoGameVersionFloderPath : %@", gameVersionFolderPath);
    return gameVersionFolderPath;
}

- (BOOL)versionMatch{   // 游戏版本控制
    BOOL match = NO;
    
    NSString *gamePath = self.toWebPath;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:gamePath]) {
        NSLog(@"\n游戏路径：\n%@\n存在", gamePath);
        NSString *gameVersionPath = self.toGameVersionFloderPath;
        if ([fileManager fileExistsAtPath:gameVersionPath]) {
            NSLog(@"\n版本路径：\n%@\n存在", gameVersionPath);
            match = YES;
        }else{
            NSLog(@"\n版本路径：\n%@\n不存在", gameVersionPath);
            if ([fileManager removeItemAtPath:gamePath error:NULL]) {
                NSLog(@"\n\nOld version game removed successfully\n");
            }else{
                NSLog(@"\n\nOld version game removed failed\n");
            }
        }
    }else{
        NSLog(@"\n游戏路径：\n%@\n不存在", gamePath);
    }
    
    return match;
}

@end
