//
//  FSBaseServer.m
//  Ready
//
//  Created by luyee on 2018/8/7.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSBaseServer.h"

@implementation FSBaseServer

- (FSBaseServer *(^)(EventHandler *eventHandler))setEvenHandler{
    return ^(EventHandler *eventHandler){
        _eventHandler = eventHandler;
        return self;
    };
}

-(EventHandler *)eventHandlerSelf{
    if (!_eventHandlerSelf) {
        _eventHandlerSelf = [[EventHandler alloc] init];
        [_eventHandlerSelf setDelegate:self];
    }
    return _eventHandlerSelf;
}

@end
