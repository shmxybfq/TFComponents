//
//  TFWebNavgationBar.m
//  TFComponentsDemo
//
//  Created by Time on 2019/3/12.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFWebNavgationBar.h"

@implementation TFWebNavgationBar


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
//        kdeclare_weakself;
//        [UIImageView easyCoder:^(UIImageView *ins) {
//
//            weakSelf.backgroundImageView = ins;
//
//            [weakSelf addSubview:ins];
//            ins.backgroundColor = [UIColor clearColor];
//            ins.contentMode = UIViewContentModeScaleAspectFill;
//            [ins mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.left.bottom.right.equalTo(weakSelf);
//                make.height.mas_equalTo(64);
//            }];
//        }];
//
//
//        [UIButton easyCoder:^(UIButton *ins) {
//
//            weakSelf.titleButton = ins;
//            [weakSelf addSubview:ins];
//            [ins setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//            [ins setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
//            ins.titleLabel.font = [UIFont systemFontOfSize:14];
//            [ins mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(88);
//                make.right.mas_equalTo(-88);
//                make.bottom.equalTo(weakSelf);
//                make.height.mas_equalTo(44);
//            }];
//        }];
//
//
//        [UIButton easyCoder:^(UIButton *ins) {
//
//            weakSelf.backButton = ins;
//
//            [weakSelf addSubview:ins];
//            [ins setTitle:@"返回" forState:UIControlStateNormal];
//            [ins setTitle:@"返回" forState:UIControlStateHighlighted];
//            [ins setTitleColor:[UIColor blackColor]
//                      forState:UIControlStateNormal];
//            [ins setTitleColor:[UIColor blackColor]
//                      forState:UIControlStateHighlighted];
//            [ins setBackgroundColor:[UIColor clearColor]];
//            [ins mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(weakSelf);
//                make.left.equalTo(weakSelf);
//                make.width.height.mas_equalTo(44);
//            }];
//        }];
//
//        [UIButton easyCoder:^(UIButton *ins) {
//
//            weakSelf.closeButton = ins;
//
//            [weakSelf addSubview:ins];
//            [ins setTitle:@"关闭" forState:UIControlStateNormal];
//            [ins setTitle:@"关闭" forState:UIControlStateHighlighted];
//            [ins setTitleColor:[UIColor blackColor]
//                      forState:UIControlStateNormal];
//            [ins setTitleColor:[UIColor blackColor]
//                      forState:UIControlStateHighlighted];
//            [ins mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(weakSelf);
//                make.left.equalTo(weakSelf.backButton.mas_right);
//                make.width.height.mas_equalTo(44);
//            }];
//        }];
//
    }
    return self;
}



@end
