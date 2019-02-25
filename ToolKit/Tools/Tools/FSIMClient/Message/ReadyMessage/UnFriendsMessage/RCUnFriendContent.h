//
//  RCUnFriendContent.h
//  Ready
//
//  Created by mac on 2018/11/12.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCBaseModelContent.h"

@interface RCUnFriendContent : RCBaseModelContent
// localTypeValue
// value 1 , 添加好友提示
// value 2 , 同意好友提示
@property(nonatomic,assign)NSInteger tipType;
@end
