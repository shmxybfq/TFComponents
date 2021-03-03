//
//  TFScrollBlockView.h
//  TFComponentsDemo
//
//  Created by 成丰快运 on 2021/1/28.
//  Copyright © 2021 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@class TFScrollBlockView;
@protocol TFScrollBlockViewDelegate <NSObject>
@required;
-(NSUInteger)numberOfCell;

-(CGFloat)blockView:(TFScrollBlockView *)blockView heightForIndex:(NSUInteger)index;

-(CGFloat)blockView:(TFScrollBlockView *)blockView marginForIndex:(NSUInteger)index totalCount:(NSUInteger)totalCount;

-(UIView *)blockView:(TFScrollBlockView *)blockView cellForIndex:(NSUInteger)index;

@optional
-(CGFloat)blockView:(TFScrollBlockView *)blockView leftForIndex:(NSUInteger)index;

-(CGFloat)blockView:(TFScrollBlockView *)blockView widthForIndex:(NSUInteger)index;
@end


@interface TFScrollBlockView : UIView

@property(nonatomic,  weak)id<TFScrollBlockViewDelegate>delegate;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIView *contentBackgroundView;
@property(nonatomic,strong)NSMutableArray *cells;

-(void)reload;

@end

