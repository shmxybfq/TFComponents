//
//  WKUserContentController+Safe.m
//  HeroCoinSDK
//
//  Created by Time on 2018/8/22.
//  Copyright © 2018年 zhutaofeng. All rights reserved.
//

#import "WKUserContentController+Safe.h"
#import <objc/runtime.h>
#import "WeakWKScriptMessageHandler.h"


@interface WKUserContentController()
//addScriptMessageHandler 方法对参数强引用，但是因为方法交换多了一层变成了弱引用
//所以需要将block产生的对象存在这里做强应用才能正常回调block
@property(nonatomic,strong)NSMutableDictionary *blockContainers;
@property(nonatomic,strong)NSMutableArray *scriptMessageHandlerNames;

@end

@implementation WKUserContentController (Safe)


#pragma mark -- 方法交换
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self exchange];
    });
}

+(void)exchange{

    Class cls = [WKUserContentController class];
    
    SEL originSel = @selector(addScriptMessageHandler:name:);
    SEL targetSel = @selector(x_addScriptMessageHandler:name:);
    
    Method originMethod = class_getInstanceMethod(cls, originSel);
    Method targetMethod = class_getInstanceMethod(cls, targetSel);
    
    //检测方法目标类是否存在相关方法
    Method method = class_getInstanceMethod(cls, originSel);
    if (method){
        method_exchangeImplementations(originMethod, targetMethod);
    }
}

-(void)x_addScriptMessageHandler:(id<WKScriptMessageHandler>)scriptMessageHandler name:(NSString *)name{
    if (name != nil && name.length > 0) {
        WeakWKScriptMessageHandler *handler = [[WeakWKScriptMessageHandler alloc]init];
        handler.delegate = scriptMessageHandler;
        //
        if (self.scriptMessageHandlerNames == nil) {
            self.scriptMessageHandlerNames = [[NSMutableArray alloc]init];
        }
        //
        if ([self.scriptMessageHandlerNames containsObject:name] == NO) {
            [self.scriptMessageHandlerNames addObject:name];
            [self x_addScriptMessageHandler:handler name:name];
        }
    }
}

#pragma mark --
//获取此webview实例绑定的js-handler names
-(NSMutableArray *)scriptMessageHandlerNames{
    return objc_getAssociatedObject(self, @selector(scriptMessageHandlerNames));
}

-(void)setScriptMessageHandlerNames:(NSMutableArray *)scriptMessageHandlerNames{
    objc_setAssociatedObject(self,
                             @selector(scriptMessageHandlerNames),
                             scriptMessageHandlerNames,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark --

-(NSMutableDictionary *)blockContainers{
    return objc_getAssociatedObject(self, @selector(blockContainers));
}

-(void)setBlockContainers:(NSMutableDictionary *)blockContainers{
    objc_setAssociatedObject(self,
                             @selector(blockContainers),
                             blockContainers,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)addScriptMessageName:(NSString *)name block:(WKScriptMessageHandlerBlock)block{
    if (self.blockContainers == nil) {
        self.blockContainers = [[NSMutableDictionary alloc]init];
    }
    if (name != nil && name.length > 0 && [self.blockContainers.allKeys containsObject:name] == NO) {
        
        BlockContainer *container = [[BlockContainer alloc]init];
        container.scriptMessageHandlerBlock = block;
        [self.blockContainers setObject:container forKey:name];
        
        [self addScriptMessageHandler:container name:name];
    }
}


@end


@implementation BlockContainer

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if (self.scriptMessageHandlerBlock) {
        self.scriptMessageHandlerBlock(userContentController, message);
    }
}

@end
