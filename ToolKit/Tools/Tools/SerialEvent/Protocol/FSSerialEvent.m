//
//  FSSerialEvent.m
//  Ready
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSSerialEvent.h"

@implementation FSSerialEvent
@synthesize finished,eventTag,delegate,repeat;

- (void)doEvent {}

- (void)finishEvent {
    
    self.finished = YES;
    
    if ([self.delegate respondsToSelector:@selector(serialEventDidFinish:)]) {
        [self.delegate serialEventDidFinish:self];
    }
}

- (BOOL)shouldBeIgnore {
    return NO;
}
- (NSComparisonResult)sort:(id<FSSerialEventProtocol>)compare{
    if (compare.eventTag > self.eventTag) {
        return NSOrderedAscending;
    }
    
    return NSOrderedDescending;
}
- (NSInteger)nextEventTag {
    return self.eventTag + 1;
}
@end
