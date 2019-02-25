//
//  FSIMBaseModelContent.h
//  Ready
//
//  Created by jiapeng on 2018/8/2.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSIMMessageContent.h"
#import "FSIMChatMessage.h"

@interface FSIMBaseModelContent : FSIMChatMessage
@property (nonatomic, strong) NSString *mExtern;
@property (nonatomic, assign) NSInteger fromUserId;
@property (nonatomic, assign) long st;
@property (nonatomic, strong) NSString *type;
//@property(nonatomic,copy)NSString *messageId;

@end
