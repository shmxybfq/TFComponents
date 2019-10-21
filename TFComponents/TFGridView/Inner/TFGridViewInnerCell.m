//
//  TFGridViewInnerCell.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFGridViewInnerCell.h"
#import "TFGridViewCell.h"

@interface TFGridViewInnerCell ()<UIScrollViewDelegate>


@end

@implementation TFGridViewInnerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return self;
}

-(void)reloadGridCell:(TFGridViewCell *)gridCell{
    [self.gridCell removeFromSuperview];
    self.gridCell = nil;
    
    if (gridCell) {
        self.gridCell = gridCell;
        [self.scrollView addSubview:self.gridCell];
    }
}

-(void)reloadGridCellFrame:(CGRect)frame{
    self.gridCell.frame = frame;
    self.scrollView.contentSize = CGSizeMake(frame.origin.x + frame.size.width, frame.origin.y + frame.size.height);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"=============scrollViewDidScroll:%@",NSStringFromCGPoint(scrollView.contentOffset));
    if ([self.delegate respondsToSelector:@selector(innerCell:scrollViewDidScroll:indexPath:)]) {
        [self.delegate innerCell:self scrollViewDidScroll:self.scrollView indexPath:self.indexPath];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"=============scrollViewWillBeginDragging:%@",NSStringFromCGPoint(scrollView.contentOffset));
    if ([self.delegate respondsToSelector:@selector(innerCell:scrollViewWillBeginDragging:indexPath:)]) {
        [self.delegate innerCell:self scrollViewWillBeginDragging:self.scrollView indexPath:self.indexPath];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"=============scrollViewWillEndDragging:%@ target:%@",NSStringFromCGPoint(scrollView.contentOffset),NSStringFromCGPoint(*targetContentOffset));
    if ([self.delegate respondsToSelector:@selector(innerCell:scrollViewWillEndDragging:withVelocity:targetContentOffset:indexPath:)]) {
        [self.delegate innerCell:self scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset indexPath:self.indexPath];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"=============scrollViewDidEndDragging:%@",NSStringFromCGPoint(scrollView.contentOffset));
    if ([self.delegate respondsToSelector:@selector(innerCell:scrollViewDidEndDragging:willDecelerate:indexPath:)]) {
        [self.delegate innerCell:self scrollViewDidEndDragging:scrollView willDecelerate:decelerate indexPath:self.indexPath];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"=============scrollViewWillBeginDecelerating:%@",NSStringFromCGPoint(scrollView.contentOffset));
    if ([self.delegate respondsToSelector:@selector(innerCell:scrollViewWillBeginDecelerating:indexPath:)]) {
        [self.delegate innerCell:self scrollViewWillBeginDecelerating:self.scrollView indexPath:self.indexPath];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"=============scrollViewDidEndDecelerating:%@",NSStringFromCGPoint(scrollView.contentOffset));
    if ([self.delegate respondsToSelector:@selector(innerCell:scrollViewDidEndDecelerating:indexPath:)]) {
        [self.delegate innerCell:self scrollViewDidEndDecelerating:self.scrollView indexPath:self.indexPath];
    }
}

@end
