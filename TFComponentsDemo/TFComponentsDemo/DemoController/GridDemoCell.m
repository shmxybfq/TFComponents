//
//  GridDemoCell.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "GridDemoCell.h"

@interface GridDemoCell ()

@property(nonatomic, assign) CGRect productLabelOriginFrame;
@property(nonatomic, assign) CGPoint initContentOffset;

@end

@implementation GridDemoCell

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.productLabelOriginFrame = self.productLabel.frame;
    
    [self bringSubviewToFront:self.productLabel];
    [self bringSubviewToFront:self.markImageView];
    
    
    [self displayWithOffset:self.initContentOffset];
}

-(void)initContentOffset:(CGPoint)contentOffset{
    [super initContentOffset:contentOffset];
    self.initContentOffset = contentOffset;
    [self displayWithOffset:contentOffset];
}

-(void)cellDidDrag:(TFGridViewCell *)witchCell scrollView:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    [super cellDidDrag:witchCell scrollView:scrollView indexPath:indexPath];
    [self displayWithOffset:scrollView.contentOffset];
}

-(void)displayWithOffset:(CGPoint)offset{
    
    CGRect markFrame = self.markImageView.frame;
    self.markImageView.frame = CGRectMake(offset.x, 0, markFrame.size.width, markFrame.size.height);
    
    
    CGRect productFrame = self.productLabel.frame;
    if ((offset.x + markFrame.size.width) >= self.productLabelOriginFrame.origin.x) {
        self.productLabel.frame = CGRectMake((offset.x + markFrame.size.width), 0, productFrame.size.width, productFrame.size.height);
    }else{
        self.productLabel.frame = self.productLabelOriginFrame;
    }
}


@end
