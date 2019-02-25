//
//  FSUtils.h
//  Lolly
//
//  Created by gongruike on 2017/12/1.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSUtils : NSObject

#pragma mark - date formatter
+ (NSDateFormatter *)profileDateFormatter;

+ (NSDateFormatter *)videoChatRecordDateFormatter;

#pragma mark - alert
+ (UIAlertController *)unfollowAlertController:(dispatch_block_t)comfirmBlock;

+ (UIAlertController *)settingAlertController:(dispatch_block_t)settingBlock
                                  cancelBlock:(dispatch_block_t)cancelBlock;

+ (UIAlertController *)unlockAlertController:(NSInteger)price
                                      unlock:(dispatch_block_t)unlockBlock;

+ (UIAlertController *)privateChatAlertController:(NSString *)title chatBlock:(dispatch_block_t)chatBlock;

#pragma mark - utils

+ (NSString *)lastTimeStringFrom:(NSInteger)timeInterval;

@end
