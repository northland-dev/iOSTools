//
//  FSUploadThumbAPI.m
//  Lolly
//
//  Created by Charles on 2017/11/6.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSUploadThumbAPI.h"
#import <AFNetworking/AFNetworking.h>
#import "FSBaseTokenParam.h"
#import "NSDictionary+FSSafeAccess.h"

@interface FSUploadThumbAPI()
{
    NSURLSessionTask *_currentTask;
    
    NSURLSessionUploadTask *_uploadTask;
}
@end
@implementation FSUploadThumbAPI

- (void)uploadThumbImage:(id)param {
    if (_currentTask) {
        [_currentTask suspend];
        [_currentTask cancel];
    }
    
    NSData * imageData = [param objectForKey:@"imageData"];
    NSString *imageName = [param objectForKey:@"imageName"];
    
    WS(weakS);
    
    NSString *urlString =[NSString stringWithFormat:@"%@?",[[FSGlobalLauncher launcher].allKeyDict stringForKey:KeyPhoto_update]];
    FSBaseTokenParam *tokenParam = [[FSBaseTokenParam alloc] init];
    NSString *query = [tokenParam fs_queryString];
    urlString = [urlString stringByAppendingString:query];

    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc] init];
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 30.f;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    //[dic setValue:[NSNumber numberWithInteger:4] forKey:@"requestType"];
    
    [dic setValue:@"1" forKey:@"user_pic_index"];
    
    NSURLSessionTask *task = (NSURLSessionUploadTask *)[mgr  POST:urlString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
      [formData appendPartWithFileData:imageData name:@"user_pic" fileName:imageName mimeType:@"image/*"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if ([weakS.delegate respondsToSelector:@selector(FSUploadThumbAPIProgress:)]) {
            [weakS.delegate FSUploadThumbAPIProgress:uploadProgress.completedUnitCount];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        int code = [[responseObject objectForKey:@"code"] intValue];
        if (code == 0) {
            if ([weakS.delegate respondsToSelector:@selector(FSUploadThumbAPISuccess:)]) {
                [weakS.delegate FSUploadThumbAPISuccess:[responseObject objectForKey:@"dataInfo"]];
            }
        }
        else {
            if ([weakS.delegate respondsToSelector:@selector(FSUploadThumbAPIFaild:)]) {
                [weakS.delegate FSUploadThumbAPIFaild:nil];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([weakS.delegate respondsToSelector:@selector(FSUploadThumbAPIFaild:)]) {
            [weakS.delegate FSUploadThumbAPIFaild:nil];
        }
    }];
    
    [task resume];
    _currentTask = task;
}
@end
