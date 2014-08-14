//
//  UIBarButtonItem+special.m
//  hospitalcloud
//
//  Created by 123 on 14-7-1.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "UIBarButtonItem+special.h"
#import <objc/runtime.h>

static const void *editAction_block_Key = &editAction_block_Key;
static const void *editAction_tableview_Key = &editAction_tableview_Key;

@implementation UIBarButtonItem (special)

+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    return  [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
}

//根据image创建导航按钮
+ (instancetype)itemWithImage:(UIImage *)image target:(id)target action:(SEL)action{
    return  [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
}
- (void)updateTitle:(NSString *)title{
    UIView *view = self.customView;
    if([view isKindOfClass:[UIButton class]]){
        UIButton *btn = (UIButton *)view;
        CGSize size = [title textSizeOfFont:btn.titleLabel.font inSize:CGSizeMake(100, 20)];
        btn.frame = CGRectMake(0, 6, size.width+5, 30);
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

+ (instancetype)itemWithEditStyleAndBlock:(EditActionBlock) block{
    return [UIBarButtonItem itemWithEditStyleAndBlock:block tableView:nil];
}
+ (instancetype)itemWithEditStyleAndTableView:(UITableView *)tableView{
    return [UIBarButtonItem itemWithEditStyleAndBlock:nil tableView:tableView];
}
+ (instancetype)itemWithEditStyleAndBlock:(EditActionBlock) block tableView:(UITableView *)tableView{
    UIBarButtonItem *item = [UIBarButtonItem itemWithTitle:@"编辑" target:nil action:nil];
    if(self){
        UIView *view = item.customView;
        if([view isKindOfClass:[UIButton class]]){
            UIButton *btn = (UIButton *)view;
            [btn addTarget:item action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        if(block != nil){
            objc_setAssociatedObject(item, editAction_block_Key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
        if(tableView != nil){
            objc_setAssociatedObject(item, editAction_tableview_Key, tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    return item;
}

- (void)editAction:(UIButton *)btn{
    EditActionBlock block = objc_getAssociatedObject(self, editAction_block_Key);
    UITableView *tableview = objc_getAssociatedObject(self, editAction_tableview_Key);
    BOOL flag = YES;
    if(btn.tag == 0){
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        btn.tag = 1;
        flag = YES;
    }else{
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        btn.tag = 0;
        flag = NO;
    }
    if(block != nil){
        block(!flag);
    }
    if(tableview != nil){
        [tableview setEditing:flag animated:YES];
    }
}

@end
