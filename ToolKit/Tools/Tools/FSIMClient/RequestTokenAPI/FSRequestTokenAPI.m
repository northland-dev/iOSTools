//
//  FSRequestTokenAPI.m
//  Lolly
//
//  Created by stu on 2017/11/3.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSRequestTokenAPI.h"

@implementation FSRequestTokenAPI

-(void)requestIMToken:(NSString*)url{
    FSBaseTokenParam *param = [[FSBaseTokenParam alloc] init];
    
    FSBaseAPI *baseApi = [[FSBaseAPI alloc] init];
    baseApi.delegate = self;
    [baseApi getWithURL:url param:param result:[FSRequestTokenResult class]];
}

#pragma mark - FSBaseAPIDelegate
- (void)baseAPISuccess:(FSBaseResult *)result {
    if ([self.delegate respondsToSelector:@selector(fsRequestTokenAPISuccess:)]) {
        [self.delegate fsRequestTokenAPISuccess:(FSRequestTokenResult *)result];
    }
}
- (void)baseAPIFailedWithCode:(NSInteger)code {
    if ([self.delegate respondsToSelector:@selector(fsRequestTokenAPIFailed:)]) {
        [self.delegate fsRequestTokenAPIFailed:nil];
    }
}

- (void)baseAPIFailed:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(fsRequestTokenAPIFailed:)]) {
        [self.delegate fsRequestTokenAPIFailed:error];
    }
}


@end
