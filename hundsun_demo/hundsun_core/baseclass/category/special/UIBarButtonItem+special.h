//
//  UIBarButtonItem+special.h
//  hospitalcloud
//
//  Created by 123 on 14-7-1.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditActionBlock)(BOOL edit);

@interface UIBarButtonItem (special)

//根据title字符串创建导航按钮
+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

//根据image创建导航按钮
+ (instancetype)itemWithImage:(UIImage *)image target:(id)target action:(SEL)action;


//跟新导航按钮的文本
- (void)updateTitle:(NSString *)title;

//自定义编辑按钮 下面参数block 和 tableView 都是在编辑按钮时触发执行
+ (instancetype)itemWithEditStyleAndBlock:(EditActionBlock) block;

+ (instancetype)itemWithEditStyleAndTableView:(UITableView *)tableView;

+ (instancetype)itemWithEditStyleAndBlock:(EditActionBlock) block tableView:(UITableView *)tableView;

@end
