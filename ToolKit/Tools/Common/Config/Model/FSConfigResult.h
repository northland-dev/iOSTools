//
//  FSConfigResult.h
//  Lolly
//
//  Created by jiapeng on 2017/11/7.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSBaseRequestResult.h"

@interface FSConfigResult : FSBaseRequestResult
@property (nonatomic ,strong) NSDictionary *dataInfo;
@property (nonatomic ,strong) NSDictionary *navsDict;
@property (nonatomic ,strong) NSDictionary *hotDict;
@property (nonatomic ,strong) NSDictionary *otherDict;
@property (nonatomic ,strong) NSDictionary *exchangeDict;

@end
