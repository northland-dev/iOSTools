//
//  FSActivityEvent.m
//  Ready
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSActivityEvent.h"

@implementation FSActivityEvent
- (instancetype)init {
    if (self = [super init]) {
        self.eventTag = 2;
        self.repeat = YES;
    }
    return self;
}

- (void)doEvent {
    
    if ([self shouldBeIgnore]) {
        [self finishEvent];
    }else{
        if (self.action) {
            self.action(self.popupmodel,self);
        }else{
            [self finishEvent];
        }
    }
}


- (void)dealloc {
    NSLog(@"FSActivityEvent dealloc");
}
@end
