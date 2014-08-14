//
//  UITableView+convenience.m
//  GTT_IOS
//
//  Created by apple on 14-1-13.
//  Copyright (c) 2014年 allen.huang. All rights reserved.
//

#import "UITableView+convenience.h"

@implementation UITableView (convenience)

@dynamic separatorInsetAtIos7;

- (void)setSeparatorInsetAtIos7:(UIEdgeInsets)separatorInsetAtIos7{
    if(IOS7){
        self.separatorInset = separatorInsetAtIos7;
    }
}
- (UIEdgeInsets)separatorInsetAtIos7{
    if(IOS7){
        return self.separatorInset;
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)setExtraCellLineHidden{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
}

//取消选中状态
- (void)deselectCurrentRow{
     [self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
}
- (void)deselect{
    [self deselectRowAtIndexPath:[self indexPathForSelectedRow] animated:YES];
}

@end
