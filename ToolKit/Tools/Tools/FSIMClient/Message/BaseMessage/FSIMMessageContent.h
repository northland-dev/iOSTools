//
//  FSIMMessageContent.h
//  testRongYun
//
//  Created by stu on 2017/11/2.
//  Copyright © 2017年 stu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSIMUserInfo.h"

@interface FSIMMessageContent : NSObject

/*!
 消息内容中携带的发送者的用户信息
  */
@property(nonatomic, strong) FSIMUserInfo *senderUserInfo;

@property(nonatomic, assign) long long sendTime;

@property(nonatomic, assign) BOOL isTimeShow;


@end
