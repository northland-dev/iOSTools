//
//  FSGlobalLauncher.m
//  Ready
//
//  Created by jiapeng on 2018/7/23.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSGlobalLauncher.h"
#import "FSConfigSever.h"
#import <CoreLocation/CoreLocation.h>
#import "FSUserInfoModel.h"
#import "NSString+GC.h"
#import "LoginSDKManager.h"
#import "NSString+URL.h"

@interface FSGlobalLauncher ()<CLLocationManagerDelegate>{
    BOOL _uploaded;
}

@property (nonatomic ,strong) CLLocationManager *locationmanager;//定位服务
@property (nonatomic ,strong) NSString *currentCity;//当前国家
@end

@implementation FSGlobalLauncher

static FSGlobalLauncher *shareInstance;

+ (instancetype)launcher {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[FSGlobalLauncher alloc] init];
    });
    return shareInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _uploaded = NO;
        self.allKeyDict =[NSDictionary new];
        self.hotCountryDict =[NSDictionary new];
        self.otherCountryDict =[NSDictionary new];
        
        [[FSConfigSever shareServer] requestTotalSumData];
        
        [self openCurrentLocation];

    }
    return self;
}

#pragma mark - 隐私设置权限开启
-(void)openCurrentLocation {
    
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationmanager = [[CLLocationManager alloc]init];
        self.locationmanager.delegate = self;
        self.currentCity = [NSString new];
        [self.locationmanager requestWhenInUseAuthorization];
        
        //设置寻址精度
        self.locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
        // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
        self.locationmanager.distanceFilter = 1000.0f;
        [self.locationmanager startUpdatingLocation];
    }
}

//#pragma mark CoreLocation delegate (定位失败)
////定位失败后调用此代理方法
//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    //设置提示提醒用户打开定位服务
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:nil];
//
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:okAction];
//    [alert addAction:cancelAction];
//    [self.parentVC presentViewController:alert animated:YES completion:nil];
//}

#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self.locationmanager stopUpdatingHeading];
    //旧址
    CLLocation *currentLocation = [locations lastObject];
    
    self.strlatitude =currentLocation.coordinate.latitude;
    self.strlongitude =currentLocation.coordinate.longitude;
        
    //打印当前的经度与纬度
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    
    //暂时用不到  反地理编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            
            self.currentCity = placeMark.locality;
            self.currentCode = placeMark.ISOcountryCode;
            
            NSString *key = [NSString stringWithFormat:@"DataSta_Client_OpenLocation_Success"];
            NSDictionary *contentJson = @{@"ISOcountryCode":self.currentCode};
            NSDictionary *param = @{@"content":contentJson.mj_JSONString};
            [RyzeMagicStatics ryze_addEventName:key withParams:param];
//                        /*看需求定义一个全局变量来接收赋值*/
//                        NSLog(@"----%@",placeMark.country);//当前国家
//                        NSLog(@"%@",self.currentCity);//当前的城市
//                        NSLog(@"%@",placeMark.subLocality);//当前的位置
//                        NSLog(@"%@",placeMark.thoroughfare);//当前街道
//                        NSLog(@"%@",placeMark.name);//具体地址
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationDidGetUserLocation object:nil];
        });
    }];
    
}

- (void)getReverseContryCode:(dispatch_block_t)complete {
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:self.strlatitude longitude:self.strlongitude];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    
    //暂时用不到  反地理编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            
            self.currentCity = placeMark.locality;
            self.currentCode = placeMark.ISOcountryCode;
            
            NSString *key = [NSString stringWithFormat:@"DataSta_Client_OpenLocation_Success"];
            NSDictionary *contentJson = @{@"ISOcountryCode":self.currentCode};
            NSDictionary *param = @{@"content":contentJson.mj_JSONString};
            [RyzeMagicStatics ryze_addEventName:key withParams:param];
            //                        /*看需求定义一个全局变量来接收赋值*/
            //                        NSLog(@"----%@",placeMark.country);//当前国家
            //                        NSLog(@"%@",self.currentCity);//当前的城市
            //                        NSLog(@"%@",placeMark.subLocality);//当前的位置
            //                        NSLog(@"%@",placeMark.thoroughfare);//当前街道
            //                        NSLog(@"%@",placeMark.name);//具体地址
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete();
            }
        });
    }];
}

#pragma mark - setter
- (void)setIsInPlayGame:(BOOL)isInPlayGame {
    _isInPlayGame = isInPlayGame;
    if (!isInPlayGame) {
        self.currentGameId = nil;
        self.groupId = nil;
    }
}

#pragma mark - public methods
- (NSString *)getFullCountryNameStr:(NSString *)shortCountryCode {
    if (![shortCountryCode length]) {
        return @"";
    }
    NSString *result = [self.hotCountryDict stringForKey:shortCountryCode];
    if ([result length]) {
        return result;
    }
    result = [self.otherCountryDict stringForKey:shortCountryCode];
    if ([result length]) {
        return result;
    }
    return @"";
}


- (NSString *)getInviteFaceBookFriendUrlString {
    NSString *codeStr = [NSString inviteCodeWithInteger:[[LoginSDKManager shareManager].user.userId integerValue]];
    NSString *urlPath = [FSGlobalLauncher launcher].allKeyDict[@"share_facebook_invite"];
//    NSString *urlStr = [NSString addQueryItemWithKey:@"code" value:codeStr Url:urlPath];
    NSString *urlStr = [NSString addqueryItems:@{} Url:urlPath Paths:codeStr,nil];
    urlStr = [NSString addQueryItemWithKey:@"language" value:[FSSharedLanguages SharedLanguage].language Url:urlStr];
    
    return urlStr;
}


- (NSString *)getInviteFriendUrlString {
    NSString *codeStr = [NSString inviteCodeWithInteger:[[LoginSDKManager shareManager].user.userId integerValue]];
    NSString *urlPath = [FSGlobalLauncher launcher].allKeyDict[@"invite_friend_share"];
    NSString *urlStr = [NSString addQueryItemWithKey:@"code" value:codeStr Url:urlPath];
//    NSString *urlStr = [NSString addqueryItems:@{} Url:urlPath Paths:codeStr];
    urlStr = [NSString addQueryItemWithKey:@"language" value:[FSSharedLanguages SharedLanguage].language Url:urlStr];
    return urlStr;
}

- (NSString *)getTwitterInviteFriendUrlString {
    NSString *codeStr = [NSString inviteCodeWithInteger:[[LoginSDKManager shareManager].user.userId integerValue]];
    NSString *urlPath = [FSGlobalLauncher launcher].allKeyDict[@"share_twitter_invite"];
//    urlPath = [urlPath stringByAppendingPathComponent:codeStr];
    urlPath = [NSString addqueryItems:@{} Url:urlPath Paths:codeStr,nil];
    NSString *urlStr = [NSString addQueryItemWithKey:@"language" value:[FSSharedLanguages SharedLanguage].language Url:urlPath];
    return urlStr;
}

- (void)setAllKeyDict:(NSDictionary *)allKeyDict {
    _allKeyDict = allKeyDict;
    
    if (!_uploaded && [allKeyDict allValues].count != 0) {
        // 提交
        [RyzeMagicStatics ryze_addEventName:@"DataSta_Open_app" withParams:nil];
        [RyzeAspectManager ryze_UploadAllInfo];
        //
        _uploaded = YES;
    }
}


@end
