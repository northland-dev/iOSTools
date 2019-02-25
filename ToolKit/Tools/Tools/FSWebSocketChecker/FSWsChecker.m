//
//  FSWsChecker.m
//  Ready
//
//  Created by mac on 2018/12/12.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSWsChecker.h"
#import "FSQNLogger.h"
@interface FSWsChecker(){
    dispatch_queue_t _readFileQueue;
}
@end
@implementation FSWsChecker
static FSWsChecker *shareObj = nil;
+ (instancetype)sharedChecker {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareObj = [[FSWsChecker alloc] init];
    });
    return shareObj;
}
- (instancetype)init {
    if (self = [super init]) {
        _readFileQueue = dispatch_queue_create("ready.readfile.queue", 0);
    }
    return self;
}

- (void)checkWsPath:(NSString *)filePath {
    if (!filePath) {
        return;
    }
    dispatch_async(_readFileQueue, ^{
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            return;
        }
        
        NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
        
        NSArray *jsonValue = [jsonData mj_JSONObject];
        
        for (id object in jsonValue) {
            
            NSString *ws_url = [object valueForKeyPath:@"ws_url"];
            if (!ws_url || ![ws_url isKindOfClass:[NSString class]]) {
                return;
            }
            NSURLComponents *components = [NSURLComponents componentsWithString:ws_url];
            if (!components.host) {
                return;
            }
            
            //
            [[FSQNLogger shareLogger] checkUrl:components.host];
        }

    });
}
@end
