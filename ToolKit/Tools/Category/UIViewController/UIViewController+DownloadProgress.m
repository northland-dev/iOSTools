//
//  UIViewController+DownloadProgress.m
//  Ready
//
//  Created by mac on 2018/12/27.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "UIViewController+DownloadProgress.h"

@implementation UIViewController (DownloadProgress)

- (void)showDownloadProgress:(CGFloat)progress {
    if (!self.progressView) {
        UIView *back = [UIView new];
        [back setBackgroundColor:HexRGBAlpha(0x000000, 0.3)];
        UIWindow *currentWindow = self.view.window;
        [currentWindow addSubview:back];
        [self setDownLoadBack:back];
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(currentWindow);
        }];
        
        JLPieProgressView *progressView = [[JLPieProgressView alloc] init];
        [back addSubview:progressView];
        [self setProgressView:progressView];
        
        [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.centerX.equalTo(currentWindow.mas_centerX);
            make.centerY.equalTo(currentWindow.mas_centerY);
        }];
    }
}
- (void)updateDownLoadProgress:(CGFloat)progress {
    [self.progressView setProgressValue:progress];
    if (progress >= 1.0) {
        [self hideDownloadProgress];
    }
}
- (void)hideDownloadProgress {
    [self.downLoadBack removeFromSuperview];
    [self setDownLoadBack:nil];
    [self setProgressView:nil];
}
#pragma mark - getter
- (UIView *)downLoadBack {
    UIView *back = objc_getAssociatedObject(self, _cmd);
    return back;
}
- (JLPieProgressView *)progressView {
    JLPieProgressView *progressView = objc_getAssociatedObject(self, _cmd);
    return progressView;
}
#pragma mark - setter
- (void)setDownLoadBack:(UIView *)downLoadBack {
    objc_setAssociatedObject(self, @selector(downLoadBack), downLoadBack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setProgressView:(JLPieProgressView *)progressView {
    objc_setAssociatedObject(self, @selector(progressView), progressView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
