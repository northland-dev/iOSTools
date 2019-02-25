//
//  UIBarButtonItem+GC.m
//  FlyShow
//
//  Created by 高超的开发 on 14-8-25.
//  Copyright (c) 2014年 牟亚军. All rights reserved.
//

#import "UIBarButtonItem+GC.h"

@implementation UIBarButtonItem (GC)
+ (UIBarButtonItem *)barButtonWithImageName:(NSString *)imageName WithSel:(SEL)selName
{
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backButtonImage = [UIImage imageNamed:imageName];
    CGSize imageSize = backButtonImage.size;
    backButton.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
    [backButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backButton addTarget:self action:selName forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return leftButton;
}
@end
