//
//  GridViewController.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "GridViewController.h"
#import "TFComponents.h"
@interface GridViewController ()
@property(nonatomic, strong) TFGridView *gridView;
@end

@implementation GridViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    TFGridView *gridView = [[TFGridView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    gridView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:gridView];
    self.gridView = gridView;
    
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
