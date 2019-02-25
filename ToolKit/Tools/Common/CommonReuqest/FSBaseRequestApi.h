//
//  FSBaseRequestApi.h
//  Ready
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSBaseRequestApi.h"

@interface FSBaseRequestApi : NSObject<FSBaseAPIDelegate, EventHandlerDelegate>

@property (nonatomic, weak) __block EventHandler *eventHandler;

@property (nonatomic, assign) NSInteger eventType;

- (FSBaseRequestApi *(^)(EventHandler *eventHandler))setEvenHandler;

- (NSString *)urlName;

@end
