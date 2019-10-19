//
//  TFGridViewCell.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFGridViewCell.h"

@implementation TFGridViewCell

/* 禁止子类重写【内部方法】
 * 初始化contentOffset
 */
-(void)initContentOffset:(CGPoint)contentOffset{
    if (self.faterCell) {
        self.faterCell.scrollView.contentOffset = contentOffset;
    }
}

/* 子类重写
 * 当cell被拖动时调用本方法
 *
 */
-(void)cellDidDrag:(TFGridViewCell *)witchCell scrollView:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    if (self.disuseSyncHorizontalScroll == NO) {
        self.faterCell.scrollView.contentOffset = scrollView.contentOffset;
    }
}

@end
