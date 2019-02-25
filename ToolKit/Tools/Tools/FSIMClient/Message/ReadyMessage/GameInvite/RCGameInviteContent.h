//
//  RCGameInviteContent.h
//  Ready
//
//  Created by jiapeng on 2018/8/2.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBaseModelContent.h"

@interface RCGameInviteContent : RCBaseModelContent
@property (nonatomic ,strong) NSString *gameId;
@property (nonatomic ,strong) NSString *groupType;
@property (nonatomic ,strong) NSString *gameName;
@property (nonatomic ,strong) NSString *groupId;


@end
