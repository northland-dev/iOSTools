//
//  UIFont+FSProxima.m
//  YikeTalks
//
//  Created by jiapeng on 2018/3/14.
//  Copyright © 2018年 yike. All rights reserved.
//

#import "UIFont+FSProxima.h"
#import <CoreText/CoreText.h>

@implementation UIFont (FSProxima)

+ (UIFont *)proximaFontOfSize:(CGFloat)fontSize {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ProximaNovaSoft-Regular" ofType:@"otf"];
    if (!bundlePath) {
        return [UIFont systemFontOfSize:fontSize];
    }
    return [UIFont customFontWithPath:bundlePath size:fontSize];
}
+ (UIFont *)blodProximaFontOfSize:(CGFloat)fontSize {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ProximaNovaSoft-Bold" ofType:@"otf"];
    if (!bundlePath) {
        return [UIFont systemFontOfSize:fontSize];
    }
    return  [UIFont customFontWithPath:bundlePath size:fontSize];
}
+ (UIFont *)mediumProximaFontOfSize:(CGFloat)fontSize {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ProximaNovaSoft-Medium" ofType:@"otf"];
    if (!bundlePath) {
        return [UIFont systemFontOfSize:fontSize];
    }
    return  [UIFont customFontWithPath:bundlePath size:fontSize];
}
+ (UIFont *)semiBoldProximaFontOfSize:(CGFloat)fontSize {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ProximaNovaSoft-Semibold" ofType:@"otf"];
    if (!bundlePath) {
        return [UIFont systemFontOfSize:fontSize];
    }
    return  [UIFont customFontWithPath:bundlePath size:fontSize];
}

+ (UIFont *)boldDINCondensFontOfSize:(CGFloat)fontSize {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"DINCondensed-Bold" ofType:@"ttf"];
    if (!bundlePath) {
        return [UIFont systemFontOfSize:fontSize];
    }
    return [UIFont customFontWithPath:bundlePath size:fontSize];
}

+ (UIFont *)customFontWithPath:(NSString*)path size:(CGFloat)size {
    NSURL *fontUrl = [NSURL fileURLWithPath:path];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    UIFont *font = [UIFont fontWithName:fontName size:size];
    CGFontRelease(fontRef);
    return font;
}

@end
