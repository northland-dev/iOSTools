//
//  UIImage+Crop.h
//  Lolly
//
//  Created by Charles on 2017/11/4.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Crop)
- (UIImage *)cropImageWithRect:(CGRect )rect;
- (UIImage *)cropImageWithRect:(CGRect)frame szie:(CGSize )size;
- (UIImage *)scaleImageWithSize:(CGSize)size;
@end
