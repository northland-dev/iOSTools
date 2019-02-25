//
//  UIColor+GC.h
//  FlyShow
//
//  Created by gaochao on 14/12/29.
//  Copyright (c) 2014年 高超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (GC)
+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSInteger)hexValue;
+ (NSString *) hexFromUIColor: (UIColor*) color;

+ (UIColor*) GetColorFromCSSHex:(NSString *)hexColor;
+ (UIColor*) GetColorFromCSSHex:(NSString *)hexColor withAlpha:(CGFloat)alpha;

+ (UIColor*) GetColorFromHexString:(NSString *)hexColor;
+ (UIColor*) GetColorFromHexString:(NSString *)hexColor withAlpha:(CGFloat)alpha;

+ (UIColor *)colorWithStr:(NSString *)colorStr;

@end
