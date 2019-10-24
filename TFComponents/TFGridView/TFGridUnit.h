//
//  TFGridUnit.h
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/24.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//滚动吸附子控件边缘
typedef NS_ENUM(NSUInteger, TFGridScrollPinType) {
    TFGridScrollPinTypeNone,//不吸附
    TFGridScrollPinTypeLeft,//靠左吸附
    TFGridScrollPinTypeRight,//靠右吸附
};


NS_ASSUME_NONNULL_BEGIN

@interface TFGridUnit : NSObject

+(CGPoint)witchView:(UIView *)witchView scrollPin:(UIScrollView *)scrollView stopOffset:(CGPoint)offset subviews:(NSArray <UIView *>*)subviews;

@end

NS_ASSUME_NONNULL_END
