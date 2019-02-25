//
//  FSWebViewController.h
//  JYD
//
//  Created by luyee on 15/11/30.
//  Copyright © 2015年 JYD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseViewController.h"
#import <WebKit/WebKit.h>


@interface FSWebViewController : FSBaseViewController
@property( nonatomic, strong) WKWebView *wkwebView;
@property (nonatomic,copy)NSString *urlString;
@property (nonatomic,assign)NSString *activityTitle;
//文章分享特殊处理
@property (nonatomic,assign) BOOL needRightShareBtn;
@property (nonatomic,strong) WKWebViewConfiguration *config;

- (void)reloadWebView;

- (void)loadRequest;

- (NSArray *)funcNameArr;

@end
