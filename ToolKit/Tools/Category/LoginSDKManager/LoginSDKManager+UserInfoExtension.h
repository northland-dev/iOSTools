//
//  LoginSDKManager+UserInfoExtension.h
//  Ready
//
//  Created by mac on 2018/12/18.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "LoginSDKManager.h"
#import "FSUser_InfoResult.h"
#import "FSUserInfoApi.h"


NS_ASSUME_NONNULL_BEGIN

@interface LoginSDKManager (UserInfoExtension)<FSUserInfoApiDelegate>
@property(nonatomic,strong)NSArray *gameStatics;

- (void)requestGameStatics;
@end

NS_ASSUME_NONNULL_END
