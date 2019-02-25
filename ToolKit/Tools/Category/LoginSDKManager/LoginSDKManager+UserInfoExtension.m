//
//  LoginSDKManager+UserInfoExtension.m
//  Ready
//
//  Created by mac on 2018/12/18.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "LoginSDKManager+UserInfoExtension.h"

@implementation LoginSDKManager (UserInfoExtension)

- (FSUserInfoApi *)userInfoApi {
    FSUserInfoApi *api = objc_getAssociatedObject(self, _cmd);
    if (!api) {
         api = [[FSUserInfoApi alloc] init];
        [api setDelegate:self];
        objc_setAssociatedObject(self, _cmd, api, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return api;
}
- (void)requestGameStatics {
    [[self userInfoApi] userInfoApiGetInfo:self.user.userId  keys:@"game_statistics",nil];
}

#pragma mark - delegates
- (void)userInfoApiGetInfos:(FSUserInfoResult * _Nullable)result {
    NSDictionary *dataInfo = result.dataInfo;
    NSArray *gameStatics = [FSGameStatistics mj_objectArrayWithKeyValuesArray:[dataInfo valueForKey:@"game_statistics"]];
    [self setGameStatics:gameStatics];
}

#pragma mark - getter & setter
- (void)setGameStatics:(NSArray *)gameStatics {
    objc_setAssociatedObject(self, @selector(gameStatics), gameStatics, OBJC_ASSOCIATION_RETAIN);
}
- (NSArray *)gameStatics {
    return objc_getAssociatedObject(self, _cmd);
}


@end
