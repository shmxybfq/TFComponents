//
//  TFGridViewCell.h
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFGridViewInnerCell.h"
#import "TFGridColumnView.h"
#import "TFGridColumnModel.h"
NS_ASSUME_NONNULL_BEGIN

@class TFGridColumnView;
@protocol TFGridViewCellDelegate <NSObject>

@required
//返回列数
- (NSInteger)numberOfColumnInGridViewCell:(TFGridViewCell *)cell;
//返回每列的view
- (TFGridColumnView *)gridCell:(TFGridViewCell *)gridCell columnViewWithIndex:(NSInteger)index;
//返回每列的TFGridColumnModel
- (TFGridColumnModel *)gridCell:(TFGridViewCell *)gridCell columnModelWithColumnView:(TFGridColumnView *)columnView index:(NSInteger)index;
@optional
//返回每列TFGridColumnView的frame,如不实现,则每列自动按TFGridColumnModel的width依次无间距后排
- (CGRect)gridCell:(TFGridViewCell *)gridCell columnFrameWithColumnView:(TFGridColumnView *)columnView columnModel:(TFGridColumnModel *)columnModel index:(NSInteger)index;

@end

@interface TFGridViewCell : UIView

@property(nonatomic, weak) id<TFGridViewCellDelegate>delegate;

@property(nonatomic, weak) TFGridViewInnerCell *fatherCell;
//同步滚动id,相同id的view可接收到滚动消息,为nil时不可滚动,默认为nil
@property(nonatomic, copy)NSString *syncScrollIdentifier;

@property(nonatomic, assign) CGPoint initContentOffset;
//列吸附设置:对顺序横向排列(或横向排列+间距)支持好,对非常规布局(重叠/重叠+超长等)支持较差,如遇太复杂列吸附建议自己重写对应滚动函数实现
@property(nonatomic, assign) TFGridScrollPinType gridScrollPinType;

-(void)reloadColumn;

/* 初始化contentOffset
 * 初始化的时候调用此方法告诉你当前indexPath的cell上次滚动到哪个位置
 */
-(void)initContentOffset:(CGPoint)contentOffset;

/*
 * 同步滚动函数
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
