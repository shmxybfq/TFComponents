//
//  TFGridColumnView.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/23.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFGridColumnView.h"

@interface TFGridColumnView ()

@end

@implementation TFGridColumnView

-(void)setData:(id)data{
    self.data = data;
}

-(void)setData:(id)data index:(NSInteger)index delegate:(id)delegate{
    self.data = data;
    self.index = index;
    self.delegate = delegate;
}

@end
