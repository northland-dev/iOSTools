//
//  FSPageScrollView.m
//  Ready
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSPageScrollView.h"
#import "UIColor+Image.h"
@interface FSPageScrollView()<UIScrollViewDelegate>

@end
@implementation FSPageScrollView

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        [_contentView setDelegate:self];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        [_contentView setPagingEnabled:YES];
        [_contentView setShowsHorizontalScrollIndicator:NO];
        [self addSubview:_contentView];
    }
    return _contentView;
}
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        [_pageControl setHidesForSinglePage:YES];
        [_pageControl setCurrentPageIndicatorTintColor:HexRGB(0xFFF100)];
        [_pageControl setPageIndicatorTintColor:HexRGB(0xD8D8D8)];
        [self addSubview:_pageControl];
    }
    return _pageControl;
}
- (void)createSubviews {
    [super createSubviews];
    
    [self layoutContentView];
    
    [self layoutPageControl];
}
- (void)layoutContentView {
    WS(weaks);
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weaks);
        make.width.equalTo(weaks.mas_width);
        make.height.equalTo(weaks.mas_height);
    }];
}
- (void)layoutPageControl {
    WS(weaks);
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weaks);
        make.width.equalTo(weaks.mas_width);
        make.height.mas_equalTo(6.0);
        make.bottom.equalTo(weaks.mas_bottom).offset(-6.0);
    }];
}
#pragma mark -
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    // 不使用get方法是因为 pageControl 在子类中不一定创建
    [_pageControl setCurrentPage:offset.x / bounds.size.width];
}
@end
