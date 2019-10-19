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

@end

@interface TFGridViewInnerCell : UITableViewCell
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) NSIndexPath  *indexPath;
@property(nonatomic, strong) TFGridViewCell *gridCell;
@property(nonatomic,   weak) id<TFGridViewInnerCellDelegate>delegate;

-(void)reloadGridCell:(TFGridViewCell *)cell;
-(void)reloadGridCellFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
