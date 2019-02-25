//
//  NSString+ConverStrEmoji.h
//  Lolly
//
//  Created by air on 2017/11/23.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ConverStrEmoji)

+ (BOOL)stringContainsEmoji:(NSString *)string;
//过滤表情
+ (NSString *)converStrEmoji:(NSString *)emojiStr;

@end
