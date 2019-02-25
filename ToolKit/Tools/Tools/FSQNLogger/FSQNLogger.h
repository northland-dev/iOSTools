//
//  FSQNLogger.h
//  Ready
//
//  Created by mac on 2018/11/28.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QNNetDiag/QNNetDiag.h>

@interface FSQNLogger : NSObject

+ (instancetype)shareLogger;

- (void)willCheckUrls:(NSDictionary *)urlDicts ;

- (void)checkUrl:(NSString *)host;
@end
