//
//  WeakWKScriptMessageHandler.m
//  HeroCoinSDK
//
//  Created by Time on 2018/8/23.
//  Copyright © 2018年 zhutaofeng. All rights reserved.
//

#import "WeakWKScriptMessageHandler.h"

@implementation WeakWKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([self.delegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.delegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

@end
