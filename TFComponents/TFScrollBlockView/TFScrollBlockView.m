//
//  TFScrollBlockView.m
//  TFComponentsDemo
//
//  Created by 成丰快运 on 2021/1/28.
//  Copyright © 2021 ztf. All rights reserved.
//

#import "TFScrollBlockView.h"


@interface TFScrollBlockView ()

@property(nonatomic,assign)NSUInteger count;
@property(nonatomic,strong)NSMutableArray *heights;
@property(nonatomic,strong)NSMutableArray *margins;
@property(nonatomic,strong)NSMutableArray *lefts;
@property(nonatomic,strong)NSMutableArray *widths;
@property(nonatomic,assign)CGFloat maxHeight;

@end

@implementation TFScrollBlockView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        self.scrollView.frame = self.bounds;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (CGRectEqualToRect(self.scrollView.frame, self.bounds) == NO) {
        self.scrollView.frame = self.bounds;
        [self reloadLayout];
    }
}

-(void)reload{
    [self reloadData];
    [self reloadLayout];
}

-(void)reloadData{
    
    self.count = 0;
    [self.widths removeAllObjects];
    [self.margins removeAllObjects];
    [self.cells makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.cells removeAllObjects];
    
    if ([self.delegate respondsToSelector:@selector(numberOfCell)]) {
        NSInteger count = [self.delegate numberOfCell];
        self.count = count>=0?count:0;
    }
    
    for (NSInteger i = 0; i <= self.count; i++) {
        if (i < self.count) {
            if ([self.delegate respondsToSelector:@selector(blockView:marginForIndex:totalCount:)]) {
                CGFloat margin = [self.delegate blockView:self marginForIndex:i totalCount:self.count];
                [self.margins addObject:[NSString stringWithFormat:@"%f",margin]];
            }
            if ([self.delegate respondsToSelector:@selector(blockView:leftForIndex:)]) {
                CGFloat left = [self.delegate blockView:self leftForIndex:i];
                [self.lefts addObject:[NSString stringWithFormat:@"%f",left]];
            }
            if ([self.delegate respondsToSelector:@selector(blockView:heightForIndex:)]) {
                CGFloat height = [self.delegate blockView:self heightForIndex:i];
                [self.heights addObject:[NSString stringWithFormat:@"%f",height]];
            }
            if ([self.delegate respondsToSelector:@selector(blockView:widthForIndex:)]) {
                CGFloat width = [self.delegate blockView:self widthForIndex:i];
                [self.widths addObject:[NSString stringWithFormat:@"%f",width]];
            }
            if ([self.delegate respondsToSelector:@selector(blockView:cellForIndex:)]) {
                UIView *cell = [self.delegate blockView:self cellForIndex:i];
                NSAssert((!(cell == nil)), @"cell 不能为空！");
                [self.cells addObject:cell];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(blockView:marginForIndex:totalCount:)]) {
                CGFloat margin = [self.delegate blockView:self marginForIndex:i totalCount:self.count];
                [self.margins addObject:[NSString stringWithFormat:@"%f",margin]];
            }
        }
    }
}

-(void)reloadLayout{
    
    if (self.count == 0) return;
    CGFloat y = 0;
    for (NSInteger i = 0; i <= self.count; i++) {
        UIView *cell = nil;
        CGFloat x  = 0;
        CGFloat width  = self.bounds.size.width;
        CGFloat height  = 0;
        CGFloat margin = 0;
        if (i < self.count) {
            cell  = [self.cells objectAtIndex:i];
            margin = [[self.margins objectAtIndex:i] floatValue];
            if (i < self.lefts.count) {
                x = [[self.lefts objectAtIndex:i] floatValue];
            }
            height = [[self.heights objectAtIndex:i] floatValue];
            if (i < self.widths.count) {
                width = [[self.widths objectAtIndex:i] floatValue];
            }
            [self.scrollView addSubview:cell];
        }else{
            margin = [[self.margins objectAtIndex:i] floatValue];
        }
        y += margin;
        cell.frame = CGRectMake(x, y, width, height);
        y += height;
    }
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, y);
    self.maxHeight = y;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, y);
    });
}



-(NSMutableArray *)widths{
    if (_widths == nil) {
        _widths = [[NSMutableArray alloc]init];
    }
    return _widths;
}


-(NSMutableArray *)margins{
    if (_margins == nil) {
        _margins = [[NSMutableArray alloc]init];
    }
    return _margins;
}

-(NSMutableArray *)lefts{
    if (_lefts == nil) {
        _lefts = [[NSMutableArray alloc]init];
    }
    return _lefts;
}
-(NSMutableArray *)heights{
    if (_heights == nil) {
        _heights = [[NSMutableArray alloc]init];
    }
    return _heights;
}

-(NSMutableArray *)cells{
    if (_cells == nil) {
        _cells = [[NSMutableArray alloc]init];
    }
    return _cells;
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
@end
