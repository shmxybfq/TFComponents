//
//  TFSquareBlockView.m
//  TFComponentsDemo
//
//  Created by Time on 2019/3/8.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFSquareBlockView.h"

@interface TFSquareBlockView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@property(nonatomic,strong)NSMutableArray *registCells;


@end

@implementation TFSquareBlockView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        self.flowLayout.minimumLineSpacing = 10;
        self.flowLayout.itemSize = CGSizeMake(100, 100);
        self.flowLayout.estimatedItemSize = CGSizeMake(100, 100);
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero
                                                collectionViewLayout:self.flowLayout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionView];
    }
    return self;
}

-(void)reload{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView reloadData];
}

-(void)setEdge:(UIEdgeInsets)edge{
    _edge = edge;
    [self resize];
}
-(void)setCountPerLine:(NSInteger)countPerLine{
    _countPerLine = countPerLine;
    [self resize];
}
-(void)setLineSpace:(CGFloat)lineSpace{
    _lineSpace = lineSpace;
    [self resize];
}
-(void)setCellSpace:(CGFloat)cellSpace{
    _cellSpace = cellSpace;
    [self resize];
}
-(void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection{
    _scrollDirection = scrollDirection;
    [self resize];
}
-(void)resize{
    CGRect sf = self.bounds;
    UIEdgeInsets ist = self.edge;
    CGFloat ls = self.lineSpace;
    CGFloat cs = self.cellSpace;
    NSInteger ct = self.countPerLine;
    CGFloat wh = (sf.size.width - ist.left - ist.right - cs * (ct - 1)) / ct;
    
    self.flowLayout.minimumLineSpacing = ls;
    self.flowLayout.itemSize = CGSizeMake(wh, wh);
    self.flowLayout.estimatedItemSize = CGSizeMake(wh, wh);
    self.flowLayout.scrollDirection = self.scrollDirection;
    self.flowLayout.sectionInset = ist;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfItems)]) {
        count = [self.delegate numberOfItems];
    }
    return count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier = nil;
    if ([self.delegate respondsToSelector:@selector(cellReuseIdentifierOfIndexPath:)]) {
        reuseIdentifier = [self.delegate cellReuseIdentifierOfIndexPath:indexPath];
    }
    if ([self.registCells containsObject:reuseIdentifier] == NO) {
        [collectionView registerClass:NSClassFromString(reuseIdentifier)
           forCellWithReuseIdentifier:reuseIdentifier];
        [self.registCells addObject:reuseIdentifier];
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                           forIndexPath:indexPath];;
    if (cell == nil) {
        cell = [[NSClassFromString(reuseIdentifier) alloc]init];
        cell.restorationIdentifier = reuseIdentifier;
    }
    if ([self.delegate respondsToSelector:@selector(collectionViewCell:indexPath:)]) {
        cell = [self.delegate collectionViewCell:cell indexPath:indexPath];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(squareBlockView:didSelectItemAtIndexPath:)]) {
        [self.delegate squareBlockView:self didSelectItemAtIndexPath:indexPath];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

-(UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    }
    return _flowLayout;
}

-(NSMutableArray *)registCells{
    if (_registCells == nil) {
        _registCells = [[NSMutableArray alloc]init];
    }
    return _registCells;
}

@end
