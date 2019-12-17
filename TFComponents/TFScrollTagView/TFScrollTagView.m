//
//  TFScrollTagView.m
//  TFComponentsDemo
//
//  Created by Time on 2019/3/8.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFScrollTagView.h"


@interface TFScrollTagView ()

@property(nonatomic,assign)NSUInteger count;
@property(nonatomic,strong)NSMutableArray *widths;
@property(nonatomic,strong)NSMutableArray *margins;
@property(nonatomic,strong)NSMutableArray *tops;
@property(nonatomic,strong)NSMutableArray *heights;
@property(nonatomic,assign)CGFloat maxWidth;

@end

@implementation TFScrollTagView

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
            if ([self.delegate respondsToSelector:@selector(tagView:marginForIndex:totalCount:)]) {
                CGFloat margin = [self.delegate tagView:self marginForIndex:i totalCount:self.count];
                [self.margins addObject:[NSString stringWithFormat:@"%f",margin]];
            }
            if ([self.delegate respondsToSelector:@selector(tagView:topForIndex:)]) {
                CGFloat top = [self.delegate tagView:self topForIndex:i];
                [self.tops addObject:[NSString stringWithFormat:@"%f",top]];
            }
            if ([self.delegate respondsToSelector:@selector(tagView:widthForIndex:)]) {
                CGFloat width = [self.delegate tagView:self widthForIndex:i];
                [self.widths addObject:[NSString stringWithFormat:@"%f",width]];
            }
            if ([self.delegate respondsToSelector:@selector(tagView:heightForIndex:)]) {
                CGFloat height = [self.delegate tagView:self heightForIndex:i];
                [self.heights addObject:[NSString stringWithFormat:@"%f",height]];
            }
            if ([self.delegate respondsToSelector:@selector(tagView:cellForIndex:)]) {
                UIView *cell = [self.delegate tagView:self cellForIndex:i];
                NSAssert((!(cell == nil)), @"cell 不能为空！");
                [self.cells addObject:cell];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(tagView:marginForIndex:totalCount:)]) {
                CGFloat margin = [self.delegate tagView:self marginForIndex:i totalCount:self.count];
                [self.margins addObject:[NSString stringWithFormat:@"%f",margin]];
            }
        }
    }
}

-(void)reloadLayout{
    
    if (self.count == 0) return;
    CGFloat x = 0;
    for (NSInteger i = 0; i <= self.count; i++) {
        UIView *cell = nil;
        CGFloat y  = 0;
        CGFloat width  = 0;
        CGFloat height  = self.bounds.size.height;
        CGFloat margin = 0;
        if (i < self.count) {
            cell  = [self.cells objectAtIndex:i];
            margin = [[self.margins objectAtIndex:i] floatValue];
            if (i < self.tops.count) {
                y = [[self.tops objectAtIndex:i] floatValue];
            }
            width = [[self.widths objectAtIndex:i] floatValue];
            if (i < self.heights.count) {
                height = [[self.heights objectAtIndex:i] floatValue];
            }
            [self.scrollView addSubview:cell];
        }else{
            margin = [[self.margins objectAtIndex:i] floatValue];
        }
        x += margin;
        cell.frame = CGRectMake(x, y, width, height);
        x += width;
    }
    self.scrollView.contentSize = CGSizeMake(x, self.bounds.size.height);
    self.maxWidth = x;
}

-(void)scrollToIndex:(NSInteger)index{
    if (index < self.count) {
        UIView *cell = [self.cells objectAtIndex:index];
        CGRect cf = cell.frame;
        CGFloat target = cf.origin.x;
        target = target - self.frame.size.width * 0.5 + cf.size.width * 0.5;
        if (target <= 0) target = 0;
        if (target >= (self.maxWidth - self.frame.size.width)) target = self.maxWidth - self.frame.size.width;
        if (target >= 0) {
            [self.scrollView setContentOffset:CGPointMake(target, 0) animated:YES];
        }else{
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
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

-(NSMutableArray *)tops{
    if (_tops == nil) {
        _tops = [[NSMutableArray alloc]init];
    }
    return _tops;
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
