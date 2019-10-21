//
//  GridViewController.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "GridViewController.h"
#import "TFComponents.h"
#import "GridDemoCell.h"
#import "GridDemoSectionHeader.h"
@interface GridViewController ()<TFGridViewDelegate,TFGridViewDataSource>

@property(nonatomic, strong) TFGridView *gridView;

@end

@implementation GridViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    TFGridView *gridView = [[TFGridView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    gridView.backgroundColor = [UIColor brownColor];
    gridView.delegate = self;
    gridView.dataSource = self;
    [self.view addSubview:gridView];
    self.gridView = gridView;
}


- (NSInteger)gridView:(TFGridView *)gridView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)gridView:(TFGridView *)gridView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (TFGridViewCell *)gridView:(TFGridView *)gridView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = NSStringFromClass([GridDemoCell class]);
    GridDemoCell *cell = [gridView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"GridDemoCell" owner:nil options:nil].firstObject;
    }
    cell.syncScrollIdentifier = indexPath.row % 2 == 0?@"111":@"222";
    return cell;
}

- (CGRect)gridView:(TFGridView *)gridView cellFrameForRowWithCell:(TFGridViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    return CGRectMake(0, 0, 900, 65);
}

-(CGFloat)gridView:(TFGridView *)gridView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(TFGridViewHeaderFooterView *)gridView:(TFGridView *)gridView viewForHeaderInSection:(NSInteger)section{
    NSString *headerId = NSStringFromClass([GridDemoSectionHeader class]);
    GridDemoSectionHeader *header = [gridView dequeueReusableSectionHeaderWithIdentifier:headerId];
    if (!header) {
        header = [[NSBundle mainBundle]loadNibNamed:@"GridDemoSectionHeader" owner:nil options:nil].firstObject;
    }
    header.syncScrollIdentifier = section % 2 == 0?@"111":@"222";
    return header;
}
- (CGRect)gridView:(TFGridView *)gridView headerFrameForRowWithHeader:(TFGridViewHeaderFooterView *)header inSection:(NSInteger)section{
    return CGRectMake(0, 0, 900, 40);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.gridView reloadData];
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
