//
//  FSIMTextMessage.h
//  testRongYun
//
//  Created by stu on 2017/11/1.
//  Copyright © 2017年 stu. All rights reserved.
//

#import "FSIMChatMessage.h"

@interface FSIMTextMessage : FSIMChatMessage
/*!
 文本消息的内容
 */
@property(nonatomic, strong) NSString *content;

/*!
 表情数组
 */
@property (strong, nonatomic) NSMutableArray *messageEmojiArray;

//文本的尺寸
@property (nonatomic, assign) CGSize  TextViewSize;


@end
