//
//  TFGridViewCell.h
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFGridViewInnerCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface TFGridViewCell : UIView

@property(nonatomic, weak) TFGridViewInnerCell *faterCell;
//禁止横向滚动同步,默认NO
@property(nonatomic, assign)BOOL disuseSyncHorizontalScroll;


/* 初始化contentOffset
 * 初始化的时候调用此方法告诉你当前indexPath的cell上次滚动到哪个位置
 */
-(void)initContentOffset:(CGPoint)contentOffset;

/* 同步滚动函数
 * 当cell设置disuseSyncHorizontalScroll==NO的情况下此方法会被调用,告诉你当前某个同步滚动cell滚动到哪个位置
 */
-(void)cellDidDrag:(TFGridViewCell *)witchCell scrollView:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
