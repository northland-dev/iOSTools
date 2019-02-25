//
//  FSBaseViewController.m
//  Ready
//
//  Created by jiapeng on 2018/7/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "FSBaseViewController.h"
#import "FSNetworkReachabilityManager.h"

@interface FSBaseViewController ()
@property(nonatomic,strong)CAGradientLayer *gradientLayer;
@end

@implementation FSBaseViewController

- (EventHandler *)eventHandler{
    if (!_eventHandler) {
        _eventHandler = [[EventHandler alloc] init];
        [_eventHandler setDelegate:self];
    }
    return _eventHandler;
}

-(EventHandler *)eventHandlerSelf{
    if (!_eventHandlerSelf) {
        _eventHandlerSelf = [[EventHandler alloc] init];
        [_eventHandlerSelf setDelegate:self];
    }
    return _eventHandlerSelf;
}

-(void)didReciveEvent:(NSInteger)eventType withObject:(id)object{
    for (id eventObject in self.eventHandler.eventList) {
        if ([eventObject respondsToSelector:@selector(didReciveEvent:withObject:)]) {
            [eventObject didReciveEvent:eventType withObject:object];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CAGradientLayer *gradientlayer = [CAGradientLayer layer];
    [gradientlayer setFrame:self.view.bounds];
    [gradientlayer setStartPoint:CGPointMake(0, 0)];
    [gradientlayer setEndPoint:CGPointMake(0, 1)];
    [gradientlayer setColors:[NSArray arrayWithObjects:(__bridge id)HexRGBAlpha(0xFFF100,1.0).CGColor,(__bridge id)HexRGBAlpha(0xF8C22D, 1.0).CGColor,nil]];
    [self.view.layer addSublayer:gradientlayer];
    _gradientLayer = gradientlayer;
    
    [self.view setBackgroundColor:HexRGB(0xFCFCF6)];
    
    if ([self needShowLeftBackItem]) {
        [self initBackItem];
    }
    
    [self.view setClipsToBounds:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageDidChanage) name:kNSNotificationLanguageChanged object:nil];
    
    // No network status view
    [self.networkStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(33);
    }];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onReceivedNetworkStatusChangedNoti:)
                                                 name:AFNetworkingReachabilityDidChangeNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
//    self.navigationController.interactivePopGestureRecognizer.enabled = [self shouldEnableInteractivePopGestureRecognizer];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![FSNetworkReachabilityManager sharedManager].isReachable) {
        [self showNoNetworkStatusView];
    }
}

- (void)initBackItem {
    /* */
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    backButton.frame =CGRectMake(0, 0, 50, 30);
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0,-16,0,0);
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    backButton.contentMode =UIViewContentModeScaleAspectFit;
    [backButton setImage:[UIImage imageNamed:@"Nav_back"] forState:(UIControlStateNormal)];
    [backButton setBackgroundColor:[UIColor clearColor]];
    [backButton addTarget:self action:@selector(popSelfController) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)popSelfController {
    if ([self shouldPopToRoot]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)languageDidChanage {
    
}
- (BOOL)shouldPopToRoot {
    return NO;
}
- (BOOL)needShowLeftBackItem {
    return YES;
}

- (void)hiddenGradient {
    [_gradientLayer setHidden:YES];
}
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isEqual:self.navigationController.interactivePopGestureRecognizer]) {
        if (self.navigationController.viewControllers.count == 1) {
            return NO;
        }else{
            return [self shouldEnableInteractivePopGestureRecognizer];
        }
    }
    return YES;
}
- (BOOL)shouldEnableInteractivePopGestureRecognizer {
    return YES;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNSNotificationLanguageChanged object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - network related
- (FSNetworkStatusView *)networkStatusView {
    if (!_networkStatusView) {
        _networkStatusView = [[FSNetworkStatusView alloc] init];
        _networkStatusView.hidden = YES;
        [self.view addSubview:_networkStatusView];
    }
    return _networkStatusView;
}

- (void)showNoNetworkStatusView {
    // in case language changed
    self.networkStatusView.textLabel.text = [FSSharedLanguages CustomLocalizedStringWithKey:@"MessageList_NetworkDisconnected"];
    self.networkStatusView.hidden = NO;
    [self.networkStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(33);
    }];
    [self.view addSubview:_networkStatusView];
}

- (void)hideNoNetworkStatusView {
    self.networkStatusView.hidden = YES;
    [self.networkStatusView removeFromSuperview];
    _networkStatusView = nil;
}

#pragma mark - network status noti
- (void)onReceivedNetworkStatusChangedNoti:(NSNotification *)noti {
    AFNetworkReachabilityStatus status = [[noti.userInfo objectForKey:AFNetworkingReachabilityNotificationStatusItem] integerValue];
    if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
        [self hideNoNetworkStatusView];
    } else {
        [self showNoNetworkStatusView];
    }
}
- (void)releaseSomeObjects {}
@end
