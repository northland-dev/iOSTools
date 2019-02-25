//
//  FSUpgradeEvent.h
//  Ready
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSSerialEvent.h"
#import "FSAppUpgradeInfo.h"

@class FSUpgradeEvent;
@protocol FSUpgradeEventDelegate<NSObject>
- (void)upgradeEventDoEvent:(FSUpgradeEvent *)upgradeEvent;
@end

@interface FSUpgradeEvent : FSSerialEvent

@property(nonatomic,assign)id<FSUpgradeEventDelegate> eventDelegate;
@property(nonatomic,strong,readonly)FSAppUpgradeInfo *upgradeInfo;


- (instancetype)initWithInfo:(FSAppUpgradeInfo *)info;
@end
