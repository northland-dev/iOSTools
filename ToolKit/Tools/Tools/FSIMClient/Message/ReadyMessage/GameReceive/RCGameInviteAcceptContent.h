//
//  RCGameInviteAcceptContent.h
//  Ready
//
//  Created by mac on 2018/10/15.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCBaseModelContent.h"

@interface RCGameInviteAcceptContent : RCBaseModelContent
@property(nonatomic,assign)NSInteger userType;
@property(nonatomic,strong)NSString *groupId;
@property(nonatomic,strong)NSString *groupType;
@end
