//
//  EventHandler.h
//  TestEvent
//
//  Created by stu on 2017/6/21.
//  Copyright © 2017年 stu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventDefine.h"
#import "Event.h"

@protocol EventHandlerDelegate;

@interface EventHandler : NSObject<Event>

@property (nonatomic, strong) NSMutableArray *eventList;
@property (nonatomic, weak) id<EventHandlerDelegate> delegate;


@end

@protocol EventHandlerDelegate <Event>



@end


