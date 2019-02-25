//
//  FSBaseViewController.h
//  Ready
//
//  Created by jiapeng on 2018/7/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+FSContainerController.h"
#import "FSNetworkStatusView.h"

@interface FSBaseViewController : UIViewController <EventHandlerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) EventHandler *eventHandler;
@property (nonatomic, strong) EventHandler *eventHandlerSelf;

@property (nonatomic, strong) FSNetworkStatusView    *networkStatusView;

- (void)languageDidChanage;
- (void)initBackItem;
- (void)hiddenGradient;
- (BOOL)needShowLeftBackItem;
- (BOOL)shouldPopToRoot;
- (void)popSelfController;

- (void)releaseSomeObjects;

- (BOOL)shouldEnableInteractivePopGestureRecognizer;

- (void)showNoNetworkStatusView;
- (void)hideNoNetworkStatusView;

@end
