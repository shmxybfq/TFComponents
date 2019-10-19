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

@end

@implementation GridDemoCell

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.productLabelOriginFrame = self.productLabel.frame;
    
    [self bringSubviewToFront:self.productLabel];
    [self bringSubviewToFront:self.markImageView];
}

-(void)cellDidDrag:(TFGridViewCell *)witchCell scrollView:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    [super cellDidDrag:witchCell scrollView:scrollView indexPath:indexPath];
    CGPoint offset = scrollView.contentOffset;
    
    CGRect markFrame = self.markImageView.frame;
    self.markImageView.frame = CGRectMake(offset.x, 0, markFrame.size.width, markFrame.size.height);
    
    
    CGRect productFrame = self.productLabel.frame;
    if ((scrollView.contentOffset.x + markFrame.size.width) >= self.productLabelOriginFrame.origin.x) {
        self.productLabel.frame = CGRectMake((scrollView.contentOffset.x + markFrame.size.width), 0, productFrame.size.width, productFrame.size.height);
    }else{
        self.productLabel.frame = self.productLabelOriginFrame;
    }
}


@end
