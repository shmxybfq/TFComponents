//
//  TFGridView.h
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFGridViewCell.h"
#import "TFGridViewHeaderFooterView.h"
#import "TFGridConst.h"


NS_ASSUME_NONNULL_BEGIN

@class TFGridView;
@protocol TFGridViewDataSource <NSObject>

@required
- (NSInteger)gridView:(TFGridView *)gridView numberOfRowsInSection:(NSInteger)section;
- (TFGridViewCell *)gridView:(TFGridView *)gridView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGRect)gridView:(TFGridView *)gridView cellFrameForRowWithCell:(TFGridViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@optional
- (NSInteger)numberOfSectionsInGridView:(TFGridView *)gridView;

@end

@protocol TFGridViewDelegate <NSObject>

-(CGFloat)gridView:(TFGridView *)gridView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
-(CGFloat)gridView:(TFGridView *)gridView heightForHeaderInSection:(NSInteger)section;

-(TFGridViewHeaderFooterView *)gridView:(TFGridView *)gridView viewForHeaderInSection:(NSInteger)section;
- (CGRect)gridView:(TFGridView *)gridView headerFrameForRowWithHeader:(TFGridViewHeaderFooterView *)header inSection:(NSInteger)section;

@end



@interface TFGridView : UIView

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,  weak)id<TFGridViewDelegate>delegate;
@property(nonatomic,  weak)id<TFGridViewDataSource>dataSource;

-(void)reloadData;
-(id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
-(id)dequeueReusableSectionHeaderWithIdentifier:(NSString *)identifier;
@end

NS_ASSUME_NONNULL_END
