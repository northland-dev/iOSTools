//
//  Event.h
//  TestEvent
//
//  Created by stu on 2017/6/21.
//  Copyright © 2017年 stu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EventHandler;
@protocol Event <NSObject>

@optional

-(instancetype)initWithEventHandler:(EventHandler *)eventHandler;

-(instancetype)initWithEventHandler:(EventHandler *)eventHandler Object:(id)object;

-(void)sendEvent:(NSInteger)eventType withObject:(id)object;

-(void)didReciveEvent:(NSInteger)eventType withObject:(id)object;

- (void)sendEvent:(NSInteger)eventType withObject:(id)object andApi:(id)api;
- (void)didReciveEvent:(NSInteger)eventType withObject:(id)object andApi:(id)api;

@end
