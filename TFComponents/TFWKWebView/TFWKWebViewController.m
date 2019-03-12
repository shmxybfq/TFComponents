//
//  TFWKWebViewController.m
//  TFComponentsDemo
//
//  Created by Time on 2019/3/12.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFWKWebViewController.h"
#import "TFComponents.h"
#define kWebViewTag 1099
#define kAnimationDuration 0.3
@interface TFWKWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic,  copy)NSString *oldUserAgent;
@property(nonatomic,  copy)TFWKWebViewControllerActionBlock closeActionBlock;


@end

@implementation TFWKWebViewController



#pragma mark 移除观察者
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    [self reload:self.urlString title:self.titleString];
}

#define kTopHeight 64
-(void)initView{
    kdeclare_weakself;
    //初始化
    self.webView = [[TFWKWebView alloc] initWithFrame:CGRectZero];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    self.webView.frame = self.view.bounds;
    
    
    
    
    
    //位置
    //    CGFloat navgationBarHeight = self.hideNavgationBar?0:kTopHeight;
    //    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(weakSelf.view).offset(navgationBarHeight);
    //        make.left.bottom.right.equalTo(weakSelf.view);
    //    }];
    
    //监听网页标题
    [self.webView observerTitle:^(TFWKWebView *webView, NSString *title) {
        [weakSelf.navgationBar.titleButton setTitle:title forState:UIControlStateNormal];
    }];
    
    
    //导航栏
    self.navgationBar.hidden = self.hideNavgationBar;
    [self.view addSubview:self.navgationBar];
    self.navgationBar.backgroundColor = [UIColor whiteColor];
    //    [self.navgationBar mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(weakSelf.view).offset(0);
    //        make.left.right.equalTo(weakSelf.view);
    //        make.height.mas_equalTo(kTopHeight);
    //    }];
    
    //事件
    [self.navgationBar.backButton addTarget:self
                                     action:@selector(backButtonClick:)
                           forControlEvents:UIControlEventTouchUpInside];
    self.navgationBar.closeButton.hidden = self.backClose;
    [self.navgationBar.closeButton addTarget:self
                                      action:@selector(closeButtonClick:)
                            forControlEvents:UIControlEventTouchUpInside];
    
    //监听默认js自定义事件
    [self addDefaultJsActionObserver];
}



-(void)reload:(NSString *)urlString title:(NSString *)titleString{
    if (urlString == nil) {return;}
    self.titleString = titleString;
    if (titleString) {
        [self.navgationBar.titleButton setTitle:titleString forState:UIControlStateNormal];
    }else{
        self.titleString = nil;
    }
    //2.创建请求
    self.urlString = urlString;
    if (urlString) {
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
        request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
        //3.加载网页
        [self.webView loadRequest:request];
    }
}


//默认监听的js事件
-(void)addDefaultJsActionObserver{
    
    __weak typeof(self) weakSelf = self;
    [self.webView addScriptMessageHandlerWithName:kJsToLocalGoBack block:^(WKUserContentController *userContentController, WKScriptMessage *message) {
        if ([weakSelf.webView canGoBack]) {
            [weakSelf.webView goBack];
        }
    }];
    
    [self.webView addScriptMessageHandlerWithName:kJsToLocalPop block:^(WKUserContentController *userContentController, WKScriptMessage *message) {
        if (weakSelf.navigationController) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    [self.webView addScriptMessageHandlerWithName:kJsToLocalPopRoot block:^(WKUserContentController *userContentController, WKScriptMessage *message) {
        if (weakSelf.navigationController) {
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}


-(void)observerNavgationBarCloseAction:(TFWKWebViewControllerActionBlock)block{
    self.closeActionBlock = block;
}

-(void)backButtonClick:(UIButton *)ins{
    if (self.backClose) {
        if (self.closeActionBlock) {
            self.closeActionBlock(self);
        }
        return;
    }
    [self.webView evaluateJavaScript:[NSString stringWithFormat:@"%@('null')",kLocalCanGoBack]
                   completionHandler:nil];
    if ([self.webView canGoBack]) {
        [self.webView evaluateJavaScript:[NSString stringWithFormat:@"%@('null')",kLocalGoBack]
                       completionHandler:nil];
        [self.webView goBack];
    }else{
        if (self.closeActionBlock) {
            self.closeActionBlock(self);
        }
    }
}

-(void)closeButtonClick:(UIButton *)ins{
    if (self.closeActionBlock) {
        self.closeActionBlock(self);
    }
}


-(TFWKWebViewNavBarView *)navgationBar{
    if (_navgationBar == nil) {
        _navgationBar = [[TFWKWebViewNavBarView alloc]initWithFrame:CGRectZero];
    }
    return _navgationBar;
}

-(void)checkShowCloseButton{
    if (self.backClose) {
        self.navgationBar.closeButton.hidden = YES;
        return;
    }
    
    [self.webView evaluateJavaScript:[NSString stringWithFormat:@"%@('null')",kLocalCanGoBack]
                   completionHandler:nil];
    if ([self.webView canGoBack]) {
        self.navgationBar.closeButton.hidden = NO;
    }else{
        self.navgationBar.closeButton.hidden = YES;
    }
}

-(void)setBackClose:(BOOL)backClose{
    _backClose = backClose;
    if (_backClose == YES) {
        self.navgationBar.closeButton.hidden = YES;
    }
}

#pragma mark WKNavigationDelegate -- 代理
//1.WKNavigationDelegate -- 在发送请求之前，决定是否跳转
//相当于UIWebView的
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    //允许或者取消
    if ([navigationAction.request.URL.absoluteString rangeOfString:@"需要跳转页面的url"].location != NSNotFound){
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    [self checkShowCloseButton];
    NSLog(@"001");
}
//2.WKNavigationDelegate -- 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"003");
}
//3.WKNavigationDelegate -- 接收到服务器跳转请求之后调用 (服务器端redirect)，不一定调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"004");
}
//4.WKNavigationDelegate -- 这个方法有一个bug https://blog.csdn.net/yuanmengong886/article/details/55051036
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
    NSLog(@"009");
}
//5.WKNavigationDelegate -- 在收到服务器的响应头，根据response相关信息，决定是否跳转。decisionHandler必须调用，来决定是否跳转，参数WKNavigationActionPolicyCancel取消跳转，WKNavigationActionPolicyAllow允许跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
    NSLog(@"002");
}
//6.WKNavigationDelegate -- 开始获取到网页内容时返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"006");
}
//7.WKNavigationDelegate -- 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [self checkShowCloseButton];
    
    
}
//WKNavigationDelegate -- 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [self checkShowCloseButton];
    NSLog(@"005:error:%@",error);
}
//WKNavigationDelegate --
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"008:error:%@",error);
}
//WKNavigationDelegate --
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    NSLog(@"010");
}


#pragma mark UIDelegate -- 代理
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    completionHandler();
}


@end
