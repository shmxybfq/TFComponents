//
//  UITableView+TFGridExtesion.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/21.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "UITableView+TFGridExtesion.h"
#import "TFGridViewInnerHeaderFooterView.h"
@implementation UITableView (TFGridExtesion)

-(NSArray <TFGridViewInnerHeaderFooterView *>*)visibleSectionHeaders:(NSIndexPath *)indexPath{
    
    CGFloat miny = self.contentOffset.y;
    CGFloat maxy = self.contentOffset.y + self.frame.size.height;
    
    NSMutableArray *visbleHeaders = [[NSMutableArray alloc]init];
    for (NSInteger i = indexPath.section; i>= 0; i--) {
        if (i < 0) break;
        UITableViewHeaderFooterView *header = [self headerViewForSection:i];
        if (header) {
            if (header.frame.origin.y + header.frame.size.height <= miny) {
                break;
            }else{
                if (![visbleHeaders containsObject:header]) {
                    [visbleHeaders addObject:header];
                }
            }
        }
    }
    for (NSInteger i = indexPath.section + 1; i < indexPath.section + 99; i++) {
        UITableViewHeaderFooterView *header = [self headerViewForSection:i];
        if (header) {
            if (header.frame.origin.y > maxy) {
                break;
            }else{
                if (![visbleHeaders containsObject:header]) {
                    [visbleHeaders addObject:header];
                }
            }
        }
    }
    return visbleHeaders;
}


@end
