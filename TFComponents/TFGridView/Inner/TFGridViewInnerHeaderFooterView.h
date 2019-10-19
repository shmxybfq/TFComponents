//
//  TFGridViewInnerHeaderFooterView.h
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TFGridViewHeaderFooterView;
@class TFGridViewInnerHeaderFooterView;
@protocol TFGridViewInnerHeaderFooterViewDelegate <NSObject>

- (void)innerHeader:(TFGridViewInnerHeaderFooterView *)header scrollViewDidScroll:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath;

//- (void)innerCell:(TFGridViewInnerHeaderFooterView *)cell scrollViewWillBeginDragging:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath;
//
//- (void)innerCell:(TFGridViewInnerHeaderFooterView *)cell scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset indexPath:(NSIndexPath *)indexPath;
//
//- (void)innerCell:(TFGridViewInnerHeaderFooterView *)cell scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate indexPath:(NSIndexPath *)indexPath;
//
//- (void)innerCell:(TFGridViewInnerHeaderFooterView *)cell scrollViewWillBeginDecelerating:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath;
//
//- (void)innerCell:(TFGridViewInnerHeaderFooterView *)cell scrollViewDidEndDecelerating:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath;

@end

@interface TFGridViewInnerHeaderFooterView : UITableViewHeaderFooterView
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) NSIndexPath  *indexPath;
@property(nonatomic, strong) TFGridViewHeaderFooterView *__nullable header;
@property(nonatomic,   weak) id<TFGridViewInnerHeaderFooterViewDelegate>delegate;

-(void)reloadGridHeader:(TFGridViewHeaderFooterView *)header;
-(void)reloadGridHeaderFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
