//
//  TFGridViewHeaderFooterView.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFGridViewHeaderFooterView.h"
#import "TFGridViewCell.h"
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
-(void)headerDidDrag:(UIView *)witchView scrollView:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    if ([witchView isKindOfClass:[TFGridViewCell class]]) {
        TFGridViewCell *witchCell = (TFGridViewCell *)witchView;
        if ([self.syncScrollIdentifier isEqualToString:witchCell.syncScrollIdentifier]) {
            self.faterHeader.scrollView.contentOffset = scrollView.contentOffset;
        }
    }else if ([witchView isKindOfClass:[TFGridViewHeaderFooterView class]]) {
        TFGridViewHeaderFooterView *witchHeader = (TFGridViewHeaderFooterView *)witchView;
        if ([self.syncScrollIdentifier isEqualToString:witchHeader.syncScrollIdentifier]) {
            self.faterHeader.scrollView.contentOffset = scrollView.contentOffset;
        }
    }
}

-(void)setSyncScrollIdentifier:(NSString *)syncScrollIdentifier{
    _syncScrollIdentifier = [syncScrollIdentifier copy];
    if (_syncScrollIdentifier) {
        self.faterHeader.scrollView.scrollEnabled = YES;
    }else{
        self.faterHeader.scrollView.scrollEnabled = NO;
    }
}

@end
