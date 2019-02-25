//
//  NSString+Lottie.h
//  Ready
//
//  Created by mac on 2019/1/15.
//  Copyright © 2019年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 group1/M00/00/D1/Cgogslw9pfWEQ6KBAAAAACioDAE410.zip
 */
@interface NSString (Lottie)
// 根目录
- (NSString *)lot_zipRoot;
- (NSString *)lot_unZipRoot;
// 解压目录
- (NSString *)lot_unZipFolderWithId:(NSString *)fileId;
- (NSString *)lot_ZipFolderWithId:(NSString *)fileId;
// 文件目录
- (NSString *)lot_filePath;
- (NSString *)lot_fileName;
- (NSString *)lot_unZipFilePathWithId:(NSString *)fileId;
- (NSString *)lot_zipFilePathWithId:(NSString *)fileId;
// 文件url
- (NSString *)lot_fileURLWithId:(NSString *)fileId;
@end

NS_ASSUME_NONNULL_END
