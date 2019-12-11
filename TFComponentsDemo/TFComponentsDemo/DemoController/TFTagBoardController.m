//
//  TFTagBoardController.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/12/11.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFTagBoardController.h"
#import "TFComponents.h"
@interface TFTagBoardController ()<TFTagBoardViewDelegate>
@property(nonatomic, strong) TFTagBoardView *boardView;
@end

@implementation TFTagBoardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.boardView = [[TFTagBoardView alloc]initWithFrame:CGRectMake(10, 100, kScreenWidth - 20, 300)];
    self.boardView.delegate = self;
    [self.view addSubview:self.boardView];
    [self.boardView reload];
    
}

-(NSUInteger)numberOfCell{
    return arc4random_uniform(300);
}

-(CGFloat)tagBoardView:(TFTagBoardView *)tagBoardView widthForIndex:(NSUInteger)index{
    return arc4random_uniform(30) + 20;
}

-(UIView *)tagBoardView:(TFTagBoardView *)tagBoardView cellForIndex:(NSUInteger)index width:(CGFloat)width{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:arc4random()%255 / 255.0
    green:arc4random()%255 / 255.0
     blue:arc4random()%255 / 255.0 alpha:1];
    return view;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.boardView reload];
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
