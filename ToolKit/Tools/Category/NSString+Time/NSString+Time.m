//
//  NSString+Time.m
//  Lolly
//
//  Created by stu on 2017/11/14.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "NSString+Time.h"
#import "NSDate+Category.h"

@implementation NSString (Time)

+ (NSString *)todayStr {
    NSString *formatDate = nil;
    NSDateFormatter *AllFormater = [[NSDateFormatter alloc] init];
    [AllFormater setDateFormat:@"yyyy-MM-dd"];
    [AllFormater setTimeZone:[NSTimeZone localTimeZone]];
    formatDate = [AllFormater stringFromDate:[NSDate date]];
    return formatDate;
}

+ (NSString *)timeformatYYMMDD:(long long)startTime {
    NSString *formatDate = nil;
    NSDateFormatter *AllFormater = [[NSDateFormatter alloc] init];
    
    [AllFormater setDateFormat:@"MM/dd/yyyy"];
    
    [AllFormater setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *curDate = [[NSDate alloc] initWithTimeIntervalSince1970:startTime];
    formatDate = [AllFormater stringFromDate:curDate];
    return formatDate;
}

+ (NSString *)newTimeformatYYMMDD:(long long)startTime{
   
    NSString *formatDate = nil;
    NSDateFormatter *AllFormater = [[NSDateFormatter alloc] init];
    
    [AllFormater setDateFormat:@"yyyy.MM.dd"];
    
    [AllFormater setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *curDate = [[NSDate alloc] initWithTimeIntervalSince1970:startTime];
    formatDate = [AllFormater stringFromDate:curDate];
    return formatDate;
}

+(NSString *)messageTimeWithTime:(long long)time {
    if(time == 0){
        return @"";
    }
    BOOL timeIsToady = [NSString dateIsToday:time];
    if (timeIsToady) {
        return [NSString timeformatHHMM:time];
    }
    BOOL timeIsYesterday = [NSString dateIsYesterday:time];
    if (timeIsYesterday) {
        NSString *yesterday = [FSSharedLanguages CustomLocalizedStringWithKey:@"Yesterday"];
        return yesterday;
    }
    NSString *finalTime = [NSString timeformatYYMMDD:time];
    return finalTime;
}

+ (NSString *)timeformatHHMM:(long long)startTime {
    NSString *formatDate = nil;
    NSDateFormatter *AllFormater = [[NSDateFormatter alloc] init];
    [AllFormater setDateFormat:@"HH:mm"];
    [AllFormater setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *curDate = [[NSDate alloc] initWithTimeIntervalSince1970:startTime];
    formatDate = [AllFormater stringFromDate:curDate];
    return formatDate;
}

+(BOOL)dateIsYesterday:(long long)time{
    NSDate *timeDate = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    return [timeDate isYesterday];
}

+ (BOOL)dateIsToday:(long long)time {
    NSDate *timeDate = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    return [timeDate isToday];
}

+(NSString *)stringForFormatedTime:(NSTimeInterval)timeInterval {
    return [NSString messageTimeWithTime:timeInterval];
}

+ (NSString *)timeformatHHMMWithTodayDis:(long long)todayDis {

    NSDate *date = [NSDate date];
    NSString *formatDate = nil;
    NSTimeZone *sourceTimeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDateFormatter *AllFormater = [[NSDateFormatter alloc] init];
    [AllFormater setDateFormat:@"yyyy-MM-dd"];
    [AllFormater setTimeZone:sourceTimeZone];
    formatDate = [AllFormater stringFromDate:date];
    date = [AllFormater dateFromString:formatDate];
    NSTimeInterval timeInterVal = [date timeIntervalSince1970];
    timeInterVal += todayDis/1000;
    date = [NSDate dateWithTimeIntervalSince1970:timeInterVal];
    
    [AllFormater setDateFormat:@"HH:mm"];
    [AllFormater setTimeZone:[NSTimeZone localTimeZone]];
    formatDate = [AllFormater stringFromDate:date];
    return formatDate;
}

+ (NSString *)timeformatHHMMSS:(long long)interval {
    NSString *formatDate = nil;
    NSDateFormatter *timeFormater = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [timeFormater setDateFormat:@"HH:mm:ss"];
    [timeFormater setTimeZone:timeZone];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    formatDate = [timeFormater stringFromDate:date];
    return formatDate;
}
@end
