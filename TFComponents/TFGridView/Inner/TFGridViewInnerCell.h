//
//  TFGridViewInnerCell.h
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TFGridViewCell;
@class TFGridViewInnerCell;
@protocol TFGridViewInnerCellDelegate <NSObject>

- (void)innerCell:(TFGridViewInnerCell *)cell scrollViewDidScroll:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath;

- (void)innerCell:(TFGridViewInnerCell *)cell scrollViewWillBeginDragging:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath;

- (void)innerCell:(TFGridViewInnerCell *)cell scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset indexPath:(NSIndexPath *)indexPath;

- (void)innerCell:(TFGridViewInnerCell *)cell scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate indexPath:(NSIndexPath *)indexPath;

- (void)innerCell:(TFGridViewInnerCell *)cell scrollViewWillBeginDecelerating:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath;

- (void)innerCell:(TFGridViewInnerCell *)cell scrollViewDidEndDecelerating:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath;

@end

@interface TFGridViewInnerCell : UITableViewCell
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) NSIndexPath  *indexPath;
@property(nonatomic, strong) TFGridViewCell *__nullable gridCell;
@property(nonatomic,   weak) id<TFGridViewInnerCellDelegate>delegate;

-(void)reloadGridCell:(TFGridViewCell *)cell;
-(void)reloadGridCellFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
