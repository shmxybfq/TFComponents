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
    
    //预先保存某些浮动列的初始frame,以便滚动的时候满足条件时,将frame设置为初始值
    self.productLabelOriginFrame = self.productLabel.frame;
    
    //列浮动需要注意层次关系
    [self bringSubviewToFront:self.productLabel];
    [self bringSubviewToFront:self.markImageView];
}

-(void)initContentOffset:(CGPoint)contentOffset{
    [super initContentOffset:contentOffset];
    self.initContentOffset = contentOffset;
    [self displayWithOffset:contentOffset];
}

-(void)witchViewDidDrag:(TFGridViewCell *)witchCell scrollViewDidScroll:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    [super witchViewDidDrag:witchCell scrollViewDidScroll:scrollView indexPath:indexPath];
    [self displayWithOffset:scrollView.contentOffset];
}


//列自动滚动到边界0
//- (void)witchViewDidDrag:(UIView *)witchView scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate indexPath:(NSIndexPath *)indexPath{
//    if (decelerate == NO) {
//        [scrollView setContentOffset:[self getNearlyPoint:scrollView.contentOffset.x + [UIScreen mainScreen].bounds.size.width]
//                            animated:YES];
//    }
//}
//列自动滚动到边界1
//- (void)witchViewDidDrag:(UIView *)witchView scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset indexPath:(NSIndexPath *)indexPath{
//    *targetContentOffset = [self getNearlyPoint:(*targetContentOffset).x + [UIScreen mainScreen].bounds.size.width];
//}
////列自动滚动到边界2
//-(CGPoint)getNearlyPoint:(CGFloat)x{
//    return CGPointMake(x - [UIScreen mainScreen].bounds.size.width, 0);
//    UIView *nearlyView = nil;
//    CGFloat edgeX = x;
//    for (UIView *view in self.subviews) {
//        if (edgeX > view.frame.origin.x && edgeX < view.frame.origin.x + view.frame.size.width) {
//            nearlyView = view;break;
//        }
//    }
//    if (nearlyView) {
//        return CGPointMake(nearlyView.frame.origin.x + nearlyView.frame.size.width - [UIScreen mainScreen].bounds.size.width, 0);
//    }
//    return CGPointZero;
//}


//列悬浮
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
