//
//  FSPageScrollView.h
//  Ready
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSBaseView.h"

@interface FSPageScrollView : FSBaseView
@property(nonatomic,strong)UIScrollView *contentView;
@property(nonatomic,strong)UIPageControl *pageControl;

- (void)layoutContentView;

- (void)layoutPageControl;

@end
