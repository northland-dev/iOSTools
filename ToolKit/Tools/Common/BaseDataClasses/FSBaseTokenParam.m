//
//  FSBaseTokenParam.m
//  Lolly
//
//  Created by stu on 2017/11/3.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSBaseTokenParam.h"
#import "LoginSDKManager.h"

@implementation FSBaseTokenParam

- (NSString *)token {
    NSString *token = [LoginSDKManager shareManager].user.token;
    return token;
}

@end
