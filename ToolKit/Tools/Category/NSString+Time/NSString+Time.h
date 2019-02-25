//
//  NSString+Time.h
//  Lolly
//
//  Created by stu on 2017/11/14.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Time)

/**
 *  返回年月日格式的时间字符串 10/31/2017
 *
 *  @param startTime 时间long 秒数
 *
 *  @return return value description
 */
+ (NSString *)timeformatYYMMDD:(long long)startTime;

+ (NSString *)newTimeformatYYMMDD:(long long)startTime;

/**
 *  如果是今天，返回小时分钟，22:00 如果是昨天 就返回昨天 yestoday 其余返回年月日格式的时间字符串 10/31/2017
 *
 *  @param time 时间long 秒数
 *
 *  @return return value description
 */
+ (NSString *)messageTimeWithTime:(long long)time;
/**
 *  返回时间字符串 22:00
 *
 *  @param startTime 时间long 秒数
 *
 *  @return return value description
 */
+ (NSString *)timeformatHHMM:(long long)startTime;
/**
 *  返回是否是今天
 *
 *  @param time 时间long 秒数
 *
 *  @return return value description
 */
+ (BOOL)dateIsToday:(long long)time;
/**
 *  返回是否是昨天
 *
 *  @param time 时间long 秒数
 *
 *  @return return value description
 */
+ (BOOL)dateIsYesterday:(long long)time;

+ (NSString *)stringForFormatedTime:(NSTimeInterval)timeInterval;

+ (NSString *)todayStr;
// todayDis UTC 时间开始后的时间
+ (NSString *)timeformatHHMMWithTodayDis:(long long)todayDis;

+ (NSString *)timeformatHHMMSS:(long long)interval;
@end
