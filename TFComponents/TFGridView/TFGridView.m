//
//  TFGridView.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/19.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFGridView.h"
#import "TFGridViewInnerCell.h"

@interface TFGridView ()<UITableViewDelegate,UITableViewDataSource,TFGridViewInnerCellDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableDictionary <NSString *,TFGridViewCell *>*gridCellPool;

@end

@implementation TFGridView

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        [self addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger count = 0;
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *tableCellId = NSStringFromClass([TFGridViewInnerCell class]);
    TFGridViewInnerCell *tableCell = [tableView dequeueReusableCellWithIdentifier:tableCellId];
    if (!tableCell) {
        tableCell = [[TFGridViewInnerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellId];
    }
    tableCell.indexPath = indexPath;
    
    TFGridViewCell *gridCell = nil;
    if ([self.dataSource respondsToSelector:@selector(gridView:cellForRowAtIndexPath:)]) {
        gridCell = [self.dataSource gridView:self cellForRowAtIndexPath:indexPath];
    }
    [tableCell reloadGridCell:gridCell];
    
 
    CGRect frame = gridCell.frame;
    if ([self.dataSource respondsToSelector:@selector(gridView:cellFrameForRowWithCell:atIndexPath:)]) {
        frame = [self.dataSource gridView:self cellFrameForRowWithCell:gridCell atIndexPath:indexPath];
    }
    [tableCell reloadGridCellFrame:frame];
    
    return tableCell;
}

-(void)reloadGridCellPool:(TFGridViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    NSString *key = indexPathToString(indexPath);
    [self.gridCellPool removeObjectForKey:key];
    if (cell) {
        [self.gridCellPool setObject:cell forKey:key];
    }
}

#pragma mark - TFGridViewInnerCellDelegate
- (void)innerCell:(TFGridViewCell *)cell scrollViewDidScroll:(UIScrollView *)scrollView indexPath:(NSIndexPath *)indexPath{
    NSArray *allKeys = self.gridCellPool.allKeys;
    for (NSString *key in allKeys) {
        TFGridViewCell *gridCell = [self.gridCellPool objectForKey:key];
        [gridCell cellDidDrag:cell scrollView:scrollView indexPath:indexPath];
    }
}


//static inline NSIndexPath *stringToIndexPath(NSString *string){
//    if ([string isKindOfClass:[NSString class]] && [string containsString:@"-"]) {
//        NSArray *comp = [string componentsSeparatedByString:@"-"];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[comp.lastObject integerValue] inSection:[comp.firstObject integerValue]];
//        return indexPath;
//    }
//    return nil;
//}

static inline NSString *indexPathToString(NSIndexPath *indexPath){
    if ([indexPath isKindOfClass:[NSIndexPath class]]) {
        NSString *string = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
        return string;
    }
    return nil;
}


#pragma mark - lazyLoad
-(NSMutableDictionary<NSString *,TFGridViewCell *>*)gridCellPool{
    if (!_gridCellPool) {
        _gridCellPool = [[NSMutableDictionary alloc]init];
    }
    return _gridCellPool;
}

@end
