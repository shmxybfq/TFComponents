//
//  TFWebView.m
//  TFComponentsDemo
//
//  Created by Time on 2019/3/12.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFWebView.h"
#import "WeakWKScriptMessageHandler.h"

@interface TFWebView()

@property (nonatomic,assign)BOOL isInited;
@property (nonatomic,strong)UIProgressView *progress;
@property (nonatomic,  copy)TFWebViewTitleBlock titleBlock;
@property (nonatomic,  copy)TFWebViewProgressBlock progressBlock;

@end


@implementation TFWebView


-(void)dealloc{
    //移除对js函数监听的类
    [self removeAllScriptMessageHandler];
    //移除kvo
    [self removeObserver:self forKeyPath:@"title"];
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
}

-(instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration{
    if (self = [super initWithFrame:frame configuration:configuration]) {
        [self initSetting];
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSetting];
    }
    return self;
}

//初始化,只执行一次
-(void)initSetting{
    if (self.isInited == NO) {
        
        self.isInited = YES;
        //kvo监听,获得加载进度值
        [self addObserver:self
               forKeyPath:@"estimatedProgress"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
        [self addSubview:self.progress];
        
        //kvo监听,获取页面title值
        [self addObserver:self
               forKeyPath:@"title"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    }
    //设置滚动速度为正常
    self.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
}

//监听网页的title变化调用此函数
-(void)observerTitle:(TFWebViewTitleBlock)block{
    self.titleBlock = block;
}

//监听网页的请求进度调用此函数
-(void)observerProgress:(TFWebViewProgressBlock)block{
    self.progressBlock = block;
}

//监听js某个函数回调使用此函数
-(void)addScriptMessageHandlerWithName:(NSString *)name block:(WKScriptMessageHandlerBlock)block{
    [self.configuration.userContentController addScriptMessageName:name block:block];
}


#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    __weak typeof(self) weakself = self;
    //监听加载进度值
    if ([keyPath isEqualToString:@"estimatedProgress"]){
        if (object == self){
            //往外回调进度
            if(self.progressBlock){
                self.progressBlock(self, self.estimatedProgress);
            }
            //设置进度条
            [self.progress setAlpha:1.0f];
            [self.progress setProgress:self.estimatedProgress animated:YES];
            if(self.estimatedProgress >= 1.0f){
                [UIView animateWithDuration:0.5f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [weakself.progress setAlpha:0.0f];
                }completion:^(BOOL finished) {
                    [weakself.progress setProgress:0.0f animated:NO];
                }];
            }
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
        //监听网页title
    }else if ([keyPath isEqualToString:@"title"]){
        if (object == self){
            //往外标题
            if(self.titleBlock){
                self.titleBlock(self, self.title);
            }
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
    //布局进度条
    self.progress.frame = CGRectMake(0, 0, self.bounds.size.width, 2);
}

#pragma mark 加载进度条
- (UIProgressView *)progress{
    if (_progress == nil){
        _progress = [[UIProgressView alloc]initWithFrame:CGRectZero];
        _progress.tintColor = [UIColor blueColor];
        _progress.backgroundColor = [UIColor lightGrayColor];
    }
    return _progress;
}

//设置是否显示进度条
-(void)setShowProgress:(BOOL)showProgress{
    _showProgress = showProgress;
    self.progress.hidden = !showProgress;
}


//移除所有的scriptMessageHandler
//添加的scriptMessageHandler因为有不释放问题所以需要专门去清除
//https://www.jianshu.com/p/a0004a75deb3
-(void)removeAllScriptMessageHandler{
    WKUserContentController *userContentController = self.configuration.userContentController;
    NSMutableArray *scriptMessageHandlerNames = [userContentController scriptMessageHandlerNames];
    for (NSInteger i = 0; i < scriptMessageHandlerNames.count; i++) {
        NSString *name = [scriptMessageHandlerNames objectAtIndex:i];
        [userContentController removeScriptMessageHandlerForName:name];
    }
}

static NSString *_platformAgentString = nil;
+(void)changeDisplayToIphone:(BOOL)change{
    if (_platformAgentString == nil) {
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectZero];
        _platformAgentString = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    }
    NSString *agent = @"";
    if (change) {
        agent = [_platformAgentString stringByReplacingOccurrencesOfString:@"iPad"
                                                                withString:@"iPhone"];
    }else{
        agent = [_platformAgentString copy];
    }
    NSMutableDictionary *userAgent = [NSMutableDictionary dictionary];
    [userAgent setObject:agent forKey:@"UserAgent"];
    [[NSUserDefaults standardUserDefaults] registerDefaults:userAgent];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
