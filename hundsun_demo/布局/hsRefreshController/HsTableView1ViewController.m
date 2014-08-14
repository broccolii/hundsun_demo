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
    self.multiLineDeleteAction = ^(NSArray *indexPaths){
        for (NSIndexPath *indexPath in indexPaths) {
             NSLog(@"删除第%d行",(int)indexPath.row);
        }
    };
    self.itemsArray = [NSMutableArray arrayWithObjects:@"第一条",@"第二条",@"第三条",@"haha",nil];
    //如果需要自定义cell 需要写下面的代码
    self.tableViewCellClass = [HsTestTableViewCell class];
    self.refreshHeaderable = NO;//开启头刷新
    self.refreshFooterable = YES;//开启底部加载
    self.searchable = YES;//开启查询功能
    // Do any additional setup after loading the view.
}

@end
