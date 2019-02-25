//
//  RCGroupJoinContent.h
//  Ready
//
//  Created by jiapeng on 2018/8/2.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBaseModelContent.h"

@interface RCGroupJoinContent : RCBaseModelContent
@property (nonatomic ,assign) NSInteger onlineNumber;
@property (nonatomic ,assign) NSInteger roomNumber;
@property (nonatomic ,strong) NSDictionary *userInfo;
@property (nonatomic ,strong) NSString *groupType;
@property (nonatomic ,strong) NSString *groupId;
@property (nonatomic ,assign) NSInteger userId;

@end
