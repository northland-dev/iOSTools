//
//  FSBaseRequestApi.m
//  Ready
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSBaseRequestApi.h"

@implementation FSBaseRequestApi

- (FSBaseRequestApi *(^)(EventHandler *eventHandler))setEvenHandler{
    return ^(EventHandler *eventHandler){
        self.eventHandler = eventHandler;
        return self;
    };
}

- (NSString *)urlName{
    NSString *apiClassName = NSStringFromClass(self.class).lowercaseString;
    NSMutableString *tmpStr = [NSMutableString stringWithString:apiClassName];
    [tmpStr deleteCharactersInRange:NSMakeRange(0, 2)];
    [tmpStr deleteCharactersInRange:NSMakeRange(tmpStr.length - 3, 3)];
    return [NSString stringWithString:tmpStr];
}

- (void)baseAPISuccess:(FSBaseResult *)result{
    if (self.eventHandler) {
        [self.eventHandler sendEvent:_eventType withObject:result andApi:self];
    }
}

- (void)baseAPIFailed:(NSError *)error{
    if (self.eventHandler) {
        [self.eventHandler sendEvent:_eventType withObject:@(-1) andApi:self];
    }
}

- (void)baseAPIFailedWithCode:(NSInteger)code{
    if (self.eventHandler) {
        [self.eventHandler sendEvent:_eventType withObject:@(code) andApi:self];
    }
}

@end
