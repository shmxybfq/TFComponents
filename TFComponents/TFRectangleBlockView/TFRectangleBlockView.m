//
//  TFRectangleBlockView.m
//  TimeAR
//
//  Created by Time on 2019/3/13.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFRectangleBlockView.h"

@interface TFRectangleBlockView ()<UIScrollViewDelegate>

@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)NSMutableArray *cells;

@end

@implementation TFRectangleBlockView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
    }
    return self;
}

-(void)reload{
    self.count = 0;
    [self.cells makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.cells removeAllObjects];
    if ([self.delegate respondsToSelector:@selector(numberOfCells)]) {
        self.count = [self.delegate numberOfCells];
    }
    for (NSInteger i = 0; i < self.count; i++) {
        if ([self.delegate respondsToSelector:@selector(blockView:cellWithIndex:)]) {
            UIView *cell = [self.delegate blockView:self cellWithIndex:i];
            NSAssert(cell != nil, @"cell can't be nil");
            [self.cells addObject:cell];
            [self.scrollView addSubview:cell];
        }
    }
    if (self.cells.count > 0) {
        [self resize];
    }
}

-(void)setEdge:(UIEdgeInsets)edge{
    _edge = edge;
    [self resize];
}
-(void)setCountPerLine:(NSInteger)countPerLine{
    _countPerLine = countPerLine;
    [self resize];
}
-(void)setLineSpace:(CGFloat)lineSpace{
    _lineSpace = lineSpace;
    [self resize];
}
-(void)setCellSpace:(CGFloat)cellSpace{
    _cellSpace = cellSpace;
    [self resize];
}

-(void)setCellHeight:(CGFloat)cellHeight{
    _cellHeight = cellHeight;
    [self resize];
}

-(void)resize{
    if (self.count == 0 || self.cells.count == 0) {
        return;
    }
    CGSize ss = self.bounds.size;
    UIEdgeInsets ist = self.edge;
    CGFloat ls = self.lineSpace;
    CGFloat cs = self.cellSpace;
    NSInteger ct = self.countPerLine<=0?3:self.countPerLine;
    CGFloat width = (ss.width - ist.left - ist.right - cs * (ct - 1)) / ct;
    CGFloat height = self.cellHeight<=0?width:self.cellHeight;
    
    CGFloat x = ist.left;
    CGFloat y = ist.top;
    CGFloat maxY = 0;
    for (NSInteger i = 0; i < self.count; i++) {
        UIView *cell = [self.cells objectAtIndex:i];
        cell.frame = CGRectMake(x, y, width, height);
        x = x + width + cs;
        if ((i + 1) % ct == 0) {
            x = ist.left;
            y = y + height + ls;
        }
        maxY = CGRectGetMaxY(cell.frame);
    }
    maxY = maxY + ist.bottom;
    self.scrollView.contentSize = CGSizeMake(ss.width, maxY);
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize ss = self.bounds.size;
    self.scrollView.frame = CGRectMake(0, 0, ss.width, ss.height);
    [self resize];
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(NSMutableArray *)cells{
    if (_cells == nil) {
        _cells = [[NSMutableArray alloc]init];
    }
    return _cells;
}



@end
