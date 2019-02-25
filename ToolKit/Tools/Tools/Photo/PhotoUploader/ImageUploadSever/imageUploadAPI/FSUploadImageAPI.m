//
//  FSUploadImageAPI.m
//  FSVideoEditor
//
//  Created by 王明 on 2017/7/20.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSUploadImageAPI.h"
#import <AFNetworking/AFNetworking.h>
#import "FSBaseTokenParam.h"
#import "NSDictionary+FSSafeAccess.h"


@interface FSUploadImageAPI()
{
    NSURLSessionTask *_currentTask;
    
    NSURLSessionUploadTask *_uploadTask;

}

@end

@implementation FSUploadImageAPI

- (void)uploadFirstImage:(id)param {
    if (_currentTask) {
        [_currentTask suspend];
        [_currentTask cancel];
    }
    
    NSData * imageData = [param objectForKey:@"imageData"];
    NSString *imageName = [param objectForKey:@"imageName"];
    
    WS(weakS);
    
    NSString *urlString = [NSString stringWithFormat:@"%@?",[[FSGlobalLauncher launcher].allKeyDict stringForKey:KeyPhoto_update]];
    FSBaseTokenParam *tokenParam = [[FSBaseTokenParam alloc] init];
    NSString *query = [tokenParam fs_queryString];
    urlString = [urlString stringByAppendingString:query];
    
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc] init];
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 120.f;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [mgr.requestSerializer setValue:@"1" forHTTPHeaderField:@"user_pic_index"];
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setValue:[NSNumber numberWithInteger:4] forKey:@"requestType"];
    NSURLSessionTask *task = (NSURLSessionUploadTask *)[mgr  POST:urlString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"user_pic" fileName:imageName mimeType:@"image/*"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if ([weakS.delegate respondsToSelector:@selector(FSUploadImageAPIProgress:)]) {
            [weakS.delegate FSUploadImageAPIProgress:uploadProgress.completedUnitCount];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        int code = [[responseObject objectForKey:@"code"] intValue];
        if (code == 0) {
            if ([weakS.delegate respondsToSelector:@selector(FSUploadImageAPISuccess:)]) {
                [weakS.delegate FSUploadImageAPISuccess:[responseObject objectForKey:@"dataInfo"]];
            }
        }
        else {
            if ([weakS.delegate respondsToSelector:@selector(FSUploadImageAPIFaild:)]) {
                [weakS.delegate FSUploadImageAPIFaild:nil];
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([weakS.delegate respondsToSelector:@selector(FSUploadImageAPIFaild:)]) {
            [weakS.delegate FSUploadImageAPIFaild:error];
        }
    }];
    
    [task resume];
    _currentTask = task;
}
@end
