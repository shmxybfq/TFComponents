//
//  TFWKWebView.h
//  TFComponentsDemo
//
//  Created by Time on 2019/3/12.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "WKUserContentController+Safe.h"
#import "Const.h"

@class TFWKWebView;
typedef void(^TFWKWebViewTitleBlock)(TFWKWebView *webView,NSString *title);
typedef void(^TFWKWebViewProgressBlock)(TFWKWebView *webView,CGFloat progress);

@interface TFWKWebView : WKWebView

@property (nonatomic,assign)BOOL disuseProgress;

//监听网页的title变化调用此函数
-(void)observerTitle:(TFWKWebViewTitleBlock)block;
//监听网页的请求进度调用此函数
-(void)observerProgress:(TFWKWebViewProgressBlock)block;
//监听js某个函数回调使用此函数
-(void)addScriptMessageHandlerWithName:(NSString *)name block:(WKScriptMessageHandlerBlock)block;

@end


