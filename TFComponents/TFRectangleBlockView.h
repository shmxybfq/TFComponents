//
//  TFRectangleBlockView.h
//  TimeAR
//
//  Created by Time on 2019/3/13.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Const.h"

@class TFRectangleBlockView;
@protocol TFRectangleBlockViewDelegate <NSObject>
@required;
- (NSInteger)numberOfCells;
- (UIView  *)blockView:(TFRectangleBlockView *)blockView cellWithIndex:(NSInteger)index;
@end


@interface TFRectangleBlockView : UIView

@property(nonatomic,assign)id<TFRectangleBlockViewDelegate>delegate;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,assign)UIEdgeInsets edge;
@property(nonatomic,assign)NSInteger countPerLine;
@property(nonatomic,assign)CGFloat lineSpace;
@property(nonatomic,assign)CGFloat cellSpace;
@property(nonatomic,assign)CGFloat cellHeight;

-(void)reload;

@end


