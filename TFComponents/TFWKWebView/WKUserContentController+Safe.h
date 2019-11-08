//
//  WKUserContentController+Safe.h
//  HeroCoinSDK
//
//  Created by Time on 2018/8/22.
//  Copyright © 2018年 zhutaofeng. All rights reserved.
//

#import <WebKit/WebKit.h>

//专门解决scriptMessageHandler不释放问题
//添加的scriptMessageHandler因为有不释放问题所以需要专门去清除
//https://www.jianshu.com/p/a0004a75deb3

typedef void(^WKScriptMessageHandlerBlock)(WKUserContentController *userContentController,
                                           WKScriptMessage *message);

@interface WKUserContentController (Safe)

//获取此webview实例绑定的js-handler names
-(NSMutableArray *)scriptMessageHandlerNames;
//添加block回调形式的
-(void)addScriptMessageName:(NSString *)name block:(WKScriptMessageHandlerBlock)block;

@end


@interface BlockContainer:NSObject<WKScriptMessageHandler>

@property(nonatomic,  copy)WKScriptMessageHandlerBlock scriptMessageHandlerBlock;

@end
