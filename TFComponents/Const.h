//
//  Const.h
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/5/10.
//  Copyright © 2019 ztf. All rights reserved.
//

#ifndef Const_h
#define Const_h

#ifdef DEBUG
#   define XLog(fmt, ...) NSLog((@"\nfunction:%s,line:%d\n" fmt @"\n"), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define XLog(...)
#endif

#endif /* Const_h */
