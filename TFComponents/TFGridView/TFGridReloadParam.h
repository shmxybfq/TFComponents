//
//  TFGridReloadParam.h
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/28.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFGridReloadParam : NSObject

//reload的时候是否保留原来的横向滚动值,如果不保留，每次reload会将横向滚动值设为0
@property(nonatomic, assign) BOOL keepOrignHorizontalScrollOffset;


@end

NS_ASSUME_NONNULL_END
