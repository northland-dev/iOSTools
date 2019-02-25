//
//  FSGlobalLauncher.h
//  Ready
//
//  Created by jiapeng on 2018/7/23.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSGlobalLauncher : NSObject
@property (nonatomic ,strong) NSDictionary *allKeyDict;
@property (nonatomic ,strong) NSDictionary *hotCountryDict;
@property (nonatomic ,strong) NSDictionary *otherCountryDict;

@property (nonatomic ,strong) NSString *currentCode;//当前国家
@property (nonatomic ,assign) double strlatitude;  //经度
@property (nonatomic ,assign) double strlongitude;  //纬度

@property (nonatomic ,assign) BOOL isConfigNetwork; //首页导航是否获取中

@property (nonatomic ,assign) BOOL willPlayGame;

@property (nonatomic ,assign) BOOL isInChatting;
@property (nonatomic ,assign) BOOL isInPlayGame;
@property (nonatomic ,strong) NSString *currentGameId;
@property (nonatomic ,strong) NSString *groupId;

@property (nonatomic ,strong) NSString *chatingId;

@property (nonatomic ,assign) float coin_to_diamond;
@property (nonatomic ,assign) float diamond_to_dollar;

+ (instancetype) launcher;

- (NSString *)getFullCountryNameStr:(NSString *)shortCountryCode;
- (NSString *)getInviteFaceBookFriendUrlString;
- (NSString *)getInviteFriendUrlString;
- (NSString *)getTwitterInviteFriendUrlString;

- (void)getReverseContryCode:(dispatch_block_t)complete;

@end
