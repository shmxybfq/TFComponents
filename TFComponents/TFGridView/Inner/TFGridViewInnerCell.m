//
//  TFGridViewInnerCell.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFGridViewInnerCell.h"
#import "TFGridViewCell.h"

@interface TFGridViewInnerCell ()<UIScrollViewDelegate>


@end

@implementation TFGridViewInnerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return self;
}

-(void)reloadGridCell:(TFGridViewCell *)gridCell{
    [self.gridCell removeFromSuperview];
    self.gridCell = nil;
    
    if (gridCell) {
        self.gridCell = gridCell;
        [self.scrollView addSubview:self.gridCell];
    }
}

-(void)reloadGridCellFrame:(CGRect)frame{
    self.gridCell.frame = frame;
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
    if ([self.delegate respondsToSelector:@selector(innerCell:scrollViewDidScroll:indexPath:)]) {
        [self.delegate innerCell:self scrollViewDidScroll:self.scrollView indexPath:self.indexPath];
    }
}


@end
