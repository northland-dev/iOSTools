//
//  UIImageView+Loading.h
//  Ready
//
//  Created by mac on 2018/9/12.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Loading)
@property(nonatomic,strong)UIActivityIndicatorView *indicator;

- (void)startLoadAnimation;

- (void)stopLoadAnimation;
@end
