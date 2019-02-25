//
//  FSBaseServer.h
//  Ready
//
//  Created by luyee on 2018/8/7.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSBaseServer : NSObject <EventHandlerDelegate>

@property (nonatomic, weak) EventHandler *eventHandler;
@property (nonatomic, strong) EventHandler *eventHandlerSelf;

- (FSBaseServer *(^)(EventHandler *eventHandler))setEvenHandler;

@end
