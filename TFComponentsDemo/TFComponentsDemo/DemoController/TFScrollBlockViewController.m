//
//  TFScrollBlockViewController.m
//  TFComponentsDemo
//
//  Created by 成丰快运 on 2021/1/28.
//  Copyright © 2021 ztf. All rights reserved.
//

#import "TFScrollBlockViewController.h"
#import "TFScrollBlockView.h"

#ifndef kSize
#define kSize [UIScreen mainScreen].bounds.size
#endif

@interface TFScrollBlockViewController ()<TFScrollBlockViewDelegate>

@property(nonatomic,strong)TFScrollBlockView *blockView;

@end

@implementation TFScrollBlockViewController


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blockView = [[TFScrollBlockView alloc]init];
    self.blockView.delegate = self;
    self.blockView.backgroundColor = [UIColor lightGrayColor];
    self.blockView.frame = CGRectMake(0, 88, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 88);
    [self.view addSubview:self.blockView];
    
    [self.blockView reload];
}


-(NSUInteger)numberOfCell{
    return 6;
}

-(CGFloat)blockView:(TFScrollBlockView *)blockView heightForIndex:(NSUInteger)index{
    return 200;
}

-(CGFloat)blockView:(TFScrollBlockView *)blockView marginForIndex:(NSUInteger)index totalCount:(NSUInteger)totalCount{
    return 10;
}

-(UIView *)blockView:(TFScrollBlockView *)blockView cellForIndex:(NSUInteger)index{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor redColor];
    return view;
}

-(CGFloat)blockView:(TFScrollBlockView *)blockView leftForIndex:(NSUInteger)index{
    return 20;
}

-(CGFloat)blockView:(TFScrollBlockView *)blockView widthForIndex:(NSUInteger)index{
    return 100;
}

@end
