//
//  UIImage+UIImageScale.h
//  FlyShow
//
//  Created by shawnfeng on 16/3/27.
//  Copyright © 2016年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageScale)
-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
