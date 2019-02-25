//
//  FSPurchaseConfiger.h
//  FSPurchase
//
//  Created by Charles on 2017/10/27.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSPurchaseHeader.h"

@interface FSPurchaseConfiger : NSObject
// 失败订单验证时间间隔
// default 300 秒
@property(nonatomic,assign)NSTimeInterval localCheckInterval;
// 提交时验证失败发起下次验证时间间隔
// default 60 秒
@property(nonatomic,assign)NSTimeInterval immediatelyCheckInterval;
// 不能为空,必须设置
// 一般设置为UserId
@property(nonatomic,strong)NSString *applicationUserName;

// 后台验证成功的处理
@property(nonatomic,strong)SuccessBlock successBlock;

+(instancetype)sharedConfiger;
@end
