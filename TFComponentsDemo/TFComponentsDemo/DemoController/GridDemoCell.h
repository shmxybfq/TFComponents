//
//  GridDemoCell.h
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFGridViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface GridDemoCell : TFGridViewCell

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;

@end

NS_ASSUME_NONNULL_END
