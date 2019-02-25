//
//  AFHTTPRequestSerializer+Query.m
//  Ready
//
//  Created by luyee on 2018/8/28.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "AFHTTPRequestSerializer+Query.h"

@implementation AFHTTPRequestSerializer (Query)

+ (void)load{
    [super load];
    Method sdk_method = class_getInstanceMethod(self.class, @selector(requestBySerializingRequest:withParameters:error:));
    Method ex_method = class_getInstanceMethod(self.class, @selector(ex_requestBySerializingRequest:withParameters:error:));
    method_exchangeImplementations(sdk_method, ex_method);
}

- (NSURLRequest *)ex_requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error{
    NSMutableURLRequest *mutableRequest = [self ex_requestBySerializingRequest:request withParameters:parameters error:error];
    NSString *urlStr = mutableRequest.URL.absoluteString;
    NSArray *urlArr = [urlStr componentsSeparatedByString:@"%26"];
    urlStr = [urlArr componentsJoinedByString:@"&"];
    urlArr = [urlStr componentsSeparatedByString:@"%3D"];
    urlStr = [urlArr componentsJoinedByString:@"="];
    mutableRequest.URL = [NSURL URLWithString:urlStr];
    
    return mutableRequest;
}

@end
