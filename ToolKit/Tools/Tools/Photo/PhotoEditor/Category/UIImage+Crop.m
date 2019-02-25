//
//  UIImage+Crop.m
//  Lolly
//
//  Created by Charles on 2017/11/4.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "UIImage+Crop.h"

@implementation UIImage (Crop)

- (UIImage *)cropImageWithRect:(CGRect)frame {
    UIImage *croppedImage = nil;
    CGPoint drawPoint = CGPointZero;
    UIGraphicsBeginImageContextWithOptions(frame.size, YES, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -frame.origin.x, -frame.origin.y);
    [self drawAtPoint:drawPoint];
    croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return croppedImage;
}
- (UIImage *)cropImageWithRect:(CGRect)frame szie:(CGSize)size{
    UIImage *croppedImage = nil;
    CGPoint drawPoint = CGPointZero;
    UIGraphicsBeginImageContextWithOptions(frame.size, YES, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -frame.origin.x, -frame.origin.y);
    [self drawAtPoint:drawPoint];
    croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(size);
    [croppedImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return croppedImage;
}
- (UIImage *)scaleImageWithSize:(CGSize)size {
    UIImage *croppedImage = nil;
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return croppedImage;
}
@end
