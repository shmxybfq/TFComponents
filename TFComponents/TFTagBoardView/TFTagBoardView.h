//
//  TFTagBoardView.h
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/12/11.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TFTagBoardView;
@protocol TFTagBoardViewDelegate <NSObject>
@required;
-(NSUInteger)numberOfCell;

-(CGFloat)tagBoardView:(TFTagBoardView *)tagBoardView widthForIndex:(NSUInteger)index;

-(UIView *)tagBoardView:(TFTagBoardView *)tagBoardView cellForIndex:(NSUInteger)index width:(CGFloat)width;

@end

@interface TFTagBoardView : UIView

@property(nonatomic,  weak) id<TFTagBoardViewDelegate>delegate;

@property(nonatomic,assign) UIEdgeInsets edge;
@property(nonatomic,assign) CGFloat rowMargin;
@property(nonatomic,assign) CGFloat columnMargin;
@property(nonatomic,assign) CGFloat rowHeight;

@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) NSMutableArray *cells;

-(CGSize)reloadData;

@end

NS_ASSUME_NONNULL_END
