//
//  FSWebViewController.m
//  JYD
//
//  Created by luyee on 15/11/30.
//  Copyright © 2015年 JYD. All rights reserved.
//

#import "FSWebViewController.h"

#import <WebKit/WebKit.h>

#import <JavaScriptCore/JavaScriptCore.h>

#import "AppDelegate.h"

@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, assign) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

@implementation WeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}


#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSLog(@"didReceiveScriptMessage  name: %@ message %@",message.name,message.body);
    
    if (self.scriptDelegate) {
        SEL method = NSSelectorFromString(message.name);
        SEL method_ = NSSelectorFromString([message.name stringByAppendingString:@":"]);
        
        if ([self.scriptDelegate respondsToSelector:method]) {
            
            [self.scriptDelegate performSelector:method];
            
        }else if([self.scriptDelegate respondsToSelector:method_]){
            
            [self.scriptDelegate performSelector:method_ withObject:message.body];
            
        }
    }
}

@end


@interface FSWebViewController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler, UIAlertViewDelegate>

@end

@implementation FSWebViewController
{
    WKUserContentController* userContentController;
}

- (NSArray *)funcNameArr{
    return @[];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addWkWebView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)addWkWebView {
    self.wkwebView = [[WKWebView alloc] initWithFrame:self.view.bounds  configuration:self.config];
    self.wkwebView.navigationDelegate = self;
    self.wkwebView.UIDelegate = self;
    if (@available(iOS 11.0,*)) {
        [self.wkwebView.scrollView setContentInsetAdjustmentBehavior:(UIScrollViewContentInsetAdjustmentNever)];
    }else{
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    [self.view addSubview:self.wkwebView];
    
    [self.wkwebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)loadRequest{
//    NSURL *url = [NSURL URLWithString:[self.urlString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]];
   NSURL *url = [self.urlString mj_url];
    NSLog(@"game_url\n%@", url);
    
    NSMutableDictionary*cookieProperties =[NSMutableDictionary dictionary];
    [cookieProperties setObject:@"username" forKey:NSHTTPCookieName];
    [cookieProperties setObject:@"false" forKey:@"HttpOnly"];
    NSHTTPCookie *cookie =[NSHTTPCookie cookieWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:@"false",@"HttpOnly", nil]];
//    NSHTTPCookie *cookie =[NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    NSHTTPCookie *cookieWID = [NSHTTPCookie cookieWithProperties:[NSDictionary dictionaryWithObjectsAndKeys: @"wid" ,NSHTTPCookieName,  @"",NSHTTPCookiePath, @"false",@"HttpOnly", nil]];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage]setCookie:cookieWID];
    NSArray *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    //Cookies数组转换为requestHeaderFields
    NSDictionary *requestHeaderFields = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    
    //设置请求头


    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:30];
    request.allHTTPHeaderFields = requestHeaderFields;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.wkwebView loadRequest:request];
    });
}

- (WKWebViewConfiguration *)config{
    if (!_config) {
        _config = [[WKWebViewConfiguration alloc] init];
        _config.preferences.minimumFontSize = 10;
        _config.preferences.javaScriptEnabled = YES;
        _config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        for (NSString *funcName in [self funcNameArr]) {
            [_config.userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:funcName];
        }
    }
    
    return _config;
    
}

-(BOOL)additionBeforeBack{
    return YES;
}
#pragma mark - reloadWebView
- (void)reloadWebView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
        [self.wkwebView loadRequest:request];
    });
}

#pragma mark - WKWebViewDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    if ([webView.URL.absoluteString isEqualToString:self.urlString]) {
        
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable resulting, NSError * _Nullable error) {
        self.title = resulting;
    }];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if (error) {
        NSLog(@"webViewDidFailNavigation === %@",error);
        if (error.code == NSURLErrorCancelled) {
            return;
        }
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    completionHandler();
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
    }
}
#pragma mark - 释放
-(void)dealloc
{
    NSLog(@"FSWebViewCtrl 销毁了");
}

@end
