//
//  UIImage+Tools.h
//  网易彩票
//
//  Created by apple on 19/07/14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>

@interface UIImage (Tools)

-(UIImage *)GaussianBlurImage:(CGFloat)inputRadius;
//根据颜色值生成图像
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/** 将指定图像拉伸 */
+ (UIImage *)stretchImage:(UIImage *)image;

/** 图片旋转 */
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

/** 从自己(大图)中按照指定区域，裁剪出小图 */
- (UIImage *)createImageWithRect:(CGRect)rect;
///有边框的
- (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset withBorderWidth:(CGFloat)width withBorderColor:(UIColor*)color;
///没有边框的
- (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset;

- (UIImage *)blurryImageWithBlurLevel:(CGFloat)blur;


-(UIImage *)blurGCImageWithBlurLevle:(CGFloat)blur;
/** 将指定图像拉伸 */
+ (UIImage *)stretchImageRL:(UIImage *)image;

//压缩制定图像，scaleSize压缩系数 0 - 1
+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

-(UIImage *)scaleImageQuality:(CGFloat )compressionQuality;

- (UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize;

+(UIImage *)getImageFromView:(UIView *)theView;

@end


