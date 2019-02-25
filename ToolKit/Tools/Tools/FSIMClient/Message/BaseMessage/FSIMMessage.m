//
//  FSIMMessage.m
//  testRongYun
//
//  Created by stu on 2017/11/1.
//  Copyright © 2017年 stu. All rights reserved.
//

#import "FSIMMessage.h"

@implementation FSIMMessage

- (instancetype)initWithType:(FSConversationType)conversationType
                    targetId:(NSString *)targetId
                   direction:(FSIMMessageDirection)messageDirection
                   messageId:(long)messageId
                     content:(FSIMMessageContent *)content{
    self = [super init];
    if(self != nil)
    {
        self.conversationType = conversationType;
        self.messageId = messageId;
        self.messageDirection = messageDirection;
        self.content = content;
        self.targetId = targetId;
        self.sentTime = [[NSDate date] timeIntervalSince1970];
    }
    return self;
}

@end
