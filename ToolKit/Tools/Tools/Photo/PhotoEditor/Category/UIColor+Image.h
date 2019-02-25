//
//  UIColor+Image.h
//  Lolly
//
//  Created by Charles on 2017/11/12.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Image)
- (UIImage *)colorImageWithRect:(CGRect)rect;
- (UIImage *)squareImageWithRect:(CGRect)rect;
+ (UIImage *)linerColorsWithRadius:(CGFloat)radius colors:(NSArray *)colors rect:(CGRect)rect;
@end
