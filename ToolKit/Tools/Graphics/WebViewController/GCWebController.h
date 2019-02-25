//
//  GCWebController.h
//  Ready
//
//  Created by mac on 2018/8/18.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseViewController.h"
#import "FSWebView.h"

@interface GCWebController : FSBaseViewController<UIWebViewDelegate>
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *NEWtitle;
@property (nonatomic ,strong) FSWebView *NewWebView;

@end
