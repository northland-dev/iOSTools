//
//  FSEventTracker.m
//  Ready
//
//  Created by gongruike on 2018/8/30.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSEventTracker.h"
#import <GrowingIO/Growing.h>

@implementation FSEventTracker

+ (void)trackEvent:(NSString *)eventID {
    [self trackEvent:eventID object:@{}];
}

+ (void)trackEvent:(NSString *)eventID object:(NSDictionary *)object {
    if (![eventID isKindOfClass:[NSString class]]) {
        NSLog(@"%@ %s : eventID should be NSString type", NSStringFromClass(self), __func__);
        return;
    }

    if (![eventID length]) {
        NSLog(@"%@ %s : eventID can't be nil or empty", NSStringFromClass(self), __func__);
        return;
    }
    
    if (![object isKindOfClass:[NSDictionary class]]) {
        NSLog(@"%@ %s : object should be NSDictionary type and can't be nil", NSStringFromClass(self), __func__);
        return;
    }
    
    NSLog(@"\n%@ %s : track eventID = %@\nobject = %@\n", NSStringFromClass(self), __func__, eventID, object);
    [Growing track:eventID withNumber:@(1) andVariable:object];
}

@end
