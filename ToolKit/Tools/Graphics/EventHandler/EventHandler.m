//
//  EventHandler.m
//  TestEvent
//
//  Created by stu on 2017/6/21.
//  Copyright © 2017年 stu. All rights reserved.
//


@implementation EventHandler

-(NSMutableArray *)eventList{
    if (!_eventList) {
        _eventList = [NSMutableArray array];
    }
    for (NSInteger i = 0; i < _eventList.count; i ++) {
        for (NSInteger j = i + 1; j < _eventList.count; j++) {
            EventHandler *handler = _eventList[i];
            EventHandler *handler2 = _eventList[j];
            if ([handler isEqual:handler2] || [handler.delegate.class isEqual:handler2.delegate.class]) {
                [_eventList removeObjectAtIndex:i];
                i--;
            }
        }
    }
    return _eventList;
}

-(void)sendEvent:(NSInteger)eventType withObject:(id)object{
    if (self.eventList.count) {
        for (NSInteger i = 0; i < _eventList.count; i ++) {
            EventHandler *handler = _eventList[i];
            if ([handler.delegate respondsToSelector:@selector(didReciveEvent:withObject:)]) {
                [handler.delegate didReciveEvent:eventType withObject:object];
            }
        }
    }else if ([self.delegate respondsToSelector:@selector(didReciveEvent:withObject:)]) {
        [self.delegate didReciveEvent:eventType withObject:object];
    }
}

- (void)sendEvent:(NSInteger)eventType withObject:(id)object andApi:(id)api{
    if (self.eventList.count) {
        for (NSInteger i = 0; i < _eventList.count; i ++) {
            EventHandler *handler = _eventList[i];
            if ([handler.delegate respondsToSelector:@selector(didReciveEvent:withObject:andApi:)]) {
                [handler.delegate didReciveEvent:eventType withObject:object andApi:api];
            }
        }
    }else if ([self.delegate respondsToSelector:@selector(didReciveEvent:withObject:andApi:)]) {
        [self.delegate didReciveEvent:eventType withObject:object andApi:api];
    }
}

@end
