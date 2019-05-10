//
//  TFSquareBlockView.h
//  TFComponentsDemo
//
//  Created by Time on 2019/3/8.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Const.h"

@class TFSquareBlockView;
@protocol TFSquareBlockViewDelegate <NSObject>
@required;
- (NSInteger)numberOfItems;
- (NSString *)cellReuseIdentifierOfIndexPath:(NSIndexPath *)indexPath;
- (UICollectionViewCell *)collectionViewCell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath;
- (void)squareBlockView:(TFSquareBlockView *)squareBlockView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface TFSquareBlockView : UIView

@property(nonatomic,assign)id<TFSquareBlockViewDelegate>delegate;
@property(nonatomic,assign)UIEdgeInsets edge;
@property(nonatomic,assign)NSInteger countPerLine;
@property(nonatomic,assign)CGFloat lineSpace;
@property(nonatomic,assign)CGFloat cellSpace;
@property(nonatomic,assign)UICollectionViewScrollDirection scrollDirection;

-(void)reload;

@end


