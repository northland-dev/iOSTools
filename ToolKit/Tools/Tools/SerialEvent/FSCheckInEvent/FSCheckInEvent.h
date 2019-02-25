//
//  FSCheckInEvent.h
//  Ready
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSSerialEvent.h"
#import "FSUpgradeServer.h"
#import "LoginSDKManager.h"

@interface FSCheckInEvent : FSSerialEvent
@property(nonatomic,copy)dispatch_block_t checkInAction;
@end
