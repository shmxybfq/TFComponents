//
//  TFGridViewHeaderFooterView.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFGridViewHeaderFooterView.h"

@implementation TFGridViewHeaderFooterView

/* 禁止子类重写【内部方法】
 * 初始化contentOffset
 */
-(void)initContentOffset:(CGPoint)contentOffset{
    if (self.faterHeader) {
        self.faterHeader.scrollView.contentOffset = contentOffset;
    }
}

/* 子类重写
 * 当cell被拖动时调用本方法
 *
 */
-(void)headerDidDrag:(TFGridViewHeaderFooterView *)witchHeader scrollView:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    if (self.disuseSyncHorizontalScroll == NO) {
        self.faterHeader.scrollView.contentOffset = scrollView.contentOffset;
    }
}

@end
