//
//  FSFunctionsHeader.h
//  Ready
//
//  Created by jiapeng on 2018/7/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#ifndef FSFunctionsHeader_h
#define FSFunctionsHeader_h

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define WeakSelf(type)  __weak typeof(type) weak##type = type

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPad ([[UIScreen mainScreen] currentMode].size.width/[[UIScreen mainScreen] currentMode].size.height>0.7)
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define FirstInstallAppKey @"FirstInstallAppKey"

#define ScreenW [[UIScreen mainScreen] bounds].size.width
#define ScreenH [[UIScreen mainScreen] bounds].size.height

#define SafeAreaTopHeight (ScreenH == 812.0 ? 88 : 64)
#define SafeAreaInsetTop (ScreenH == 812.0 ? 44 : 20)
#define SafeAreaBottomHeight (ScreenH == 812.0 ? 34 : 0)
#define SafeAreaTopHeightWithoutStatebar (ScreenH == 812.0 ? 24 : 0)
#define SafeAreaInsetBottom (ScreenH == 812.0 ? 34 : 0)
#define NavHeight (44.0)

#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define Request_Faild(object) ([object isKindOfClass:NSNumber.class] || [object isKindOfClass:NSError.class])

#define GCDEALLOCLOG  NSLog(@"%@ %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
#define GCDEALLOC()  - (void)dealloc { GCDEALLOCLOG }

#endif /* FunctionsHeader_h */

//禁止Log输出
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}

//#define GCLog(...) NSlog(@"gc:%@",__VA_ARGS__)

//#define GCDEALLOCLOGS \
//- (void)dealloc { \
//    NSLog(@"gc:%@ %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd)); \
//}

//#define GCLogAllIvars \
//-(NSString *)description \
//{ \
//return [self mj_keyValues].description; \
//}

#endif /* FSFunctionsHeader_h */
