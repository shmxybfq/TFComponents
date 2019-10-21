//
//  UITableView+TFGridExtesion.h
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TFGridViewInnerHeaderFooterView;

@interface UITableView (TFGridExtesion)

-(NSArray <TFGridViewInnerHeaderFooterView *>*)visibleSectionHeaders:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
