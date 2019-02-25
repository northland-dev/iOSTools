//
//  AFHTTPRequestSerializer+Query.h
//  Ready
//
//  Created by luyee on 2018/8/28.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFHTTPRequestSerializer (Query)

- (NSURLRequest *)ex_requestBySerializingRequest:(NSURLRequest *)request
                                  withParameters:(id)parameters
                                           error:(NSError *__autoreleasing *)error;

@end
