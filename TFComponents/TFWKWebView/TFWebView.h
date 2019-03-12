//
//  TFWebView.h
//  TFComponentsDemo
//
//  Created by Time on 2019/3/12.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "WKUserContentController+Safe.h"


@class TFWebView;
typedef void(^TFWebViewTitleBlock)(TFWebView *webView,NSString *title);
typedef void(^TFWebViewProgressBlock)(TFWebView *webView,CGFloat progress);

@interface TFWebView : WKWebView

//是否显示进度条,默认显示
@property (nonatomic,assign)BOOL showProgress;

//监听网页的title变化调用此函数
-(void)observerTitle:(TFWebViewTitleBlock)block;
//监听网页的请求进度调用此函数
-(void)observerProgress:(TFWebViewProgressBlock)block;
//监听js某个函数回调使用此函数
-(void)addScriptMessageHandlerWithName:(NSString *)name block:(WKScriptMessageHandlerBlock)block;


@end


