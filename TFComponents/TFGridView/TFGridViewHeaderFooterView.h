//
//  TFGridViewHeaderFooterView.h
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFGridViewInnerHeaderFooterView.h"
#import "TFGridColumnView.h"
#import "TFGridColumnModel.h"
NS_ASSUME_NONNULL_BEGIN

@class TFGridColumnView;
@protocol TFGridViewHeaderFooterViewDelegate <NSObject>

@required
- (NSInteger)numberOfColumnInGridHeader:(TFGridViewHeaderFooterView *)gridHeader;
- (TFGridColumnView *)gridCell:(TFGridViewHeaderFooterView *)gridHeader columnViewWithIndex:(NSInteger)index;
- (TFGridColumnModel *)gridCell:(TFGridViewHeaderFooterView *)gridHeader columnModelWithColumnView:(TFGridColumnView *)columnView index:(NSInteger)index;
@optional
- (CGRect)gridCell:(TFGridViewHeaderFooterView *)gridHeader columnFrameWithColumnView:(TFGridColumnView *)columnView columnModel:(TFGridColumnModel *)columnModel index:(NSInteger)index;

@end


@interface TFGridViewHeaderFooterView : UIView

@property(nonatomic, weak) id<TFGridViewHeaderFooterViewDelegate>delegate;

@property(nonatomic, weak) TFGridViewInnerHeaderFooterView *fatherHeader;
//同步滚动id,相同id的view可接收到滚动消息,为nil时不可滚动,默认为nil
@property(nonatomic, copy)NSString *syncScrollIdentifier;

@property(nonatomic, assign) CGPoint initContentOffset;

-(void)reloadColumn;

/* 初始化contentOffset
 * 初始化的时候调用此方法告诉你当前indexPath的cell上次滚动到哪个位置
 */
-(void)initContentOffset:(CGPoint)contentOffset;

/* 同步滚动函数
 * 当cell设置disuseSyncHorizontalScroll==NO的情况下此方法会被调用,告诉你当前某个同步滚动cell滚动到哪个位置
 */
-(void)witchViewDidDrag:(UIView *)witchView scrollViewDidScroll:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath;

- (void)witchViewDidDrag:(UIView *)witchView scrollViewWillBeginDragging:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath;

- (void)witchViewDidDrag:(UIView *)witchView scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate indexPath:(NSIndexPath *)indexPath;

- (void)witchViewDidDrag:(UIView *)witchView scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset indexPath:(NSIndexPath *)indexPath;

- (void)witchViewDidDrag:(UIView *)witchView scrollViewWillBeginDecelerating:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath;

- (void)witchViewDidDrag:(UIView *)witchView scrollViewDidEndDecelerating:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
