//
//  UIColor+Image.m
//  Lolly
//
//  Created by Charles on 2017/11/12.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "UIColor+Image.h"

@implementation UIColor (Image)
- (UIImage *)colorImageWithRect:(CGRect)rect {
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillEllipseInRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
- (UIImage *)squareImageWithRect:(CGRect)rect {
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
+ (UIImage *)linerColorsWithRadius:(CGFloat)radius colors:(NSArray *)colors rect:(CGRect)rect {
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    CGContextAddPath(context, path.CGPath);
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CFArrayRef colorsArray = (__bridge CFArrayRef)colors;
    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef, colorsArray,(CGFloat[]){0.0f,1.0f});
    CGContextDrawLinearGradient(context, gradientRef, CGPointMake(0, 0), CGPointMake(1, 0), kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(gradientRef);
    CGColorSpaceRelease(colorSpaceRef);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGContextRelease(context);
    return img;
}
@end
