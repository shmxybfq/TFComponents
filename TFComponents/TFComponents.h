//
//  TFComponents.h
//  TFComponentsDemo
//
//  Created by Time on 2019/3/12.
//  Copyright © 2019 ztf. All rights reserved.
//

#ifndef TFComponents_h
#define TFComponents_h

#import "Const.h"

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

#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenOrigin [UIScreen mainScreen].bounds.origin
#define kScreenSize [UIScreen mainScreen].bounds.size
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

static inline BOOL fun_iphonex(){
    CGSize ss = [UIScreen mainScreen].bounds.size;
    NSInteger max = MAX(ss.width, ss.height);
    if (max == 896 /*xr,xsmax*/ || max == 812 /*x,xs*/) {
        return YES;
    }
    return NO;
}


#endif /* TFComponents_h */
