//
//  FSGlobalEmptyDataView.h
//  Ready
//
//  Created by gongruike on 2018/9/3.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSGlobalEmptyDataView : UIView

@property (nonatomic, strong) CAGradientLayer   *backgroundLayer;

@property (nonatomic, strong) UILabel           *titleLabel;
@property (nonatomic, strong) UIImageView       *imageView;

@property (nonatomic, copy) dispatch_block_t    block;

- (void)setTitleString:(NSString *)string;

@end
