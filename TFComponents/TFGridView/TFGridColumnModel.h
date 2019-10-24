//
//  TFGridColumnModel.h
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/23.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFGridColumnModel : NSObject

//如不赋值,则按默认列数量累加
@property(nonatomic,assign) NSInteger index;
//如不赋值,默认=60
@property(nonatomic,assign) CGFloat width;
//如不赋值,默认=60
@property(nonatomic,assign) CGFloat height;
//如不赋值,默认=NO
@property(nonatomic,assign) BOOL pinEnable;
//如不赋值,默认=nil
@property(nonatomic,  copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
