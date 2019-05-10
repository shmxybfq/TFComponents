//
//  WeakWKScriptMessageHandler.h
//  HeroCoinSDK
//
//  Created by Time on 2018/8/23.
//  Copyright © 2018年 zhutaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "Const.h"

//套壳类,可以不用让添加到下面方法的类被强引用
//-(void)addScriptMessageHandler:(id<WKScriptMessageHandler>)scriptMessageHandler name:(NSString *)name;
@interface WeakWKScriptMessageHandler : NSObject<WKScriptMessageHandler>

@property(nonatomic,  weak)id<WKScriptMessageHandler>delegate;

@end
