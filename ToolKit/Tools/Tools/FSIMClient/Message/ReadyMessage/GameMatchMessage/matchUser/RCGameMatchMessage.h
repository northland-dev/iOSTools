//
//  RCGameMatchMessage.h
//  Ready
//
//  Created by mac on 2018/8/24.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCBaseModelContent.h"

@interface RCGameMatchMessage : RCBaseModelContent
@property(nonatomic,strong)NSString *groupId;
@property(nonatomic,strong)NSString *groupType;
@property(nonatomic,strong)NSArray *users;
@end
