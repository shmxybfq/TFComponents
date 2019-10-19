//
//  TFGridViewInnerHeaderFooterView.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFGridViewInnerHeaderFooterView.h"
#import "TFGridViewHeaderFooterView.h"
@interface TFGridViewInnerHeaderFooterView ()<UIScrollViewDelegate>


@end

@implementation TFGridViewInnerHeaderFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

-(void)reloadGridHeader:(TFGridViewHeaderFooterView *)header{
    [self.header removeFromSuperview];
    self.header = nil;
    
    if (header) {
        self.header = header;
        [self.scrollView addSubview:self.header];
    }
}

-(void)reloadGridHeaderFrame:(CGRect)frame{
    self.header.frame = frame;
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
    if ([self.delegate respondsToSelector:@selector(innerHeader:scrollViewDidScroll:indexPath:)]) {
        [self.delegate innerHeader:self scrollViewDidScroll:self.scrollView indexPath:self.indexPath];
    }
}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    if ([self.delegate respondsToSelector:@selector(innerCell:scrollViewWillBeginDragging:indexPath:)]) {
//        [self.delegate innerCell:self scrollViewWillBeginDragging:self.scrollView indexPath:self.indexPath];
//    }
//}
//
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    if ([self.delegate respondsToSelector:@selector(innerCell:scrollViewWillEndDragging:withVelocity:targetContentOffset:indexPath:)]) {
//        [self.delegate innerCell:self scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset indexPath:self.indexPath];
//    }
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if ([self.delegate respondsToSelector:@selector(innerCell:scrollViewDidEndDragging:willDecelerate:indexPath:)]) {
//        [self.delegate innerCell:self scrollViewDidEndDragging:scrollView willDecelerate:decelerate indexPath:self.indexPath];
//    }
//}
//
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    if ([self.delegate respondsToSelector:@selector(innerCell:scrollViewWillBeginDecelerating:indexPath:)]) {
//        [self.delegate innerCell:self scrollViewWillBeginDecelerating:self.scrollView indexPath:self.indexPath];
//    }
//}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    if ([self.delegate respondsToSelector:@selector(innerCell:scrollViewDidEndDecelerating:indexPath:)]) {
//        [self.delegate innerCell:self scrollViewDidEndDecelerating:self.scrollView indexPath:self.indexPath];
//    }
//}
@end
