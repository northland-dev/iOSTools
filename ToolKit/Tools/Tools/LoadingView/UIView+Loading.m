//
//  UIView+Loading.m
//  Lolly
//
//  Created by Charles on 2017/11/7.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "UIView+Loading.h"
#import <objc/runtime.h>
#import "FSLoadingView.h"

@interface UIView(GCLoadingExtesion)
@property(nonatomic,strong)FSLoadingView *viewloadingView;
@end

@implementation UIView (viewLoading)

- (FSLoadingView *)viewloadingView {
    return objc_getAssociatedObject(self,_cmd);
}

- (void)setLoadingView:(FSLoadingView *)viewloadingView {
    objc_setAssociatedObject(self, @selector(viewloadingView), viewloadingView, OBJC_ASSOCIATION_RETAIN);
}

- (void)layoutSubviews {
    [self.viewloadingView setFrame:self.bounds];
}

- (void)showLoading {
    if (!self.viewloadingView) {
        FSLoadingView *loadingView = [[FSLoadingView alloc] initWithFrame:self.bounds];
        [self setLoadingView:loadingView];
    }
    [self.viewloadingView loadingViewShow];
    [self addSubview:self.viewloadingView];
}

- (void)hideLoading {
    [self.viewloadingView loadingViewhide];
    [self.viewloadingView removeFromSuperview];
}

- (BOOL)isLoading {
    return [self.viewloadingView isLoading];
}
@end
