//
//  FSSerialEventBuilder.h
//  Ready
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSSerialEventProtocol.h"


/*
    启动事务管理器
    注册的事件必须是有序的 tag 是连贯的 可以间隔tag
 */

@interface FSSerialEventBuilder : NSObject

+ (instancetype)sharedBuilder;

- (void)insertEvent:(id<FSSerialEventProtocol>)event;

// 当eventtag 为第一个装填的时候 开始调用
- (void)startEvent;

- (void)stopEvent;

// 可能要重新开始
- (void)mayRepeatEvent;
@end
