//
//  TFSquareBlockViewController.m
//  TFComponentsDemo
//
//  Created by Time on 2019/3/8.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFSquareBlockViewController.h"
#import "TFSquareBlockView.h"
@interface TFSquareBlockViewController ()<TFSquareBlockViewDelegate>

@property(nonatomic,strong)TFSquareBlockView *block;

@end

@implementation TFSquareBlockViewController

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.block = [[TFSquareBlockView alloc]initWithFrame:CGRectMake(0, 88, size.width, size.height - 88)];
    self.block.delegate = self;
    self.block.countPerLine = 5;
    self.block.lineSpace = 20;
    self.block.cellSpace = 30;
    self.block.edge = UIEdgeInsetsMake(50, 50, 50, 50);
    self.block.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.view addSubview:self.block];
    [self.block reload];
    
}

- (NSInteger)numberOfItems{
    return 200;
}
- (NSString *)cellReuseIdentifierOfIndexPath:(NSIndexPath *)indexPath{
    return @"UICollectionViewCell";
}
- (UICollectionViewCell *)collectionViewCell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0
                                           green:arc4random_uniform(255)/255.0
                                            blue:arc4random_uniform(255)/255.0 alpha:1];
    return cell;
}


@end
