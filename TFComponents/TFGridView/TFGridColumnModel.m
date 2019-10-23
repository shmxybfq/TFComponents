//
//  TFGridColumnModel.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/23.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFGridColumnModel.h"

@implementation TFGridColumnModel

-(CGFloat)width{
    if (_width <= 0.0) {
        return 60;
    }
    return _width;
}


@end
