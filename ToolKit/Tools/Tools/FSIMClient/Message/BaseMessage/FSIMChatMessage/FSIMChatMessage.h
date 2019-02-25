//
//  FSIMChatMessage.h
//  Lolly
//
//  Created by Charles on 2017/11/15.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSIMMessageContent.h"

typedef NS_ENUM(NSUInteger, FSChatMessageType) {
    FSChatMessageTypeSelf,
    FSChatMessageTypeOther,
    FSChatMessageTypeSystem,
};

typedef NS_ENUM(NSUInteger,FSChatMessageState) {
    FSChatMessageStateUndefine,
    FSChatMessageStateFaild,
    FSChatMessageStateSending,
    FSChatMessageStateSuccess,
};

@interface FSIMChatMessage : FSIMMessageContent
// 发送人的id
@property(nonatomic,copy)NSString *sendTargetId;

@property(nonatomic,copy)NSString *targetId;

@property(nonatomic,copy)NSString *messageId;

@property(nonatomic,assign)FSChatMessageType msgtype;

@property(nonatomic,assign)FSChatMessageState state;

@property(nonatomic,copy) NSString *time; //时间

@property(nonatomic,copy) NSString *headUrl; //头像

@property(nonatomic,copy) UIImage *headerImage; //头像

// 是否需要重新计算cell的高度
@property(nonatomic,assign) BOOL needReCaculate;

@property(nonatomic,assign) BOOL isTimeShow; //是否需要显示时间

@property(nonatomic,assign)CGFloat messageHeight;

@end
