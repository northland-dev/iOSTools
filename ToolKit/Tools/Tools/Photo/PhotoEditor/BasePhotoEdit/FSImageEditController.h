//
//  FSImageEditController.h
//  Lolly
//
//  Created by Charles on 2017/11/4.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSImageEditController : UIViewController

@property(nonatomic,strong,readonly)UIView *mediumBack;

@property(nonatomic,strong)UIImage *image;

// 源图
- (UIImage *)sourceImage;
// 调整之后的切图
- (UIImage *)cropedImage;

@end
