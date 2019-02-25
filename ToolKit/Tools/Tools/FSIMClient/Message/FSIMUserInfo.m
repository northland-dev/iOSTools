//
//  FSIMUserInfo.m
//  testRongYun
//
//  Created by stu on 2017/11/2.
//  Copyright © 2017年 stu. All rights reserved.
//

#import "FSIMUserInfo.h"

@implementation FSIMUserInfo

- (instancetype)initWithUserId:(NSString *)userId name:(NSString *)username portrait:(NSString *)portrait {
    self = [super init];
    if(self != nil)
    {
        self.userId = userId;
        self.name = username;
        self.portraitUri = portrait;
    }
    return self;
}

+ (NSString *)getPrimaryKey{
    return @"userId";
}

+ (instancetype)userInfoFromUserCenter:(FSUserCenterInfoModel *)centerModel {
    return [FSIMUserInfo fs_objectWithKeyValues:[centerModel mj_keyValues]];
}

@end
