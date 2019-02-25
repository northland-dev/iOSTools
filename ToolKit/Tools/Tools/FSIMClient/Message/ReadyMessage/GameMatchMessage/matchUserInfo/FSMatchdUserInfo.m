//
//  FSMatchdUserInfo.m
//  Ready
//
//  Created by mac on 2018/8/24.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSMatchdUserInfo.h"

@implementation FSMatchdUserInfo

- (NSUInteger)getAge {
    NSDate *birthday = [NSDate dateWithTimeIntervalSince1970:(self.birthday/1000)];
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear
                                               fromDate:birthday
                                                 toDate:now
                                                options:NSCalendarWrapComponents];
    
    return components.year;;
}

@end
