//
//  FSVpBalanceData.h
//  Ready
//
//  Created by mac on 2018/9/27.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSVpBalanceData : NSObject
/**
 * 虚拟财产类型, 取值产考 {@link com.fission.next.core.consts.balance.VpType}
 */
@property(nonatomic,assign)NSInteger vpType;

/**
 * 变更的虚拟财产余额
 */
@property(nonatomic,assign)NSInteger changeVpAmount;
/**
 * 变更后最新的虚拟财产余额
 */
@property(nonatomic,assign)NSInteger currentVpBalance;

/**
 * 余额版本，用来判断余额消息是否较新
 */
@property(nonatomic,assign)NSInteger version;

@end
