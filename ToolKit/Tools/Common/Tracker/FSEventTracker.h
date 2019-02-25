//
//  FSEventTracker.h
//  Ready
//
//  Created by gongruike on 2018/8/30.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSEventTracker : NSObject

+ (void)trackEvent:(NSString *)eventID;

// object is a json
+ (void)trackEvent:(NSString *)eventID object:(NSDictionary *)object;

@end
