//
//  FSUpgradeEvent.m
//  Ready
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSUpgradeEvent.h"
@interface FSUpgradeEvent(){
    FSAppUpgradeInfo *_upgradeInfo;
}
@end
@implementation FSUpgradeEvent

- (instancetype)initWithInfo:(FSAppUpgradeInfo *)info {
    if (self = [super init]) {
        _upgradeInfo = info;
        self.eventTag = 0;
    }
    return self;
}
- (FSAppUpgradeInfo *)upgradeInfo {
    return _upgradeInfo;
}

- (void)doEvent {
    if ([self shouldBeIgnore]) {
        [self finishEvent];
    }else{
        if ([self.eventDelegate respondsToSelector:@selector(upgradeEventDoEvent:)]) {
            [self.eventDelegate upgradeEventDoEvent:self];
        }
    }
}

- (void)dealloc {
    NSLog(@"FSUpgradeEvent dealloc");
}
@end
