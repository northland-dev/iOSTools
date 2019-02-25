//
//  RCFriendsMessageContent.h
//  Ready
//
//  Created by jiapeng on 2018/8/2.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBaseModelContent.h"

@interface RCFriendsMessageContent : RCBaseModelContent
@property (nonatomic ,strong) NSString *messageType;
@property (nonatomic ,strong) NSString *message;

@end
