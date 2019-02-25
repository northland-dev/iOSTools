//
//  FSConfigSever.m
//  Lolly
//
//  Created by jiapeng on 2017/11/7.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSConfigSever.h"
#import "FSConfigParam.h"
#import "FSConfigResult.h"
#import "FSConfigAPI.h"
#import "FSGlobalLauncher.h"
#import "AppDelegate.h"
#import "FSConfigFile.h"
#import "FSQNLogger.h"


@interface FSConfigSever()<FSConfigAPIDelegate>
@property (nonatomic ,strong) FSConfigAPI *configAPI;
@property (nonatomic ,assign) NSInteger indexNumber;

@end

@implementation FSConfigSever

static FSConfigSever *sharedConfigSever;

+ (instancetype)shareServer {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedConfigSever = [[FSConfigSever alloc] init];
    });
    return sharedConfigSever;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
      
    }
    return self;
}

- (void)requestTotalSumData {
    
    
    FSConfigParam *param =[[FSConfigParam alloc] init];
    
    if (_configAPI == nil) {
        _configAPI = [[FSConfigAPI alloc] init];
        [_configAPI setDelegate:self];
    }
    
    [self.configAPI requestWithParam:param];
}

#pragma mark - FSConfigAPIDelegate

- (void)FSConfigAPISuccess:(FSConfigResult *)resultClass {
    
    [FSGlobalLauncher launcher].isConfigNetwork =NO;

    [FSGlobalLauncher launcher].allKeyDict =resultClass.navsDict;
    [FSGlobalLauncher launcher].hotCountryDict =resultClass.hotDict;
    [FSGlobalLauncher launcher].otherCountryDict =resultClass.otherDict;
    
    [FSGlobalLauncher launcher].coin_to_diamond =[resultClass.exchangeDict floatForKey:@"coin_to_diamond"];
    [FSGlobalLauncher launcher].diamond_to_dollar =[resultClass.exchangeDict floatForKey:@"diamond_to_dollar"];
    
    // 配置url
    NSString *userInfoUrl =[[FSGlobalLauncher launcher].allKeyDict objectForKey:KeyUser_self];
    [[LoginSDKManager shareManager] setCompleteUserInfoUrl:userInfoUrl];
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [app callBackConfigmethod];
    
    [FSConfigFile removeConfigInfo];
    [FSConfigFile saveConfigInfo:resultClass.navsDict];
    
    
    // 未成功获取的话 就请求处理
    if ([FSUpgradeServer sharedInstance].state == FSUpgradeInfoStateUndefine) {
        [[FSUpgradeServer sharedInstance] requestUpgradeInfo];
    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_SuccessLoginType object:nil];
//
//    //回调给需要的地方
//    if ([self.delegate respondsToSelector:@selector(FSConfigSeverCallBack)]) {
//        [self.delegate FSConfigSeverCallBack];
//    }
    
#if Evt == 1
    [[FSQNLogger shareLogger] willCheckUrls:[FSGlobalLauncher launcher].allKeyDict];
#endif
}

- (void)FSConfigAPIFailed:(NSError *)failure {
    
    [FSGlobalLauncher launcher].isConfigNetwork =NO;

    NSDictionary *configDict =[FSConfigFile ConfigInfo];
    [FSGlobalLauncher launcher].allKeyDict =configDict;
    
    
    self.indexNumber++;
    if (self.indexNumber<=6) {
        [self requestTotalSumData];
    }
    
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [app callBackConfigmethod];
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_FaildLoginType object:nil];
    
//    //如果没有缓存继续请求
//    if (configDict.allKeys.count==0) {
//        [self requestTotalSumData];
//        return;
//    }
    //回调给需要的地方
//    if ([self.delegate respondsToSelector:@selector(FSConfigSeverCallBack)]) {
//        [self.delegate FSConfigSeverCallBack];
//    }
}

- (void)FSConfigAPICode:(NSInteger)reportCode {
    
    [FSGlobalLauncher launcher].isConfigNetwork =NO;

    NSDictionary *configDict =[FSConfigFile ConfigInfo];
    [FSGlobalLauncher launcher].allKeyDict =configDict;
    
    self.indexNumber++;
    if (self.indexNumber<=6) {
        [self requestTotalSumData];
    }
    
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [app callBackConfigmethod];
    
//    //如果没有缓存继续请求
//    if (configDict.allKeys.count==0) {
//        [self requestTotalSumData];
//        return;
//    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_FaildLoginType object:nil];
//
//    //回调给需要的地方
//    if ([self.delegate respondsToSelector:@selector(FSConfigSeverCallBack)]) {
//        [self.delegate FSConfigSeverCallBack];
//    }
}

@end
