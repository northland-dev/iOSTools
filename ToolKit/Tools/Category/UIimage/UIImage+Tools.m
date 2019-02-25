//
//  UIImage+Tools.m
//  网易彩票
//
//  Created by apple on 19/07/14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+Tools.h"
#import "GPUImage.h"

@implementation UIImage (Tools)

// 高斯模糊
-(UIImage *)GaussianBlurImage:(CGFloat)inputRadius
{
//    CGSize imageSize = self.size;
//    CGFloat scale = (ScreenF.size.width / ScreenF.size.height);
//    CGFloat imageRx = imageSize.width * (1 - scale)/2.0;
//    CGFloat imageRw = imageSize.width *scale;
//    CGRect BgRect = CGRectMake(imageRx,0,imageRw,imageSize.height);
//    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, BgRect);
//    UIImage *blurredImage = [UIImage imageWithCGImage:imageRef];
//    CGImageRelease(imageRef);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithCGImage:self.CGImage];
    // create gaussian blur filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:inputRadius] forKey:@"inputRadius"];
    // blur image
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    UIImage *blurredImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    filter = nil;
    inputImage = nil;
    result = nil;
    
    
//    GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
//    blurFilter.blurRadiusInPixels = 10.0;
//    UIImage *blurredImage = [blurFilter imageByFilteringImage:self];
    return blurredImage;
}
+ (UIImage *)stretchImage:(UIImage *)image
{
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
+ (UIImage *)stretchImageRL:(UIImage *)image
{
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:0];
}
- (UIImage *)blurryImageWithBlurLevel:(CGFloat)blur {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputImageKey, inputImage, @"inputRadius", @(blur),nil];
    CIImage *outputImage = filter.outputImage;
    CGImageRef outImage = [context createCGImage:outputImage fromRect:[inputImage extent]];
    return [UIImage imageWithCGImage:outImage];
    
}
- (UIImage *)createImageWithRect:(CGRect)rect
{
    // 使用指定的区域，从一张大图中截取出小的图片
    // CG Core Graphics 是属于系统底层的API，针对"像素"进行操作的
    // "渐进" 如果是使用C语言的框架，如果有create,retain,copy字样创建的对象
    // 需要手动释放！需要释放什么类型，先敲一下，然后跟release
    __weak UIImage *weakSelf = self;
    CGImageRef imageRef = CGImageCreateWithImageInRect(weakSelf.CGImage, rect);
    
    // 生成图像
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    // 释放内存
//    CGImageRelease(imageRef);
    CGImageRelease(imageRef);
    
    
    
    
    
    
//    CGSize size = CGSizeMake(rect.size.height, rect.size.height);
//    UIGraphicsBeginImageContext(size);
//    [self drawInRect:rect];
//    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    imageRef = nil;
    

    return image;
}
- (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset
{
    return [self ellipseImage:image withInset:inset withBorderWidth:inset withBorderColor:[UIColor whiteColor]];
}

- (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset withBorderWidth:(CGFloat)width withBorderColor:(UIColor*)color
{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f , image.size.height - inset * 2.0f);
    
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [image drawInRect:rect];
    
    if (width > 0) {
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextSetLineCap(context,kCGLineCapButt);
        CGContextSetLineWidth(context, width);
        CGContextAddEllipseInRect(context, CGRectMake(inset + width/2, inset +  width/2, image.size.width - width- inset * 2.0f, image.size.height - width - inset * 2.0f));//在这个框中画圆
        
        CGContextStrokePath(context);
    }
    
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,
                                   
                                   color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}
+ (UIImage *)getGpuImage:(UIImage *)image{
    //    UIGraphicsBeginImageContext(image.size);
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImage;
}
-(UIImage *)blurGCImageWithBlurLevle:(CGFloat)blur
{
        //模糊度,
        if ((blur < 0.1f) || (blur > 2.0f)) {
            blur = 0.5f;
        }
        
        //boxSize必须大于0
        int boxSize = (int)(blur * 100);
        boxSize -= (boxSize % 2) + 1;
        NSLog(@"boxSize:%i",boxSize);
        //图像处理
        CGImageRef img = self.CGImage;
        //需要引入#import <Accelerate/Accelerate.h>
        /*
         This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal processing, large number handling, and image processing.
         本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
         */
        
        //图像缓存,输入缓存，输出缓存
        vImage_Buffer inBuffer, outBuffer;
        vImage_Error error;
        //像素缓存
        void *pixelBuffer;
        
        //数据源提供者，Defines an opaque type that supplies Quartz with data.
        CGDataProviderRef inProvider = CGImageGetDataProvider(img);
        // provider’s data.
        CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
        
        //宽，高，字节/行，data
        inBuffer.width = CGImageGetWidth(img);
        inBuffer.height = CGImageGetHeight(img);
        inBuffer.rowBytes = CGImageGetBytesPerRow(img);
        inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
        
        //像数缓存，字节行*图片高
        pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
        
        outBuffer.data = pixelBuffer;
        outBuffer.width = CGImageGetWidth(img);
        outBuffer.height = CGImageGetHeight(img);
        outBuffer.rowBytes = CGImageGetBytesPerRow(img);
        
        
        // 第三个中间的缓存区,抗锯齿的效果
        void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
        vImage_Buffer outBuffer2;
        outBuffer2.data = pixelBuffer2;
        outBuffer2.width = CGImageGetWidth(img);
        outBuffer2.height = CGImageGetHeight(img);
        outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
        
        //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
        error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        
        
        if (error) {
            NSLog(@"error from convolution %ld", error);
        }
        
        //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
        //颜色空间DeviceRGB
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
        CGContextRef ctx = CGBitmapContextCreate(
                                                 outBuffer.data,
                                                 outBuffer.width,
                                                 outBuffer.height,
                                                 8,
                                                 outBuffer.rowBytes,
                                                 colorSpace,
                                                 CGImageGetBitmapInfo(self.CGImage));
        
        //根据上下文，处理过的图片，重新组件
        CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
        UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
        
        //clean up  
        CGContextRelease(ctx);  
        CGColorSpaceRelease(colorSpace);  
        
        free(pixelBuffer);  
        free(pixelBuffer2);  
        CFRelease(inBitmapData);  
        
        CGColorSpaceRelease(colorSpace);  
        CGImageRelease(imageRef);  
        
        return returnImage;  
    
}

+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *data = UIImageJPEGRepresentation(scaledImage,0.2);
    UIImage *imageNew = [UIImage imageWithData:data];
    return imageNew;
}
-(UIImage *)scaleImageQuality:(CGFloat )compressionQuality
{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width*compressionQuality,self.size.height*compressionQuality));
    [self drawInRect:CGRectMake(0, 0, self.size.width * compressionQuality, self.size.height *compressionQuality)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *data = UIImageJPEGRepresentation(scaledImage,1);
    UIImage *imageNew = [UIImage imageWithData:data];
    return imageNew;
}
- (UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize{
    newSize.height=image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
    
}

+(UIImage *)getImageFromView:(UIView *)theView{
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, YES, theView.layer.contentsScale);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
