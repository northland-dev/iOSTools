//
//  RCBalanceUpdateContent.h
//  Ready
//
//  Created by mac on 2018/9/27.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCBaseModelContent.h"
#import "FSVpBalanceData.h"

@interface RCBalanceUpdateContent : RCBaseModelContent

@property(nonatomic,assign)NSInteger reasonType;

@property(nonatomic,strong)NSArray<FSVpBalanceData *> *balance;

@end
