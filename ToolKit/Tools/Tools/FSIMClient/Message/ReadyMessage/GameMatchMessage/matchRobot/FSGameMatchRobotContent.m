//
//  FSGameMatchRobotContent.m
//  Ready
//
//  Created by mac on 2018/8/24.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSGameMatchRobotContent.h"

@implementation FSGameMatchRobotContent
- (void)setUsers:(NSArray *)users {
    _users = [FSMatchdUserInfo mj_objectArrayWithKeyValuesArray:users];
}
@end
