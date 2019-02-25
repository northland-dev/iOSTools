//
//  FSIMGameMatchContent.h
//  Ready
//
//  Created by mac on 2018/8/24.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSIMBaseModelContent.h"
#import "FSMatchdUserInfo.h"
@interface FSIMGameMatchContent : FSIMBaseModelContent
@property(nonatomic,strong)NSString *groupId;
@property(nonatomic,strong)NSString *groupType;
@property(nonatomic,strong)NSArray<FSMatchdUserInfo *> *users;
@end
