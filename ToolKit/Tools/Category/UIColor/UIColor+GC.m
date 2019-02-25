//
//  UIColor+GC.m
//  FlyShow
//
//  Created by gaochao on 14/12/29.
//  Copyright (c) 2014年 高超. All rights reserved.
//

#import "UIColor+GC.h"


@implementation UIColor (GC)

+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor*) colorWithHex:(NSInteger)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (NSString *) hexFromUIColor: (UIColor*) color {
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    return [NSString stringWithFormat:@"#%x%x%x", (int)((CGColorGetComponents(color.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}

+ (UIColor*) GetColorFromCSSHex:(NSString *)hexColor withAlpha:(CGFloat)alpha{ // #FF3300
    
    if (hexColor == nil || [hexColor isEqualToString:@""]) {
        return nil;
    }
    
    if ([hexColor length] != 7) {
        return nil;
    }
    
    unsigned int red = 255, green = 255, blue = 255;
    NSRange range;
    range.length = 2;
    
    range.location = 1;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:alpha];
}

+ (UIColor*) GetColorFromHexString:(NSString *)hexColor withAlpha:(CGFloat)alp{ // 0XFFFF3300
    
    if (hexColor == nil || [hexColor isEqualToString:@""]) {
        return nil;
    }
    
    if ([hexColor length] != 8 && [hexColor length] != 10) {
        return nil;
    }
    
    int offset = 0;
    unsigned int alpha = alp, red = 255, green = 255, blue = 255;
    NSRange range;
    range.length = 2;
    
    if ([hexColor length] == 10) {
        offset = 2;
        range.location = offset;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&alpha];
    }
    
    range.location = 2 + offset;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 4 + offset;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 6 + offset;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:(float)(alpha/255.0f)];
}

+ (UIColor*) GetColorFromHexString:(NSString *)hexColor{ // 0XFFFF3300
    
    if (hexColor == nil || [hexColor isEqualToString:@""]) {
        return nil;
    }
    
    if ([hexColor length] != 8 && [hexColor length] != 10) {
        return nil;
    }
    
    int offset = 0;
    unsigned int alpha = 255.0, red = 255, green = 255, blue = 255;
    NSRange range;
    range.length = 2;
    
    if ([hexColor length] == 10) {
        offset = 2;
        range.location = offset;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&alpha];
    }
    
    range.location = 2 + offset;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 4 + offset;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 6 + offset;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:(float)(alpha/255.0f)];
}

+ (UIColor*) GetColorFromCSSHex:(NSString *)hexColor { // #FF330000 #FFEE33
    
    if (hexColor == nil || [hexColor isEqualToString:@""]) {
        return nil;
    }
    
    if ([hexColor length] != 7 && [hexColor length] != 9) {
        return nil;
    }
    
    unsigned int  alpha = 255.0,red = 255, green = 255, blue = 255;
    NSRange range;
    range.length = 2;
    
    range.location = 1;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    if (hexColor.length >= 9) {
        range.location = 7;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&alpha];
    }
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:alpha/255.0];
}

+ (UIColor *)colorWithStr:(NSString *)colorStr {
    UIColor *color = nil;
    if([colorStr hasPrefix:@"0x"]){color = [UIColor GetColorFromHexString:colorStr];}
    else if([colorStr hasPrefix:@"#"]) {color = [UIColor GetColorFromCSSHex:colorStr];}
    return color;
}


@end

