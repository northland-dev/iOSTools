//
//  FSimageUploader.m
//  FSVideoEditor
//
//  Created by Charles on 2017/9/8.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSImageUploader.h"
#import "FSUploadImageServer.h"
#import "FSUploadThumbSever.h"


@implementation FSImageUploaderParam

@end


@interface FSImageUploader()<FSUploadImageServerDelegate,FSUploadThumbSeverDelegate>
{
    dispatch_group_t _group;
    dispatch_queue_t _uploadImageQueue;
    dispatch_queue_t _uploadThumbQueue;
    
    FSUploadImageServer *_uploadImageSever;
    FSUploadThumbSever  *_uploadThumbSever;
    
    long long _totalFileSize;
}

@property(nonatomic,strong)FSImageUploaderParam *currentParam;
@property(nonatomic, assign) long long totalUploadSize;
@property(nonatomic,strong)NSString *sourceImageUrl;
@property(nonatomic,strong)NSString *thumbImageUrl;

@end

@implementation FSImageUploader
+ (instancetype)sharedPublisher {
    return [[FSImageUploader alloc] init];
}
- (instancetype)init {
    if ((self = [super init]) != nil) {
        _group = dispatch_group_create();
        _uploadImageQueue = dispatch_queue_create("fission.sourceImage.upload", 0);
        _uploadThumbQueue = dispatch_queue_create("fission.thumbImage.upload", 0);
        _uploadImageSever = [[FSUploadImageServer alloc] init];
        [_uploadImageSever setDelegate:self];
        
        _uploadThumbSever = [[FSUploadThumbSever alloc] init];
        [_uploadThumbSever setDelegate:self];
    }
    return self;
}

- (long long)totalUploadSize {
    return _totalFileSize;
}

// 发布 文件
-(void)uploadImage:(FSImageUploaderParam *)param {

    self.currentParam = param;
//    _totalFileSize = 0;
    __weak  typeof(_uploadImageSever) weakSever = _uploadImageSever;
    __weak  typeof(_uploadThumbSever) weakthumbSever = _uploadThumbSever;
    WS(weakS);

    if (param.thumbImageData != nil) {
//        _totalFileSize += param.thumbImageData.length/1024.0;
        //
        self.thumbImageUrl = nil;
        dispatch_group_enter(_group);
        dispatch_group_async(_group, _uploadThumbQueue, ^{
            NSString *imageName = @"thumbName.png";
            [weakthumbSever uploadThumbImage:[NSDictionary dictionaryWithObjectsAndKeys:param.thumbImageData,@"imageData",imageName,@"imageName",nil]];
        });
        
    }else{
        self.thumbImageUrl = @"";
    }
    
    dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
        if (!weakS.thumbImageUrl) {
                // 发布失败
            weakS.currentParam = nil;

            if ([weakS.delegate respondsToSelector:@selector(imageUploaderFaild)]) {
                [weakS.delegate imageUploaderFaild];
            }
        }else{
            if ([weakS.delegate respondsToSelector:@selector(imageUploaderSuccess:thumbUrl:)]) {
                [weakS.delegate imageUploaderSuccess:weakS.sourceImageUrl thumbUrl:weakS.thumbImageUrl];
            }
        }
    });
    

    if (!param.thumbImageData) {
        // 发布失败
        weakS.currentParam = nil;
        //
        if (![[NSThread currentThread] isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([weakS.delegate respondsToSelector:@selector(imageUploaderFaild)]) {
                    [weakS.delegate imageUploaderFaild];
                }
            });
        }else{
            if ([weakS.delegate respondsToSelector:@selector(imageUploaderFaild)]) {
                [weakS.delegate imageUploaderFaild];
            }
        }
    }
}

#pragma mark -
- (void)FSUploadImageServerSucceed:(NSString *)filePath {
    self.sourceImageUrl = filePath;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if ([self.delegate respondsToSelector:@selector(imageUploaderProgress:)]) {
//            [self.delegate imageUploaderProgress:(((double)self.totalUploadSize/(double)_totalFileSize) * 100.0)/100.0];
//        }
//    });
    dispatch_group_leave(_group);
}

- (void)FSUploadImageServerFailed:(NSError *)error {
    dispatch_group_leave(_group);
}
- (void)FSUploadImageServerProgress:(float)progess {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if ([self.delegate respondsToSelector:@selector(imageUploaderProgress:)]) {
//            [self.delegate imageUploaderProgress:(((double)self.totalUploadSize/(double)_totalFileSize) * 100.0)/100.0];
//        }
//    });
}

#pragma mark -
- (void)FSUploadThumbSeverSucceed:(NSString *)filePath {
    self.thumbImageUrl = filePath;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if ([self.delegate respondsToSelector:@selector(imageUploaderProgress:)]) {
//            [self.delegate imageUploaderProgress:(((double)self.totalUploadSize/(double)_totalFileSize) * 100.0)/100.0];
//        }
//    });
    dispatch_group_leave(_group);
}

- (void)FSUploadThumbSeverFailed:(NSError *)error {
    dispatch_group_leave(_group);
}
- (void)FSUploadThumbSeverProgress:(float)progess {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if ([self.delegate respondsToSelector:@selector(imageUploaderProgress:)]) {
//            [self.delegate imageUploaderProgress:(((double)self.totalUploadSize/(double)_totalFileSize) * 100.0)/100.0];
//        }
//    });
}
- (void)dealloc {
    NSLog(@"%@ %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}
@end
