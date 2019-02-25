//
//  FSIMVoiceMessage.h
//  testRongYun
//
//  Created by stu on 2017/11/2.
//  Copyright © 2017年 stu. All rights reserved.
//

#import "FSIMMessageContent.h"

@interface FSIMVoiceMessage : FSIMMessageContent

/*!
 wav格式的音频数据
 */
@property(nonatomic, strong) NSData *wavAudioData;

/*!
 语音消息的时长
 */
@property(nonatomic, assign) long duration;

/*!
 语音消息的附加信息
 */
@property(nonatomic, strong) NSString *extra;

/*!
 初始化语音消息
 
 @param audioData   wav格式的音频数据
 @param duration    语音消息的时长（单位：秒）
 @return            语音消息对象
 
 @discussion
 如果您不是使用IMKit中的录音功能，则在初始化语音消息的时候，需要确保以下几点。
 1. audioData必须是单声道的wav格式音频数据；
 2. audioData的采样率必须是8000Hz，采样位数（精度）必须为16位。
 
 您可以参考IMKit中的录音参数：
 NSDictionary *settings = @{AVFormatIDKey: @(kAudioFormatLinearPCM),
 AVSampleRateKey: @8000.00f,
 AVNumberOfChannelsKey: @1,
 AVLinearPCMBitDepthKey: @16,
 AVLinearPCMIsNonInterleaved: @NO,
 AVLinearPCMIsFloatKey: @NO,
 AVLinearPC'MIsBigEndianKey: @NO};
 */
+ (instancetype)messageWithAudio:(NSData *)audioData duration:(long)duration;

@end
