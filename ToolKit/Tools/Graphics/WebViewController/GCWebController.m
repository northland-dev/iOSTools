//
//  GCWebController.m
//  Ready
//
//  Created by mac on 2018/8/18.
//  Copyright © 2018年 Fission. All rights reserved.
//

#import "GCWebController.h"

#import "FSLoadingView.h"
#import "FSUserInfoModel.h"

@interface GCWebController ()<UIScrollViewDelegate>
@property (nonatomic ,strong) FSLoadingView *loadingView;
@end

@implementation GCWebController

- (FSWebView *)NewWebView {
    if (!_NewWebView) {
        _NewWebView = [[FSWebView alloc] init];
        [_NewWebView setDelegate:self];
        [_NewWebView setOpaque:NO];
        [_NewWebView setScalesPageToFit:YES];
        [_NewWebView setAutoresizesSubviews:YES];
        [_NewWebView setBackgroundColor:[UIColor clearColor]];
         _NewWebView.allowsInlineMediaPlayback = YES;
        
        [_NewWebView.scrollView setShowsVerticalScrollIndicator:YES];
        [_NewWebView.scrollView setBounces:NO];
    }
    return _NewWebView;
}

-(FSLoadingView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [[FSLoadingView alloc] initWithFrame:self.view.bounds];
    }
    return _loadingView;
}

- (void)showLoadingHidden:(BOOL)hidden{
    if (!hidden) {
        [self.view addSubview:self.loadingView];
        [self.loadingView loadingViewShow];
    } else {
        [self.loadingView loadingViewhide];
    }
}

- (void)setUrl:(NSString *)url
{
    url = [url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *origalUrl = url;
    if (!url) {
        return;
    }
    url = [url mj_url].absoluteString;
    NSURLComponents *componets = [NSURLComponents componentsWithString:url];
    // scheme
    if (!componets.scheme) {
        componets.scheme = @"http";
    }
    
    if(!componets.host){
        componets.host = origalUrl;
    }
    
    NSString *query = componets.query?:@"";
    
    FSUserInfoModel *userInfo = (FSUserInfoModel *)[LoginSDKManager shareManager].user;
    NSString *token = userInfo.token.length?userInfo.token:@"";
    NSString *userId = userInfo.userId.length?userInfo.userId:@"";
    NSString *countryPath = [userInfo valueForKeyPath:@"country"];
    NSString *country = countryPath?countryPath:@"";
    NSURLQueryItem *tokenQuery = [[NSURLQueryItem alloc] initWithName:@"token" value:token];
    NSURLQueryItem *uidQuery = [[NSURLQueryItem alloc] initWithName:@"uid" value:userId];
    NSURLQueryItem *languageQuery = [[NSURLQueryItem alloc] initWithName:@"lan" value:[FSSharedLanguages SharedLanguage].language];
    NSURLQueryItem *typeQuery = [[NSURLQueryItem alloc] initWithName:@"_t" value:@"100"];
    NSURLQueryItem *appQuery = [[NSURLQueryItem alloc] initWithName:@"_app" value:@"1"];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];

    NSArray *originalItems = componets.queryItems?:@[];
    NSMutableArray *addQuery = [NSMutableArray arrayWithObjects:tokenQuery,uidQuery,languageQuery,typeQuery,appQuery,countryQuery,nil];
    [addQuery addObjectsFromArray:originalItems];
    componets.queryItems = addQuery;
    _url = componets.URL.absoluteString;
}

- (void)setNEWtitle:(NSString *)NEWtitle
{
    _NEWtitle = NEWtitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    self.title = _NEWtitle;
    
    [self.view addSubview:self.NewWebView];
    WS(weaks);
    [self.NewWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weaks.view);
    }];
    [self.NewWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url] cachePolicy:(NSURLRequestReloadIgnoringLocalCacheData) timeoutInterval:60]];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.NewWebView setupShouldRequireFailureOfGestureRecognizer:self.navigationController.interactivePopGestureRecognizer];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self showLoadingHidden:YES];
    NSLog(@"webView error %@",error);
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self showLoadingHidden:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self showLoadingHidden:NO];
}
- (void)popSelfController {
    if ([self.NewWebView canGoBack]) {
        [self.NewWebView goBack];
    }else{
        [super popSelfController];
    }
}
@end
