//
//  FSSerialEventProtocol.h
//  Ready
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol FSSerialEventDelegate;
@protocol FSSerialEventProtocol <NSObject>

@property(nonatomic,assign)id<FSSerialEventDelegate> delegate;

@property(nonatomic,assign)BOOL finished;

@property(nonatomic,assign)NSInteger eventTag;
// 是否会重复出现
@property(nonatomic,assign)BOOL repeat;
//- (BOOL)repeat;

- (BOOL)shouldBeIgnore;

- (NSInteger)nextEventTag;

- (void)doEvent;

// 事务结束时必须调用
- (void)finishEvent;
//
- (NSComparisonResult)sort:(id<FSSerialEventProtocol>)compare;

@end


@protocol FSSerialEventDelegate<NSObject>
- (void)serialEventDidFinish:(id<FSSerialEventProtocol>)event;
@end
