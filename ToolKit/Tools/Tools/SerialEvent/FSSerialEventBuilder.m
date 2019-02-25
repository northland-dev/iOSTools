
//
//  FSSerialEventBuilder.m
//  Ready
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSSerialEventBuilder.h"
#import "FSSerialEvent.h"


@interface FSSerialEventBuilder()<FSSerialEventDelegate>{
    BOOL _eventsStart;
}
@property(nonatomic,strong)id<FSSerialEventProtocol> currentEvent;
@property(nonatomic,strong)NSMutableArray *events;
@property(nonatomic,strong)NSMutableArray *finishedEvents;

@end
@implementation FSSerialEventBuilder

static FSSerialEventBuilder *shareObj = nil;

+ (instancetype)sharedBuilder {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareObj = [[FSSerialEventBuilder alloc] init];
    });
    return shareObj;
}

- (void)insertEvent:(id<FSSerialEventProtocol>)event {
    // 等待队列
    if (event) {
        [event setDelegate:self];
        [self.events addObject:event];
        [self.events sortUsingSelector:@selector(sort:)];
        [self checkNextEvent];
    }
}

//
- (void)startEvent {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _eventsStart = YES;
        
        id<FSSerialEventProtocol> event = [self.events firstObject];
        if (![event shouldBeIgnore]) {
            // 第一次处理
             self.currentEvent = event;
            [event doEvent];
        }else{
            [self checkNextEvent];
        }
    });
}
- (void)stopEvent {
    _eventsStart = NO;
}

- (void)checkNextEvent {
    if (!_eventsStart) {
        // 还未启动
        return;
    }
    
    if (self.currentEvent && !self.currentEvent.finished) {
        // 当前事务未完成
        return;
    }
    
    id<FSSerialEventProtocol> next = [self.events firstObject];
    NSInteger tag = [next eventTag];
    NSInteger nextTag = [self.currentEvent nextEventTag];
    
    if (!self.currentEvent || nextTag == tag) {
        // 第一次启动
         self.currentEvent = next;
        [self.currentEvent doEvent];
    }else {
        // 等待新的事务插入
        NSLog(@"等待新的事务插入");
    }
}


- (void)mayRepeatEvent {
    WS(weaks);
    NSMutableArray *willLastEvent = [NSMutableArray array];
    
    for (FSSerialEvent * event in self.finishedEvents) {
        if (!event.repeat) {
            [willLastEvent addObject:event];
        }
    }
    
    [self.finishedEvents removeAllObjects];
    [self.finishedEvents addObjectsFromArray:willLastEvent];
    // 清理所有的事件
    [self.events removeAllObjects];
    self.currentEvent = [self.finishedEvents lastObject];
}

#pragma mark -
- (void)serialEventDidFinish:(id<FSSerialEventProtocol>)event {
    [self.events removeObject:event];
    [self.finishedEvents addObject:event];
    // 执行event的事件
     self.currentEvent = event;
    [self checkNextEvent];
}

#pragma mark - getter
- (NSMutableArray *)events {
    if (!_events) {
        _events = [NSMutableArray array];
    }
    return _events;
}
- (NSMutableArray *)finishedEvents {
    if (!_finishedEvents) {
        _finishedEvents = [NSMutableArray array];
    }
    return _finishedEvents;
}
@end
