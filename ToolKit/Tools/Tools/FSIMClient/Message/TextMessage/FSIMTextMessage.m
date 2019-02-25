//
//  FSIMTextMessage.m
//  testRongYun
//
//  Created by stu on 2017/11/1.
//  Copyright © 2017年 stu. All rights reserved.
//

#import "FSIMTextMessage.h"

@implementation FSIMTextMessage

- (NSMutableArray *)messageEmojiArray {
    if (!_messageEmojiArray) {
        _messageEmojiArray = [NSMutableArray array];
    }
    return _messageEmojiArray;
}

@end
