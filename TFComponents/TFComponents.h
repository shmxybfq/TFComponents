//
//  TFComponents.h
//  TFComponentsDemo
//
//  Created by Time on 2019/3/12.
//  Copyright © 2019 ztf. All rights reserved.
//

#ifndef TFComponents_h
#define TFComponents_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#ifdef DEBUG
#   define XLog(fmt, ...) NSLog((@"\nfunction:%s,line:%d\n" fmt @"\n"), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define XLog(...)
#endif


#import "TFGridView.h"
#import "TFRectangleBlockView.h"
#import "TFScrollTagView.h"
#import "TFSquareBlockView.h"
#import "TFWKWebView.h"
#import "TFWKWebViewController.h"
#import "TFTagBoardView.h"
/**
 *  weak obj
 *  @param TARGET 实例
 *  @param NAME   弱实例名字
 */
#ifndef tf_weak_obj
#define tf_weak_obj(target,name)  __weak typeof(target) name = target;
#endif
#ifndef kdeclare_weakself
#define kdeclare_weakself tf_weak_obj(self,weakSelf)
#endif

#ifndef kScreenBounds
#define kScreenBounds [UIScreen mainScreen].bounds
#endif
#ifndef kScreenOrigin
#define kScreenOrigin [UIScreen mainScreen].bounds.origin
#endif
#ifndef kScreenSize
#define kScreenSize [UIScreen mainScreen].bounds.size
#endif
#ifndef kScreenWidth
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#endif
#ifndef kScreenHeight
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#endif



static inline BOOL fun_iphonex(){
    CGSize ss = [UIScreen mainScreen].bounds.size;
    NSInteger max = MAX(ss.width, ss.height);
    if (max == 896 /*xr,xsmax*/ || max == 812 /*x,xs*/) {
        return YES;
    }
    return NO;
}


#endif /* TFComponents_h */
