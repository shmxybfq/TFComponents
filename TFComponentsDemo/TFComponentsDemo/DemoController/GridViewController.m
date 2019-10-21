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

    TFGridView *gridView = [[TFGridView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight -  64)];
    gridView.backgroundColor = [UIColor brownColor];
    gridView.delegate = self;
    gridView.dataSource = self;
    [self.view addSubview:gridView];
    self.gridView = gridView;
}

//同tableview
-(NSInteger)numberOfSectionsInGridView:(TFGridView *)gridView{
    return 3;
}

//同tableview
- (NSInteger)gridView:(TFGridView *)gridView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

//同tableview
-(CGFloat)gridView:(TFGridView *)gridView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

//同tableview
- (TFGridViewCell *)gridView:(TFGridView *)gridView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = NSStringFromClass([GridDemoCell class]);
    GridDemoCell *cell = [gridView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"GridDemoCell" owner:nil options:nil].firstObject;
    }
    //syncScrollIdentifier默认为nil,当为nil时不可滚动,相同id的cell或者sectionHeader可以同步滚动
    if (indexPath.section <= 1) {
        cell.syncScrollIdentifier = @"设置第一section和第二section同步滚动";
    }else{
        cell.syncScrollIdentifier = @"第三section和上面两个section不同步滚动";
    }
    return cell;
}

//返回cell的尺寸,如果尺寸大于行高,则cell内可以上下滑动
- (CGRect)gridView:(TFGridView *)gridView cellFrameForRowWithCell:(TFGridViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    return CGRectMake(0, 0, 900, 65);
}

//同tableview
-(CGFloat)gridView:(TFGridView *)gridView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
//同tableview
-(TFGridViewHeaderFooterView *)gridView:(TFGridView *)gridView viewForHeaderInSection:(NSInteger)section{
    NSString *headerId = NSStringFromClass([GridDemoSectionHeader class]);
    GridDemoSectionHeader *header = [gridView dequeueReusableSectionHeaderWithIdentifier:headerId];
    if (!header) {
        header = [[NSBundle mainBundle]loadNibNamed:@"GridDemoSectionHeader" owner:nil options:nil].firstObject;
    }
    //syncScrollIdentifier默认为nil,当为nil时不可滚动,相同id的cell或者sectionHeader可以同步滚动
    if (section <= 1) {
        header.syncScrollIdentifier = @"设置第一section和第二section同步滚动";
    }else{
        header.syncScrollIdentifier = @"第三section和上面两个section不同步滚动";
    }
    return header;
}

//同上
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
