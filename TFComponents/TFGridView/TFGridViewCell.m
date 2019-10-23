//
//  TFGridViewCell.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFGridViewCell.h"
#import "TFGridViewHeaderFooterView.h"

@interface TFGridViewCell ()

@property(nonatomic, strong) NSMutableArray <TFGridColumnView *>*columnViews;


@end

@implementation TFGridViewCell

-(void)reloadColumn{
    
    [self.columnViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (self.delegate) {
        
        NSInteger columnCount = 1;
        if ([self.delegate respondsToSelector:@selector(numberOfColumnInGridViewCell:)]) {
            columnCount = [self.delegate numberOfColumnInGridViewCell:self];
        }
        
        CGFloat frameX = 0;
        CGFloat frameY = 0;
        for (NSInteger i = 0; i < columnCount; i++) {
            if ([self.delegate respondsToSelector:@selector(gridCell:columnViewWithIndex:)]) {
                TFGridColumnView *view = [self.delegate gridCell:self columnViewWithIndex:i];
                [self addSubview:view];
                [self.columnViews addObject:view];
                
                if (view && [view isKindOfClass:[UIView class]]) {
                    
                    TFGridColumnModel *columnModel = nil;
                    if ([self.delegate respondsToSelector:@selector(gridCell:columnModelWithColumnView:index:)]) {
                        columnModel = [self.delegate gridCell:self columnModelWithColumnView:view index:i];
                        if (columnModel.index == 0) {
                            columnModel.index = i;
                        }
                        view.columnModel = columnModel;
                    }
                    
                    CGRect frame = CGRectZero;
                    if ([self.delegate respondsToSelector:@selector(gridCell:columnFrameWithColumnView:columnModel:index:)]) {
                        frame = [self.delegate gridCell:self columnFrameWithColumnView:view columnModel:columnModel index:i];
                    }else{
                        frame = CGRectMake(frameX, frameY, columnModel.width, self.frame.size.height);
                        frameX += columnModel.width;
                    }
                    view.frame = frame;
                }
            }
        }
    }
}


-(void)initContentOffset:(CGPoint)contentOffset{
    if (self.fatherCell) {
        self.fatherCell.scrollView.contentOffset = contentOffset;
    }
}

-(void)witchViewDidDrag:(UIView *)witchView scrollViewDidScroll:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    if ([witchView isKindOfClass:[TFGridViewCell class]]) {
        TFGridViewCell *witchCell = (TFGridViewCell *)witchView;
        if ([self.syncScrollIdentifier isEqualToString:witchCell.syncScrollIdentifier]) {
            self.fatherCell.scrollView.contentOffset = scrollView.contentOffset;
        }
    }else if ([witchView isKindOfClass:[TFGridViewHeaderFooterView class]]) {
        TFGridViewHeaderFooterView *witchHeader = (TFGridViewHeaderFooterView *)witchView;
        if ([self.syncScrollIdentifier isEqualToString:witchHeader.syncScrollIdentifier]) {
            self.fatherCell.scrollView.contentOffset = scrollView.contentOffset;
        }
    }
    
}


- (void)witchViewDidDrag:(UIView *)witchView scrollViewWillBeginDragging:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    //NSLog(@"-------------------scrollViewWillBeginDragging:%@",NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)witchViewDidDrag:(UIView *)witchView scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate indexPath:(NSIndexPath *)indexPath{
    //NSLog(@"-------------------scrollViewDidEndDragging:%@",NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)witchViewDidDrag:(UIView *)witchView scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset indexPath:(NSIndexPath *)indexPath{
    //NSLog(@"-------------------scrollViewWillEndDragging:%@",NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)witchViewDidDrag:(UIView *)witchView scrollViewWillBeginDecelerating:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    //NSLog(@"-------------------scrollViewWillBeginDecelerating:%@",NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)witchViewDidDrag:(UIView *)witchView scrollViewDidEndDecelerating:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    //NSLog(@"-------------------scrollViewDidEndDecelerating:%@",NSStringFromCGPoint(scrollView.contentOffset));
}


-(void)setSyncScrollIdentifier:(NSString *)syncScrollIdentifier{
    _syncScrollIdentifier = [syncScrollIdentifier copy];
    if (_syncScrollIdentifier) {
        self.fatherCell.scrollView.scrollEnabled = YES;
    }else{
        self.fatherCell.scrollView.scrollEnabled = NO;
    }
}


-(NSMutableArray<TFGridColumnView *> *)columnViews{
    if (!_columnViews) {
        _columnViews = [[NSMutableArray alloc]init];
    }
    return _columnViews;
}

@end
