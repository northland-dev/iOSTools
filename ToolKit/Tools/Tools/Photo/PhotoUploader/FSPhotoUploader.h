//
//  FSPhotoUploader.h
//  Lolly
//
//  Created by Charles on 2017/11/5.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FSPhotoUploader;
typedef void(^UploadSucccess)(NSString *sourceUrl,NSString *thumbUrl,FSPhotoUploader *uploader);
typedef void(^UploadFaild)(NSString *sourceUrl,NSString *thumbUrl,NSError *error);

@interface FSPhotoUploader : NSObject
+ (instancetype)defaultUploader;

- (void)releaseObj;

- (void)photoUploader:(UIImage *)soruceImage
           thumbImage:(UIImage *)thumbImage
         successBlock:(UploadSucccess)success
           faildBlock:(UploadFaild)faild;
@end
