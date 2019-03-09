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
@property(nonatomic,strong)NSMutableArray *cells;
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
    [self.cells removeAllObjects];
    
    if ([self.delegate respondsToSelector:@selector(numberOfCell)]) {
        NSInteger count = [self.delegate numberOfCell];
        self.count = count>=0?count:0;
    }
    
    for (NSInteger i = 0; i <= self.count; i++) {
        if (i < self.count) {
            if ([self.delegate respondsToSelector:@selector(tagView:widthForIndex:)]) {
                CGFloat width = [self.delegate tagView:self widthForIndex:i];
                [self.widths addObject:[NSString stringWithFormat:@"%f",width]];
            }
            if ([self.delegate respondsToSelector:@selector(tagView:marginForIndex:totalCount:)]) {
                CGFloat margin = [self.delegate tagView:self marginForIndex:i totalCount:self.count];
                [self.margins addObject:[NSString stringWithFormat:@"%f",margin]];
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
    
    CGFloat x = 0;
    for (NSInteger i = 0; i <= self.count; i++) {
        UIView *cell = nil;
        CGFloat width  = 0;
        CGFloat margin = 0;
        if (i < self.count) {
            cell  = [self.cells objectAtIndex:i];
            margin = [[self.margins objectAtIndex:i] floatValue];
            width = [[self.widths objectAtIndex:i] floatValue];
            [self.scrollView addSubview:cell];
        }else{
            margin = [[self.margins objectAtIndex:i] floatValue];
        }
        x += margin;
        cell.frame = CGRectMake(x, 0, width, self.bounds.size.height);
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
        [self.scrollView setContentOffset:CGPointMake(target, 0) animated:YES];
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
