//
//  TFGridViewHeaderFooterView.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFGridViewHeaderFooterView.h"
#import "TFGridViewCell.h"

@interface TFGridViewHeaderFooterView ()

@end

@implementation TFGridViewHeaderFooterView

-(void)setData:(id)data{
    
}
-(void)setData:(id)data indexPath:(NSIndexPath *)indexPath{
    
}
-(void)setData:(id)data indexPath:(NSIndexPath *)indexPath delegate:(id)delegate{
    
}


-(void)reloadColumn{
    
    [self.columnViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (self.delegate) {
        
        NSInteger columnCount = 1;
        if ([self.delegate respondsToSelector:@selector(numberOfColumnInGridHeader:)]) {
            columnCount = [self.delegate numberOfColumnInGridHeader:self];
        }
        
        CGFloat frameX = 0;
        CGFloat frameY = 0;
        for (NSInteger i = 0; i < columnCount; i++) {
            if ([self.delegate respondsToSelector:@selector(gridCell:columnViewWithIndex:)]) {
                TFGridColumnView *view = [self.delegate gridCell:self columnViewWithIndex:i];
                [self addSubview:view];
                [self.columnViews addObject:view];
                
                TFGridColumnModel *columnModel = nil;
                if (view && [view isKindOfClass:[UIView class]]) {
                    if ([self.delegate respondsToSelector:@selector(gridCell:columnModelWithColumnView:index:)]) {
                        columnModel = [self.delegate gridCell:self columnModelWithColumnView:view index:i];
                        view.columnModel = columnModel;
                    }
                }
                
                CGRect frame = CGRectZero;
                if ([self.delegate respondsToSelector:@selector(gridCell:columnFrameWithColumnView:columnModel:index:)]) {
                    frame = [self.delegate gridCell:self columnFrameWithColumnView:view columnModel:columnModel index:i];
                }else{
                    frame = CGRectMake(frameX, frameY, columnModel.width, columnModel.height);
                    frameX += columnModel.width;
                }
                view.frame = frame;
            }
        }
    }
}


-(void)initContentOffset:(CGPoint)contentOffset{
    if (self.fatherHeader) {
        self.fatherHeader.scrollView.contentOffset = contentOffset;
    }
}

-(void)witchViewDidDrag:(UIView *)witchView scrollViewDidScroll:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    if ([witchView isKindOfClass:[TFGridViewCell class]]) {
        TFGridViewCell *witchCell = (TFGridViewCell *)witchView;
        if ([self.syncScrollIdentifier isEqualToString:witchCell.syncScrollIdentifier]) {
            self.fatherHeader.scrollView.contentOffset = scrollView.contentOffset;
        }
    }else if ([witchView isKindOfClass:[TFGridViewHeaderFooterView class]]) {
        TFGridViewHeaderFooterView *witchHeader = (TFGridViewHeaderFooterView *)witchView;
        if ([self.syncScrollIdentifier isEqualToString:witchHeader.syncScrollIdentifier]) {
            self.fatherHeader.scrollView.contentOffset = scrollView.contentOffset;
        }
    }
}
- (void)witchViewDidDrag:(UIView *)witchView scrollViewWillBeginDragging:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    
}

- (void)witchViewDidDrag:(UIView *)witchView scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate indexPath:(NSIndexPath *)indexPath{
    if (self.gridScrollPinType != TFGridScrollPinTypeNone && decelerate == NO) {
        CGPoint point = [TFGridUnit witchView:self scrollPin:scrollView stopOffset:scrollView.contentOffset subviews:self.subviews];
        if (!CGPointEqualToPoint(point, CGPointZero)) {
            [scrollView setContentOffset:point animated:YES];
        }
    }
}

- (void)witchViewDidDrag:(UIView *)witchView scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset indexPath:(NSIndexPath *)indexPath{
    if (self.gridScrollPinType != TFGridScrollPinTypeNone) {
        CGPoint offset = *targetContentOffset;
        CGPoint point = [TFGridUnit witchView:self scrollPin:scrollView stopOffset:offset subviews:self.subviews];
        if (!CGPointEqualToPoint(point, CGPointZero)) {
            *targetContentOffset = point;
        }
    }
}

- (void)witchViewDidDrag:(UIView *)witchView scrollViewWillBeginDecelerating:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    
}

- (void)witchViewDidDrag:(UIView *)witchView scrollViewDidEndDecelerating:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    
}

-(void)setSyncScrollIdentifier:(NSString *)syncScrollIdentifier{
    _syncScrollIdentifier = [syncScrollIdentifier copy];
    if (_syncScrollIdentifier) {
        self.fatherHeader.scrollView.scrollEnabled = YES;
    }else{
        self.fatherHeader.scrollView.scrollEnabled = NO;
    }
}

-(NSMutableArray<TFGridColumnView *> *)columnViews{
    if (!_columnViews) {
        _columnViews = [[NSMutableArray alloc]init];
    }
    return _columnViews;
}


@end
