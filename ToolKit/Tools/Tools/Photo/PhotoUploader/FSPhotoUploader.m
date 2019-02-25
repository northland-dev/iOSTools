//
//  FSPhotoUploader.m
//  Lolly
//
//  Created by Charles on 2017/11/5.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSPhotoUploader.h"
#import "FSImageUploader.h"

@interface FSPhotoUploader()<FSImageUploaderDelegate>
@property(nonatomic,strong)UploadSucccess success;
@property(nonatomic,strong)UploadFaild faild;
@property(nonatomic,strong)FSImageUploader *imageUploader;
@end
@implementation FSPhotoUploader
+ (instancetype)defaultUploader {
    return [[FSPhotoUploader alloc] init];
}
- (void)photoUploader:(UIImage *)sourceImage
           thumbImage:(UIImage *)thumbImage
         successBlock:(UploadSucccess)success
           faildBlock:(UploadFaild)faild {
    self.success = success;
    self.faild = faild;
    dispatch_async(dispatch_queue_create("fission.imageRead.queue", 0), ^{
        
        NSData *sourceData = UIImagePNGRepresentation(sourceImage);
        CGFloat length = [sourceData length]/1024; // 200k
        CGFloat bit = 1.0;
        if (length > 2000) {
            bit = 2000/length;
        }
        NSData *zipedSourceData = UIImageJPEGRepresentation(sourceImage, bit);
        // uploadImage
        //
        NSData *thumbData = UIImagePNGRepresentation(thumbImage);
        CGFloat thumbLength = [thumbData length]/1024; // 200k
        CGFloat thumbbit = 1.0;
        if (thumbLength > 2000) {
            thumbbit = 2000/thumbLength;
        }
        NSData *zipedthumbData = UIImageJPEGRepresentation(thumbImage, thumbbit);
        
        FSImageUploaderParam *param =  [FSImageUploaderParam new];
        param.sourceImageData = zipedSourceData;
        param.thumbImageData = zipedthumbData;
        
         self.imageUploader = [[FSImageUploader alloc] init];
        [self.imageUploader setDelegate:self];
        [self.imageUploader uploadImage:param];
    });
}
-(void)releaseObj {
    [self.imageUploader setDelegate:nil];
}
#pragma mark -
-(void)imageUploaderProgress:(CGFloat)progress {
    
}

-(void)imageUploaderSuccess:(NSString *)sourceUrl thumbUrl:(NSString *)thumUrl {
    if (self.success) {
        self.success(sourceUrl, thumUrl,self);
    }
}
-(void)imageUploaderFaild {
    if (self.faild) {
        self.faild(nil, nil, nil);
    }
}
@end
