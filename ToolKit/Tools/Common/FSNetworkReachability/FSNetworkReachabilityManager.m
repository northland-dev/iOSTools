//
//  FSNetworkReachabilityManager.m
//  Ready
//
//  Created by gongruike on 2018/9/4.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSNetworkReachabilityManager.h"

@interface FSNetworkReachabilityManager()

@property (nonatomic, strong) AFNetworkReachabilityManager  *afReachabilityManager;

@end

@implementation FSNetworkReachabilityManager

+ (instancetype)sharedManager {
    static FSNetworkReachabilityManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FSNetworkReachabilityManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.afReachabilityManager = [AFNetworkReachabilityManager managerForDomain:@"www.baidu.com"];
    }
    return self;
}

#pragma mark -
- (void)startMonitoring {
    [self.afReachabilityManager startMonitoring];
}

- (void)stopMonitoring {
    [self.afReachabilityManager stopMonitoring];
}

- (BOOL)isReachable {
    return self.afReachabilityManager.reachable;
}

@end
