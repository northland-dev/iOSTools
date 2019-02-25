//
//  FSCheckInEvent.m
//  Ready
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSCheckInEvent.h"

@implementation FSCheckInEvent
- (instancetype)init {
    if (self = [super init]) {
        self.eventTag = 1;
        self.repeat = YES;
    }
    return self;
}


- (void)doEvent {
    if ([self shouldBeIgnore]) {
        [self finishEvent];
    }else{
        if (self.checkInAction) {
            self.checkInAction();
        }else{
            [self finishEvent];
        }
    }
}
- (void)dealloc {
    NSLog(@"FSCheckInEvent dealloc");
}
@end
