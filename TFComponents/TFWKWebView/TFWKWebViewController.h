//
//  TFWKWebViewController.h
//  TFComponentsDemo
//
//  Created by Time on 2019/3/12.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFWKWebView.h"
#import "TFWKWebViewNavBarView.h"

//js和原生交互通用函数,此规则适用于所有h5页面
#define kLocalCanGoBack @"localCanGoBack"//本地调用js - canGoBack函数
#define kLocalGoBack @"localGoBack"//本地调用js - goBack函数

#define kJsToLocalGoBack @"jsToLocalGoBack"//js调用本地-页面内返回 - 函数
#define kJsToLocalPop @"jsToLocalPop"//js调用本地-pop控制器 - 函数
#define kJsToLocalPopRoot @"jsToLocalPopRoot"//js调用本地-pop到root - 函数
#define kJsToLocalDismiss @"jsToLocalDismiss"//js调用本地-控制器的dismiss - 函数

@class TFWKWebViewController;
typedef void(^TFWKWebViewControllerActionBlock)(TFWKWebViewController *controller);

@interface TFWKWebViewController : UIViewController

//基本属性
@property(nonatomic,  copy)NSString *urlString;
@property(nonatomic,  copy)NSString *titleString;
@property(nonatomic,strong)TFWKWebView *webView;
@property(nonatomic,strong)TFWKWebViewNavBarView *navgationBar;

//配置属性
//点击返回键是否直接回调返回
@property(nonatomic,assign)BOOL backClose;

@property(nonatomic,assign)BOOL hideNavgationBar;

//刷新链接
-(void)reload:(NSString *)urlString title:(NSString *)titleString;

//监听自定义导航栏或者js导航栏回调
-(void)observerNavgationBarCloseAction:(TFWKWebViewControllerActionBlock)block;


@end


