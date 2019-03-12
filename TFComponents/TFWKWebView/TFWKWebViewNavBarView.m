//
//  TFWKWebViewNavBarView.m
//  TFComponentsDemo
//
//  Created by Time on 2019/3/12.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFWKWebViewNavBarView.h"

@implementation TFWKWebViewNavBarView

-(UIImageView *)backgroundImageView{
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _backgroundImageView.backgroundColor = [UIColor clearColor];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}

-(UIButton *)titleButton{
    if (_titleButton == nil) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    }
    return _titleButton;
}

-(UIButton *)backButton{
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton setTitle:@"返回" forState:UIControlStateHighlighted];
        [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        _backButton.backgroundColor = [UIColor clearColor];
    }
    return _backButton;
}

-(UIButton *)closeButton{
    if (_closeButton == nil) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeButton setTitle:@"关闭" forState:UIControlStateHighlighted];
        [_closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    }
    return _closeButton;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize ss = self.bounds.size;
    
    self.backgroundImageView.frame = CGRectMake(0, 0, ss.width, ss.height);
    self.titleButton.frame = CGRectMake(80, ss.height - 44, ss.width - 80 * 2, 44);
    self.backButton.frame = CGRectMake(0, ss.height - 44, 40, 44);
    self.closeButton.frame = CGRectMake(44, ss.height - 44, 40, 44);
    
}

-(void)initView{
    
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.titleButton];
    [self addSubview:self.backButton];
    [self addSubview:self.closeButton];
    
}

@end
