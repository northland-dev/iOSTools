//
//  FSConfigAPI.m
//  Lolly
//
//  Created by jiapeng on 2017/11/7.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSConfigAPI.h"

@implementation FSConfigAPI

- (void)requestWithParam:(FSConfigParam *)param{
    
    NSString *urlString =[NSString stringWithFormat:@"%@%@",APIAdressConFig,APIConFig];
    
    FSBaseAPI *baseAPI =[[FSBaseAPI alloc] init];
    baseAPI.delegate = self;
    [baseAPI getWithURL:urlString param:param result:[FSConfigResult class]];
}

#pragma mark - FSBaseAPIDelegate
- (void)baseAPISuccess:(FSBaseResult *)result {
    if ([self.delegate respondsToSelector:@selector(FSConfigAPISuccess:)]) {
        [self.delegate FSConfigAPISuccess:(FSConfigResult *)result];
    }
}

- (void)baseAPIFailed:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(FSConfigAPIFailed:)]) {
        [self.delegate FSConfigAPIFailed:error];
    }
}

- (void)baseAPIFailedWithCode:(NSInteger)code {
    if ([self.delegate respondsToSelector:@selector(FSConfigAPICode:)]) {
        [self.delegate FSConfigAPICode:code];
    }
}

@end
