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

@property(nonatomic,assign) NSInteger index;
@property(nonatomic,assign) CGFloat width;
@property(nonatomic,assign) BOOL pinEnable;
@property(nonatomic,  copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
