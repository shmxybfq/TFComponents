//
//  TFGridView.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFGridView.h"
#import "TFGridViewInnerCell.h"
#import "TFGridViewInnerHeaderFooterView.h"
#import "UITableView+TFGridExtesion.h"
@interface TFGridView ()<UITableViewDelegate,UITableViewDataSource,TFGridViewInnerCellDelegate,TFGridViewInnerHeaderFooterViewDelegate>

@property(nonatomic, strong)NSMutableDictionary <NSString *,NSString *>*cellContentOffsetPool;
@property(nonatomic, assign)BOOL haveSectionHeaders;

@end

@implementation TFGridView


//1.自动吸附
//2.动态列
//3.头部同步滚动
- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

-(void)reloadData:(BOOL)loadMore{
    if (!loadMore) {
        self.haveSectionHeaders = NO;
        [self.cellContentOffsetPool removeAllObjects];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger count = 1;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInGridView:)]) {
        count = [self.dataSource numberOfSectionsInGridView:self];
    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = 0;
    if ([self.dataSource respondsToSelector:@selector(gridView:numberOfRowsInSection:)]) {
        count = [self.dataSource gridView:self numberOfRowsInSection:section];
    }
    return count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 60.0;
    if ([self.delegate respondsToSelector:@selector(gridView:heightForRowAtIndexPath:)]) {
        height = [self.delegate gridView:self heightForRowAtIndexPath:indexPath];
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //tableViewCell
    NSString *tableCellId = NSStringFromClass([TFGridViewInnerCell class]);
    TFGridViewInnerCell *tableCell = [tableView dequeueReusableCellWithIdentifier:tableCellId];
    if (!tableCell) {
        tableCell = [[TFGridViewInnerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellId];
    }
    tableCell.delegate = self;
    tableCell.indexPath = indexPath;
    
    //横向滚动cell
    TFGridViewCell *gridCell = nil;
    if ([self.dataSource respondsToSelector:@selector(gridView:cellForRowAtIndexPath:)]) {
        gridCell = [self.dataSource gridView:self cellForRowAtIndexPath:indexPath];
    }
    gridCell.fatherCell = tableCell;
    //刷新tableViewCell中的横向滚动cell
    [tableCell reloadGridCell:gridCell];
    if (gridCell.syncScrollIdentifier) {
        gridCell.fatherCell.scrollView.scrollEnabled = YES;
    }else{
        gridCell.fatherCell.scrollView.scrollEnabled = NO;
    }
    
    //frame
    CGRect frame = gridCell.frame;
    if ([self.dataSource respondsToSelector:@selector(gridView:cellFrameForRowWithCell:atIndexPath:)]) {
        frame = [self.dataSource gridView:self cellFrameForRowWithCell:gridCell atIndexPath:indexPath];
    }
    [tableCell reloadGridCellFrame:frame];

    //根据记录初始化滚动contentOffset
    if (gridCell.syncScrollIdentifier) {
        NSString *pointString = [self.cellContentOffsetPool objectForKey:gridCell.syncScrollIdentifier];
        [gridCell initContentOffset:CGPointFromString(pointString)];
    }
    
    if ([self.delegate respondsToSelector:@selector(gridView:cellDidLoadFinishWithCell:atIndexPath:)]) {
        [self.delegate gridView:self cellDidLoadFinishWithCell:gridCell atIndexPath:indexPath];
    }
    
    
    return tableCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 60.0;
    if ([self.delegate respondsToSelector:@selector(gridView:heightForHeaderInSection:)]) {
        height = [self.delegate gridView:self heightForHeaderInSection:section];
    }
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *tableHeaderId = NSStringFromClass([TFGridViewInnerHeaderFooterView class]);
    TFGridViewInnerHeaderFooterView *tableHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:tableHeaderId];
    if (!tableHeader) {
        tableHeader = [[TFGridViewInnerHeaderFooterView alloc]initWithReuseIdentifier:tableHeaderId];
    }
    tableHeader.delegate = self;
    tableHeader.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    
    
    //横向滚动cell
    TFGridViewHeaderFooterView *gridHeader = nil;
    if ([self.dataSource respondsToSelector:@selector(gridView:viewForHeaderInSection:)]) {
        gridHeader = (TFGridViewHeaderFooterView *)[self.delegate gridView:self viewForHeaderInSection:section];
    }
    gridHeader.fatherHeader = tableHeader;
    //刷新tableViewCell中的横向滚动cell
    [tableHeader reloadGridHeader:gridHeader];
    
    if (gridHeader.syncScrollIdentifier) {
        gridHeader.fatherHeader.scrollView.scrollEnabled = YES;
    }else{
        gridHeader.fatherHeader.scrollView.scrollEnabled = NO;
    }
    //frame
    CGRect frame = gridHeader.frame;
    if ([self.dataSource respondsToSelector:@selector(gridView:headerFrameForRowWithHeader:inSection:)]) {
        frame = [self.delegate gridView:self headerFrameForRowWithHeader:gridHeader inSection:section];
    }
    [tableHeader reloadGridHeaderFrame:frame];
    
   
    //根据记录初始化滚动contentOffset
    if (gridHeader.syncScrollIdentifier) {
        NSString *pointString = [self.cellContentOffsetPool objectForKey:gridHeader.syncScrollIdentifier];
        [gridHeader initContentOffset:CGPointFromString(pointString)];
    }
    if (tableHeader) {
        self.haveSectionHeaders = YES;
    }
    
    
    if ([self.delegate respondsToSelector:@selector(gridView:headerDidLoadFinishWithHeader:inSection:)]) {
        [self.delegate gridView:self headerDidLoadFinishWithHeader:gridHeader inSection:section];
    }
    return tableHeader;
}



#pragma mark - TFGridViewInnerCellDelegate
//滚动同步逻辑
//1.同步情况下，新出现的view需要同步offset
//2.非同步情况下，新出现的cell需要同步上一次记录的cell
//3.同步和非同步cell并存情况下，同步需要同步，不同步需要保持记录
//4.reload以后清空记录
- (void)innerCell:(TFGridViewInnerCell *)cell scrollViewDidScroll:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    if (cell.gridCell.syncScrollIdentifier) {
        [self syncScrollToSameIdentifier:cell.gridCell.syncScrollIdentifier witchView:cell.gridCell scrollViewDidScroll:scrollView indexPath:indexPath];
    }
}
- (void)innerCell:(TFGridViewInnerCell *)cell scrollViewWillBeginDragging:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    [self syncMethodToSameIdentifier:cell.gridCell.syncScrollIdentifier witchView:cell.gridCell methodName:NSStringFromSelector(_cmd) scrollViewDidScroll:scrollView willDecelerate:NO withVelocity:CGPointZero targetContentOffset:nil indexPath:indexPath];
}
- (void)innerCell:(TFGridViewInnerCell *)cell scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate indexPath:(NSIndexPath *)indexPath{
      [self syncMethodToSameIdentifier:cell.gridCell.syncScrollIdentifier witchView:cell.gridCell methodName:NSStringFromSelector(_cmd) scrollViewDidScroll:scrollView willDecelerate:decelerate withVelocity:CGPointZero targetContentOffset:nil indexPath:indexPath];
}
- (void)innerCell:(TFGridViewInnerCell *)cell scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset indexPath:(NSIndexPath *)indexPath{
    [self syncMethodToSameIdentifier:cell.gridCell.syncScrollIdentifier witchView:cell.gridCell methodName:NSStringFromSelector(_cmd) scrollViewDidScroll:scrollView willDecelerate:NO withVelocity:velocity targetContentOffset:targetContentOffset indexPath:indexPath];
}
- (void)innerCell:(TFGridViewInnerCell *)cell scrollViewWillBeginDecelerating:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
       [self syncMethodToSameIdentifier:cell.gridCell.syncScrollIdentifier witchView:cell.gridCell methodName:NSStringFromSelector(_cmd) scrollViewDidScroll:scrollView willDecelerate:NO withVelocity:CGPointZero targetContentOffset:nil indexPath:indexPath];
}
- (void)innerCell:(TFGridViewInnerCell *)cell scrollViewDidEndDecelerating:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
       [self syncMethodToSameIdentifier:cell.gridCell.syncScrollIdentifier witchView:cell.gridCell methodName:NSStringFromSelector(_cmd) scrollViewDidScroll:scrollView willDecelerate:NO withVelocity:CGPointZero targetContentOffset:nil indexPath:indexPath];
}

#pragma mark - TFGridViewInnerHeaderFooterViewDelegate
- (void)innerHeader:(TFGridViewInnerHeaderFooterView *)header scrollViewDidScroll:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    if (header.gridHeader.syncScrollIdentifier) {
        [self syncScrollToSameIdentifier:header.gridHeader.syncScrollIdentifier witchView:header.gridHeader scrollViewDidScroll:scrollView indexPath:indexPath];
    }
}
- (void)innerHeader:(TFGridViewInnerHeaderFooterView *)header scrollViewWillBeginDragging:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    [self syncMethodToSameIdentifier:header.gridHeader.syncScrollIdentifier witchView:header.gridHeader methodName:NSStringFromSelector(_cmd) scrollViewDidScroll:scrollView willDecelerate:NO withVelocity:CGPointZero targetContentOffset:nil indexPath:indexPath];
}

- (void)innerHeader:(TFGridViewInnerHeaderFooterView *)header scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset indexPath:(NSIndexPath *)indexPath{
     [self syncMethodToSameIdentifier:header.gridHeader.syncScrollIdentifier witchView:header.gridHeader methodName:NSStringFromSelector(_cmd) scrollViewDidScroll:scrollView willDecelerate:NO withVelocity:velocity targetContentOffset:targetContentOffset indexPath:indexPath];
}

- (void)innerHeader:(TFGridViewInnerHeaderFooterView *)header scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate indexPath:(NSIndexPath *)indexPath{
    [self syncMethodToSameIdentifier:header.gridHeader.syncScrollIdentifier witchView:header.gridHeader methodName:NSStringFromSelector(_cmd) scrollViewDidScroll:scrollView willDecelerate:decelerate withVelocity:CGPointZero targetContentOffset:nil indexPath:indexPath];
}

- (void)innerHeader:(TFGridViewInnerHeaderFooterView *)header scrollViewWillBeginDecelerating:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    [self syncMethodToSameIdentifier:header.gridHeader.syncScrollIdentifier witchView:header.gridHeader methodName:NSStringFromSelector(_cmd) scrollViewDidScroll:scrollView willDecelerate:NO withVelocity:CGPointZero targetContentOffset:nil indexPath:indexPath];
}

- (void)innerHeader:(TFGridViewInnerHeaderFooterView *)header scrollViewDidEndDecelerating:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    [self syncMethodToSameIdentifier:header.gridHeader.syncScrollIdentifier witchView:header.gridHeader methodName:NSStringFromSelector(_cmd) scrollViewDidScroll:scrollView willDecelerate:NO withVelocity:CGPointZero targetContentOffset:nil indexPath:indexPath];
}

#pragma mark - 同步滚动分发
//将滚动事件同步到同id的view
-(void)syncScrollToSameIdentifier:(NSString *)identifier witchView:(UIView *)witchView scrollViewDidScroll:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    
    [self.cellContentOffsetPool setObject:NSStringFromCGPoint(scrollView.contentOffset) forKey:identifier];
    
    //【方案2】只让显示的cell同步横向滚动,但是这样的话需要额外处理内存中没有跟着滚动的view
    NSArray *cells = [self.tableView visibleCells];
    for (TFGridViewInnerCell *visibleCell in cells) {
        if (visibleCell.gridCell != witchView && [visibleCell.gridCell.syncScrollIdentifier isEqualToString:identifier]) {
            [visibleCell.gridCell witchViewDidDrag:witchView scrollViewDidScroll:scrollView indexPath:indexPath];
        }
    }
    //section
    if (self.haveSectionHeaders) {
        NSArray *headers = [self.tableView visibleSectionHeaders:indexPath];
        for (TFGridViewInnerHeaderFooterView *visibleHeader in headers) {
            if (visibleHeader.gridHeader != witchView && [visibleHeader.gridHeader.syncScrollIdentifier isEqualToString:identifier]) {
                [visibleHeader.gridHeader witchViewDidDrag:visibleHeader.gridHeader scrollViewDidScroll:scrollView indexPath:indexPath];
            }
        }
    }
}


-(void)syncMethodToSameIdentifier:(NSString *)identifier
                        witchView:(UIView *)witchView
                       methodName:(NSString *)methodName
              scrollViewDidScroll:(UIScrollView *)scrollView
                   willDecelerate:(BOOL)decelerate
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
                        indexPath:(NSIndexPath *)indexPath{
    
    //【方案2】只让显示的cell同步横向滚动,但是这样的话需要额外处理内存中没有跟着滚动的view
    NSArray *cells = [self.tableView visibleCells];
    for (TFGridViewInnerCell *visibleCell in cells) {
        if (visibleCell.gridCell != witchView && [visibleCell.gridCell.syncScrollIdentifier isEqualToString:identifier]) {
            if ([methodName containsString:@"scrollViewWillBeginDragging"]) {
                [visibleCell.gridCell witchViewDidDrag:witchView scrollViewWillBeginDragging:scrollView indexPath:indexPath];
            }else if ([methodName containsString:@"scrollViewDidEndDragging"]) {
                [visibleCell.gridCell witchViewDidDrag:witchView scrollViewDidEndDragging:scrollView willDecelerate:decelerate indexPath:indexPath];
            }else if ([methodName containsString:@"scrollViewWillEndDragging"]) {
                [visibleCell.gridCell witchViewDidDrag:witchView scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset indexPath:indexPath];
            }else if ([methodName containsString:@"scrollViewWillBeginDecelerating"]) {
                [visibleCell.gridCell witchViewDidDrag:witchView scrollViewWillBeginDecelerating:scrollView indexPath:indexPath];
            }else if ([methodName containsString:@"scrollViewDidEndDecelerating"]) {
                [visibleCell.gridCell witchViewDidDrag:witchView scrollViewDidEndDecelerating:scrollView indexPath:indexPath];
            }
        }
    }
    //section
    if (self.haveSectionHeaders) {
        NSArray *headers = [self.tableView visibleSectionHeaders:indexPath];
        for (TFGridViewInnerHeaderFooterView *visibleHeader in headers) {
            if (visibleHeader.gridHeader != witchView && [visibleHeader.gridHeader.syncScrollIdentifier isEqualToString:identifier]) {
                if ([methodName containsString:@"scrollViewWillBeginDragging"]) {
                    [visibleHeader.gridHeader witchViewDidDrag:witchView scrollViewWillBeginDragging:scrollView indexPath:indexPath];
                }else if ([methodName containsString:@"scrollViewDidEndDragging"]) {
                    [visibleHeader.gridHeader witchViewDidDrag:witchView scrollViewDidEndDragging:scrollView willDecelerate:decelerate indexPath:indexPath];
                }else if ([methodName containsString:@"scrollViewWillEndDragging"]) {
                    [visibleHeader.gridHeader witchViewDidDrag:witchView scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset indexPath:indexPath];
                }else if ([methodName containsString:@"scrollViewWillBeginDecelerating"]) {
                    [visibleHeader.gridHeader witchViewDidDrag:witchView scrollViewWillBeginDecelerating:scrollView indexPath:indexPath];
                }else if ([methodName containsString:@"scrollViewDidEndDecelerating"]) {
                    [visibleHeader.gridHeader witchViewDidDrag:witchView scrollViewDidEndDecelerating:scrollView indexPath:indexPath];
                }
            }
        }
    }
    
}

#pragma mark - functionMethod

-(id)dequeueReusableCellWithIdentifier:(NSString *)identifier{
    return nil;
}

-(id)dequeueReusableSectionHeaderWithIdentifier:(NSString *)identifier{
    return nil;
}

#pragma mark - lazyLoad

-(NSMutableDictionary<NSString *,NSString *>*)cellContentOffsetPool{
    if (!_cellContentOffsetPool) {
        _cellContentOffsetPool = [[NSMutableDictionary alloc]init];
    }
    return _cellContentOffsetPool;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
    }
    return _tableView;
}

@end
