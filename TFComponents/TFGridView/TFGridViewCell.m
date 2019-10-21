//
//  TFGridViewCell.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFGridViewCell.h"
#import "TFGridViewHeaderFooterView.h"
@implementation TFGridViewCell

-(void)initContentOffset:(CGPoint)contentOffset{
    if (self.faterCell) {
        self.faterCell.scrollView.contentOffset = contentOffset;
    }
}

-(void)witchViewDidDrag:(UIView *)witchView scrollViewDidScroll:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    if ([witchView isKindOfClass:[TFGridViewCell class]]) {
        TFGridViewCell *witchCell = (TFGridViewCell *)witchView;
        if ([self.syncScrollIdentifier isEqualToString:witchCell.syncScrollIdentifier]) {
            self.faterCell.scrollView.contentOffset = scrollView.contentOffset;
        }
    }else if ([witchView isKindOfClass:[TFGridViewHeaderFooterView class]]) {
        TFGridViewHeaderFooterView *witchHeader = (TFGridViewHeaderFooterView *)witchView;
        if ([self.syncScrollIdentifier isEqualToString:witchHeader.syncScrollIdentifier]) {
            self.faterCell.scrollView.contentOffset = scrollView.contentOffset;
        }
    }
}


- (void)witchViewDidDrag:(UIView *)witchView scrollViewWillBeginDragging:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{}

- (void)witchViewDidDrag:(UIView *)witchView scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate indexPath:(NSIndexPath *)indexPath{}

- (void)witchViewDidDrag:(UIView *)witchView scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset indexPath:(NSIndexPath *)indexPath{}

- (void)witchViewDidDrag:(UIView *)witchView scrollViewWillBeginDecelerating:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{}

- (void)witchViewDidDrag:(UIView *)witchView scrollViewDidEndDecelerating:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{}


-(void)setSyncScrollIdentifier:(NSString *)syncScrollIdentifier{
    _syncScrollIdentifier = [syncScrollIdentifier copy];
    if (_syncScrollIdentifier) {
        self.faterCell.scrollView.scrollEnabled = YES;
    }else{
        self.faterCell.scrollView.scrollEnabled = NO;
    }
}

@end
