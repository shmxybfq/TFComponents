//
//  TFGridColumnView.h
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/23.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFGridColumnModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFGridColumnView : UIView

@property(nonatomic, strong) id data;
@property(nonatomic, assign) NSInteger index;

@property(nonatomic,strong) TFGridColumnModel *columnModel;

-(void)setData:(id)data;
-(void)setData:(id)data index:(NSInteger)index delegate:(id)delegate;

@end

NS_ASSUME_NONNULL_END
