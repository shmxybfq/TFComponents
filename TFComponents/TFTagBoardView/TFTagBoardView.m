//
//  TFTagBoardView.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/12/11.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFTagBoardView.h"

@interface TFTagBoardView ()


@end

@implementation TFTagBoardView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.rowMargin = 10;
        self.columnMargin = 15;
        self.rowHeight = 30;
        
        [self addSubview:self.scrollView];
        self.scrollView.frame = self.bounds;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (CGRectEqualToRect(self.scrollView.frame, self.bounds) == NO) {
        self.scrollView.frame = self.bounds;
        [self reloadData];
    }
}

-(void)reload{
    [self reloadData];
}

-(void)reloadData{
    
    [self.cells makeObjectsPerformSelector:@selector(removeFromSuperview)];

    NSUInteger count = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfCell)]) {
        count = [self.delegate numberOfCell];
    }

    CGFloat x = self.edge.left;
    CGFloat y = self.edge.top;
    for (NSInteger i = 0; i < count; i++) {
       
        CGFloat width = 0;
        if ([self.delegate respondsToSelector:@selector(tagBoardView:widthForIndex:)]) {
            width = [self.delegate tagBoardView:self widthForIndex:i];
        }
        if (x + self.columnMargin + width > self.bounds.size.width - self.edge.right) {
            x = self.edge.left;
            y = y + self.rowMargin + self.rowHeight;
        }
        
        UIView *cell = nil;
        if ([self.delegate respondsToSelector:@selector(tagBoardView:cellForIndex:width:)]) {
            cell = [self.delegate tagBoardView:self cellForIndex:i width:width];
        }
        
        cell.frame = CGRectMake(x, y, width, self.rowHeight);
        [self.cells addObject:cell];
        [self.scrollView addSubview:cell];
        self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, y + self.rowHeight + self.edge.bottom);
        
        x = x + self.columnMargin + width;
        
    }
}

-(NSMutableArray *)cells{
    if (!_cells) {
        _cells = [[NSMutableArray alloc]init];
    }
    return _cells;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
@end
