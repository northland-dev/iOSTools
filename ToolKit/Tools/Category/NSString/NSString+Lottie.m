//
//  NSString+Lottie.m
//  Ready
//
//  Created by mac on 2019/1/15.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import "NSString+Lottie.h"

@implementation NSString (Lottie)
- (void)createFolderWithPath:(NSString *)path{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        NSError *error = nil;
        BOOL success = [manager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
        if (success) {
            NSLog(@"创建文件夹 %@",path);
        }
        if (error) {
            NSLog(@"创建文件夹 %@ ",error);
        }
    }
}
- (NSString *)lot_zipRoot {
    NSArray *folders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = [folders objectAtIndex:0];
    NSString *lot_zipRoot = [document stringByAppendingPathComponent:@"lottie/"];
    [self createFolderWithPath:lot_zipRoot];
    NSString *lot_zipFolder = [lot_zipRoot stringByAppendingPathComponent:@"zip/"];
    [self createFolderWithPath:lot_zipFolder];
    return lot_zipFolder;
}
- (NSString *)lot_unZipRoot {
    NSArray *folders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = [folders objectAtIndex:0];
    NSString *lot_unZip = [document stringByAppendingPathComponent:@"lottie/"];
    [self createFolderWithPath:lot_unZip];
    NSString *lot_unzipFolder = [lot_unZip stringByAppendingPathComponent:@"unZip/"];
    [self createFolderWithPath:lot_unzipFolder];
    return lot_unzipFolder;
}
- (NSString *)lot_ZipFolderWithId:(NSString *)fileId {
    NSString *zipRoot = [self lot_zipRoot];
    NSString *folder = [zipRoot stringByAppendingPathComponent:fileId];
    [self createFolderWithPath:folder];
    return folder;
}
- (NSString *)lot_unZipFolderWithId:(NSString *)fileId{
    NSString *unZipRoot = [self lot_unZipRoot];
    NSString *folder = [unZipRoot stringByAppendingPathComponent:fileId];
    [self createFolderWithPath:folder];
    return folder;
}
- (NSString *)lot_fileName {
    NSString *lastComp = [self lastPathComponent];
    return lastComp;
}
- (NSString *)lot_unZipFilePathWithId:(NSString *)fileId {
    NSString *lot_folder = [self lot_unZipFolderWithId:fileId];
    NSString *folderName = [self lot_fileName];
    NSString *unZipPath = [lot_folder stringByAppendingPathComponent:folderName];
    return unZipPath;
}
- (NSString *)lot_zipFilePathWithId:(NSString *)fileId {
    NSString *lot_folder = [self lot_ZipFolderWithId:fileId];
    NSString *folderName = [self lot_fileName];
    NSString *zipPath = [lot_folder stringByAppendingPathComponent:folderName];
    return zipPath;
}
- (NSString *)lot_filePath {
    return nil;
}
- (NSString *)lot_fileURLWithId:(NSString *)fileId {
    NSString *folderPath = [self lot_unZipFolderWithId:fileId];
   NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:folderPath]) {
        // 存在
        NSArray *subArrays = [manager subpathsAtPath:folderPath];
        NSString *jsonPath = nil;
        for (NSString *path in subArrays) {
            if ([path hasSuffix:@".json"]) {
                NSString *lastComponte = [path lastPathComponent];
                if (![lastComponte hasPrefix:@"."]) {
                    jsonPath = path;
                    break;
                }
            }
        }
        if (jsonPath) {
            return [folderPath stringByAppendingPathComponent:jsonPath];
        }
    }
    return nil;
}
@end
