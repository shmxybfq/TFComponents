//
//  TFGridUnit.m
//  TFComponentsDemo
//
//  Created by zhutaofeng on 2019/10/24.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "TFGridUnit.h"
#import "TFGridViewCell.h"
#import "TFGridViewHeaderFooterView.h"

@implementation TFGridUnit


+(CGPoint)witchView:(UIView *)witchView scrollPin:(UIScrollView *)scrollView stopOffset:(CGPoint)offset subviews:(NSArray <UIView *>*)subviews{
    TFGridScrollPinType type = TFGridScrollPinTypeNone;
    if ([witchView isKindOfClass:[TFGridViewCell class]]) {
        type = ((TFGridViewCell *)witchView).gridScrollPinType;
    }else if ([witchView isKindOfClass:[TFGridViewHeaderFooterView class]]) {
       type = ((TFGridViewHeaderFooterView *)witchView).gridScrollPinType;
    }
    CGPoint targetPoint = CGPointZero;
    if (offset.x > 0 && subviews.count > 0) {
        CGFloat segmentBegin = 0;
        CGFloat segmentEnd = 0;
        for (NSInteger i = 0; i < subviews.count; i++) {
            CGRect frame = ((UIView *)[subviews objectAtIndex:i]).frame;
            if (i == 0) {
                segmentBegin = 0;
                segmentEnd = frame.origin.x + frame.size.width;
            }else{
                segmentBegin = segmentEnd;
                segmentEnd = frame.origin.x + frame.size.width;
            }
            if (type == TFGridScrollPinTypeLeft) {
                if (segmentEnd <= 0 || segmentEnd >= scrollView.contentSize.width) {
                    //超出滚动区域不处理,scrollView自动滚动到边界
                    break;
                }else{
                    if (offset.x >= segmentBegin && offset.x <= segmentEnd) {
                        targetPoint = CGPointMake(frame.origin.x, 0);
                        break;
                    }else{/*不在区域内*/}
                }
            }
            if (type == TFGridScrollPinTypeRight) {
                if (segmentEnd <= 0 || segmentEnd >= scrollView.contentSize.width) {
                    //超出滚动区域不处理,scrollView自动滚动到边界
                    break;
                }else{
                    CGFloat targetX = offset.x + scrollView.frame.size.width;
                    if (targetX >= segmentBegin && targetX <= segmentEnd) {
                        targetPoint = CGPointMake(offset.x + CGRectGetMaxX(frame) - targetX, 0);
                        break;
                    }else{/*不在区域内*/}
                }
            }
        }
    }
    return targetPoint;
}

@end
