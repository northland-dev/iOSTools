//
//  RCSystemContent.h
//  Ready
//
//  Created by gongruike on 2018/9/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "RCBaseModelContent.h"

@interface RCSystemContent : RCBaseModelContent

// 1、图片
// 2、链接
// 3、普通文本
@property (nonatomic, assign) NSInteger      systemTemplate;    //类型11是奖池

@property (nonatomic, strong) NSString      *image;            //11是奖池 生效奖励类型0金币 1是钻石

@property (nonatomic, strong) NSString      *link; // 地址     //11是奖池 生效奖励数量
@property (nonatomic, strong) NSDictionary  *linkContent;

@property (nonatomic, strong) NSDictionary  *titleContent; // 标题
@property (nonatomic, strong) NSDictionary  *content; // 具体内容

@end
