//
//  UIViewController+DownloadProgress.h
//  Ready
//
//  Created by mac on 2018/12/27.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLPieProgressView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (DownloadProgress)
@property(nonatomic,strong)UIView * _Nullable downLoadBack;
@property(nonatomic,strong)JLPieProgressView * _Nullable progressView;

- (void)showDownloadProgress:(CGFloat)progress;
// when 1.0 auto hide
- (void)updateDownLoadProgress:(CGFloat)progress;
- (void)hideDownloadProgress;

@end

NS_ASSUME_NONNULL_END
