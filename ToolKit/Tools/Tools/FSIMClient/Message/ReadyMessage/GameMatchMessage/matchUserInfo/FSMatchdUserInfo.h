//
//  FSMatchdUserInfo.h
//  Ready
//
//  Created by mac on 2018/8/24.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSMatchdUserInfo : NSObject
@property(nonatomic,strong)NSString *battlefield;
@property(nonatomic,strong)NSString *country;
@property(nonatomic,assign)int64_t birthday;
@property(nonatomic,strong)NSString *headPic;
@property(nonatomic,assign)int64_t lastLoginTime;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,assign)NSInteger robot;
@property(nonatomic,assign)NSInteger sex;
@property(nonatomic,strong)NSString *surfing;
@property(nonatomic,strong)NSString *userId;

- (NSUInteger)getAge;

@end
