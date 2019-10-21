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
    [self.gridHeader removeFromSuperview];
    self.gridHeader = nil;
    
    if (header) {
        self.gridHeader = header;
        [self.scrollView addSubview:self.gridHeader];
    }
}

-(void)reloadGridHeaderFrame:(CGRect)frame{
    self.gridHeader.frame = frame;
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
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(innerHeader:scrollViewWillBeginDragging:indexPath:)]) {
        [self.delegate innerHeader:self scrollViewWillBeginDragging:self.scrollView indexPath:self.indexPath];
    }
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if ([self.delegate respondsToSelector:@selector(innerHeader:scrollViewWillEndDragging:withVelocity:targetContentOffset:indexPath:)]) {
        [self.delegate innerHeader:self scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset indexPath:self.indexPath];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([self.delegate respondsToSelector:@selector(innerHeader:scrollViewDidEndDragging:willDecelerate:indexPath:)]) {
        [self.delegate innerHeader:self scrollViewDidEndDragging:scrollView willDecelerate:decelerate indexPath:self.indexPath];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(innerHeader:scrollViewWillBeginDecelerating:indexPath:)]) {
        [self.delegate innerHeader:self scrollViewWillBeginDecelerating:self.scrollView indexPath:self.indexPath];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(innerHeader:scrollViewDidEndDecelerating:indexPath:)]) {
        [self.delegate innerHeader:self scrollViewDidEndDecelerating:self.scrollView indexPath:self.indexPath];
    }
}
@end
