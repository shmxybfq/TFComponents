//
//  TFScrollTagViewController.m
//  TFComponentsDemo
//
//  Created by Time on 2019/3/8.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFScrollTagViewController.h"
#import "TFScrollTagView.h"
#ifndef kSize
#define kSize [UIScreen mainScreen].bounds.size
#endif

@interface TFScrollTagViewController ()<TFScrollTagViewDelegate>

@property(nonatomic,strong)TFScrollTagView *tagView;

@end

@implementation TFScrollTagViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tagView = [[TFScrollTagView alloc]init];
    self.tagView.delegate = self;
    self.tagView.backgroundColor = [UIColor lightGrayColor];
    self.tagView.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 60);
    [self.view addSubview:self.tagView];
    
    [self.tagView reload];
}



-(NSUInteger)numberOfCell{
    return 30;
}

-(CGFloat)tagView:(TFScrollTagView *)tagView widthForIndex:(NSUInteger)index{
    return arc4random_uniform(100) + 20;
}

-(CGFloat)tagView:(TFScrollTagView *)tagView marginForIndex:(NSUInteger)index totalCount:(NSUInteger)totalCount{
    return 20;
}

-(UIView *)tagView:(TFScrollTagView *)tagView cellForIndex:(NSUInteger)index{
    
    UIButton *view = [[UIButton alloc]initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor colorWithRed:arc4random()%255 / 255.0
                                           green:arc4random()%255 / 255.0
                                            blue:arc4random()%255 / 255.0 alpha:1];
    view.tag = index;
    [view addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
}

-(void)buttonClick:(UIButton *)ins{
    [self.tagView scrollToIndex:ins.tag];
}


@end
