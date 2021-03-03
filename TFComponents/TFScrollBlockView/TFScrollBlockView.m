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

@property(nonatomic,assign)NSUInteger backgroundViewCount;
@property(nonatomic,strong)NSMutableArray *backgroundViews;
@property(nonatomic,strong)NSMutableArray *backgroundViewFrames;

@end

@implementation TFScrollBlockView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self);
        }];
        
        [self.scrollView addSubview:self.contentBackgroundView];
        [self.scrollView addSubview:self.contentView];
        
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.scrollView);
            make.width.mas_equalTo(self.frame.size.width);
            make.height.mas_equalTo(self.frame.size.height);
        }];
        
        [self.contentBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.contentView);
        }];
        
        self.forceScrollHeight = 0;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.frame.size.width);
    }];
    [self reloadLayout];
}

-(void)reload{
    [self reloadContent];
    [self reloadBackground];
    [self reloadLayout];
}



-(void)reloadContent{
    
    self.count = 0;
    [self.heights removeAllObjects];
    [self.lefts removeAllObjects];
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


-(void)reloadBackground{
    self.backgroundViewCount = 0;
    [self.backgroundViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.backgroundViews removeAllObjects];
    [self.backgroundViewFrames removeAllObjects];
    
    if ([self.delegate respondsToSelector:@selector(numberOfBackgroundView)]) {
        NSInteger count = [self.delegate numberOfBackgroundView];
        self.backgroundViewCount = count>=0?count:0;
        
        for (NSInteger i = 0; i <= self.backgroundViewCount; i++) {
            if ([self.delegate respondsToSelector:@selector(blockView:backgroundViewForIndex:)]) {
                UIView *backgroundView = [self.delegate blockView:self backgroundViewForIndex:i];
                NSAssert((!(backgroundView == nil)), @"backgroundView 不能为空！");
                [self.backgroundViews addObject:backgroundView];
                
                if ([self.delegate respondsToSelector:@selector(blockView:backgroundView:frameForIndex:)]) {
                    CGRect backgroundViewFrame = [self.delegate blockView:self backgroundView:backgroundView frameForIndex:i];
                    [self.backgroundViewFrames addObject:NSStringFromCGRect(backgroundViewFrame)];
                }
            }
        }
    }
}


-(void)reloadLayout{
    [self layoutContent];
    [self layoutBackground];
}

-(void)layoutContent{
    [self.cells makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (self.count == 0) return;
    CGFloat y = 0;
    UIView *topView = self.contentView;
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
            [self.contentView addSubview:cell];
        }else{
            margin = [[self.margins objectAtIndex:i] floatValue];
        }
        y += margin;
        if (cell) {
            [cell mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (i == 0) {
                    make.top.equalTo(topView).offset(margin);
                }else{
                    make.top.equalTo(topView.mas_bottom).offset(margin);
                }
                make.left.equalTo(self.contentView).offset(x);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(height);
            }];
        }
        y += height;
        topView = cell;
    }
    
    CGFloat contentHeight = y;
    if (contentHeight <= self.scrollView.frame.size.height) {
        contentHeight = self.scrollView.frame.size.height + self.forceScrollHeight;
    }
    
    self.maxHeight = contentHeight;

    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(contentHeight);
    }];
}



-(void)layoutBackground{
    [self.backgroundViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (self.backgroundViewCount == 0) return;
    
    for (NSInteger i = 0; i <= self.backgroundViewCount; i++) {
        UIView *backgroundView = [self.backgroundViews objectAtIndex:i];
        NSString *frameString = [self.backgroundViewFrames objectAtIndex:i];
        CGRect frame = CGRectFromString(frameString);
            
        [self.contentBackgroundView addSubview:backgroundView];
        [backgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentBackgroundView).offset(frame.origin.y);
            make.left.equalTo(self.contentBackgroundView).offset(frame.origin.x);
            make.width.mas_equalTo(frame.size.width);
            make.height.mas_equalTo(frame.size.height);
        }];
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

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:self.bounds];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

-(UIView *)contentBackgroundView{
    if (!_contentBackgroundView) {
        _contentBackgroundView = [[UIView alloc]initWithFrame:self.bounds];
        _contentBackgroundView.backgroundColor = [UIColor clearColor];
    }
    return _contentBackgroundView;
}

-(NSMutableArray *)backgroundViews{
    if (_backgroundViews == nil) {
        _backgroundViews = [[NSMutableArray alloc]init];
    }
    return _backgroundViews;
}

-(NSMutableArray *)backgroundViewFrames{
    if (_backgroundViewFrames == nil) {
        _backgroundViewFrames = [[NSMutableArray alloc]init];
    }
    return _backgroundViewFrames;
}

@end
