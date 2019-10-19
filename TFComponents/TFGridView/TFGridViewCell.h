//
//  TFGridViewCell.h
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TFGridViewInnerCell;
@interface TFGridViewCell : UIView

@property(nonatomic, weak) TFGridViewInnerCell *faterCell;


/* 子类重写
 * 当cell被拖动时调用本方法
 * 
 */
-(void)cellDidDrag:(TFGridViewCell *)witchCell scrollView:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
