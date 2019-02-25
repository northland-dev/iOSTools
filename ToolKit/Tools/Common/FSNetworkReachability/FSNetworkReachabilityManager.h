//
//  FSNetworkReachabilityManager.h
//  Ready
//
//  Created by gongruike on 2018/9/4.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSNetworkReachabilityManager : NSObject

+ (instancetype)sharedManager;

- (void)startMonitoring;

- (void)stopMonitoring;

- (BOOL)isReachable;

@end
