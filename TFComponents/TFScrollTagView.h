//
//  TFScrollTagView.h
//  TFComponentsDemo
//
//  Created by Time on 2019/3/8.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFScrollTagView;
@protocol TFScrollTagViewDelegate <NSObject>
@required;
-(NSUInteger)numberOfCell;

-(CGFloat)tagView:(TFScrollTagView *)tagView widthForIndex:(NSUInteger)index;

-(CGFloat)tagView:(TFScrollTagView *)tagView marginForIndex:(NSUInteger)index totalCount:(NSUInteger)totalCount;

-(UIView *)tagView:(TFScrollTagView *)tagView cellForIndex:(NSUInteger)index;

@end
NS_ASSUME_NONNULL_BEGIN

@interface TFScrollTagView : UIView

@property(nonatomic,  weak)id<TFScrollTagViewDelegate>delegate;
@property(nonatomic,strong)UIScrollView *scrollView;

-(void)reload;
-(void)scrollToIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
