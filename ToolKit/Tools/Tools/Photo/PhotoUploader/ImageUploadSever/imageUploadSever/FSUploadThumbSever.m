//
//  FSUploadThumbSever.m
//  Lolly
//
//  Created by Charles on 2017/11/6.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSUploadThumbSever.h"
#import "FSUploadThumbAPI.h"

@interface FSUploadThumbSever()<FSUploadThumbAPIAPIDelegate>

@property (nonatomic, strong) FSUploadThumbAPI *uploadThumbAPI;

@end
@implementation FSUploadThumbSever

- (void)uploadThumbImage:(id)param {
    if (!_uploadThumbAPI) {
        _uploadThumbAPI = [[FSUploadThumbAPI alloc] init];
        _uploadThumbAPI.delegate = self;
    }
    [_uploadThumbAPI uploadThumbImage:param];
}

#pragma mark - FSUploadImageAPIDelegate
- (void)FSUploadThumbAPIFaild:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(FSUploadThumbSeverFailed:)]) {
        [self.delegate FSUploadThumbSeverFailed:error];
    }
}

- (void)FSUploadThumbAPISuccess:(NSString *)filePath {
    if ([self.delegate respondsToSelector:@selector(FSUploadThumbSeverSucceed:)]) {
        [self.delegate FSUploadThumbSeverSucceed:filePath];
    }
}

- (void)FSUploadThumbAPIProgress:(float)progress {
    if ([self.delegate respondsToSelector:@selector(FSUploadThumbSeverProgress:)]) {
        [self.delegate FSUploadThumbSeverProgress:progress];
    }
}
@end
