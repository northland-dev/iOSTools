//
//  FSUploadImageServer.m
//  FSVideoEditor
//
//  Created by 王明 on 2017/7/20.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSUploadImageServer.h"
#import "FSUploadImageAPI.h"
#import "FSUploadThumbAPI.h"

@interface FSUploadImageServer()<FSUploadImageAPIDelegate>

@property (nonatomic, strong) FSUploadImageAPI *uploadAPI;
@property (nonatomic, strong) FSUploadThumbAPI *uploadThumbAPI;

@end

@implementation FSUploadImageServer

- (void)uploadFirstImage:(id)param {
    if (!_uploadAPI) {
        _uploadAPI = [[FSUploadImageAPI alloc] init];
        _uploadAPI.delegate = self;
    }
    
    [_uploadAPI uploadFirstImage:param];
}

#pragma mark - FSUploadImageAPIDelegate
- (void)FSUploadImageAPIFaild:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(FSUploadImageServerFailed:)]) {
        [self.delegate FSUploadImageServerFailed:error];
    }
}

- (void)FSUploadImageAPISuccess:(NSString *)filePath {
    if ([self.delegate respondsToSelector:@selector(FSUploadImageServerSucceed:)]) {
        [self.delegate FSUploadImageServerSucceed:filePath];
    }
}

- (void)FSUploadImageAPIProgress:(float)progress {
    if ([self.delegate respondsToSelector:@selector(FSUploadImageServerProgress:)]) {
        [self.delegate FSUploadImageServerProgress:progress];
    }
}

@end
