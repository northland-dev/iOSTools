//
//  FSToasManager.m
//  Ready
//
//  Created by jiapeng on 2018/9/4.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSToasManager.h"

@implementation FSToasManager

static FSToasManager *shareInstance;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[FSToasManager alloc] init];
    });
    return shareInstance;
}

-(void)showToastWithTitle:(NSString *)titleString message:(NSString *)messageString {
    
    FFToast *toast = [[FFToast alloc]initToastWithTitle:titleString message:messageString iconImage:nil];
    toast.duration = 2.f;
    toast.toastType = FFToastTypeDefault;
    toast.toastPosition = FFToastPositionBottomWithFillet;
    
    [toast show];
}

-(void)showToastWithTitle:(NSString *)titleString message:(NSString *)messageString position:(FFToastPosition)Position{
    
    FFToast *toast = [[FFToast alloc]initToastWithTitle:titleString message:messageString iconImage:nil];
    toast.duration = 2.f;
    toast.toastType = FFToastTypeDefault;
    toast.toastPosition = Position;
    
    [toast show];
}

@end
