//
//  FSPhotoBrowserController.h
//  Lolly
//
//  Created by Charles on 2017/11/11.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSBaseViewController.h"

@interface FSPhotoBrowserController : FSBaseViewController
/**
 *  是否显示底部工具栏 默认显示
 **/
@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,assign)BOOL allowsEditing;
//
@property(nonatomic,assign)BOOL showSetHeaderButton;

- (void)deleteCurrentImage:(UIButton *)button;
- (void)makeCurrentImageAHeader:(UIButton *)button;

// tested Interface
@property(nonatomic,strong)UIImage *originalImage;
@end
