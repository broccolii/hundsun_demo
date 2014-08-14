//
//  HsTableView2ViewController.m
//  HsDefindViewDemo
//
//  Created by 王金东 on 14-7-26.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsTableView2ViewController.h"

@interface HsTableView2ViewController ()

@end

@implementation HsTableView2ViewController

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
    self.singleLineDeleteAction = ^(NSIndexPath *indexPath){
        NSLog(@"删除第%d行",(int)indexPath.row);
    };
    self.sectionable = YES;//二级列表要开启
    [self.itemsArray addObject:[NSMutableArray arrayWithObjects:@"我是1",@"我是12",@"我是13",@"我是14",@"我是15",@"我是16", nil]];
      [self.itemsArray addObject:[NSMutableArray arrayWithObjects:@"我是2",@"我是21",@"我是22",@"我是23",@"我是24",@"我是25",@"我是26", nil]];
      [self.itemsArray addObject:[NSMutableArray arrayWithObjects:@"我是3",@"我是31",@"我是32",@"我是33",@"我是34",@"我是35",@"我是36", nil]];
      [self.itemsArray addObject:[NSMutableArray arrayWithObjects:@"我是4",@"我是41",@"我是42",@"我是43",@"我是44",@"我是45", nil]];
      [self.itemsArray addObject:[NSMutableArray arrayWithObjects:@"我是5", nil]];
    self.refreshHeaderable = NO;//关掉头刷新
    self.refreshFooterable = NO;
    // Do any additional setup after loading the view.
}

- (NSString *)baseTableView:(HsBaseTableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"测试";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
