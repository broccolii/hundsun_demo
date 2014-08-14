//
//  HsTableView1ViewController.m
//  HsDefindViewDemo
//
//  Created by 王金东 on 14-7-25.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsTableView1ViewController.h"
#import "HsTestTableViewCell.h"

@interface HsTableView1ViewController ()

@end

@implementation HsTableView1ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //一行代码  只需要给数据源赋值就行
    //数组里面暂时支持字符串、字典2种类型
    //字典用 HsCellKeyForTitleView作为title的key 其他请看HsTableViewCell里面有介绍
    //也可以用self.tableView.keyForTitleView 指定你需要的key
    
    self.itemsArray = [NSMutableArray arrayWithObjects:@{HsCellKeyForTitleView:@"我是第1行"},
                       @{HsCellKeyForTitleView:@"我是第2行"},@{HsCellKeyForTitleView:@"我是第3行"},@{HsCellKeyForTitleView:@"我是第4行"},@{HsCellKeyForTitleView:@"我是第5行"},@{HsCellKeyForTitleView:@"我是第6行"}, nil];
    
    //或者用下面也也可以
//    
//    self.itemsArray = [NSMutableArray arrayWithObjects:@"我是第1行", @"我是第2行", @"我是第3行" , @"我是第4行" , @"我是第5行" , @"我是第6行", nil];
    
    // Do any additional setup after loading the view.
}

@end
