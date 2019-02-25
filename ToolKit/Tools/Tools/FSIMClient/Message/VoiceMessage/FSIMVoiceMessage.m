//
//  FSIMVoiceMessage.m
//  testRongYun
//
//  Created by stu on 2017/11/2.
//  Copyright © 2017年 stu. All rights reserved.
//

#import "FSIMVoiceMessage.h"

@implementation FSIMVoiceMessage

+ (instancetype)messageWithAudio:(NSData *)audioData duration:(long)duration {
    FSIMVoiceMessage *message = [[FSIMVoiceMessage alloc] init];
    message.wavAudioData = audioData;
    message.duration = duration;
    return message;
}

@end
