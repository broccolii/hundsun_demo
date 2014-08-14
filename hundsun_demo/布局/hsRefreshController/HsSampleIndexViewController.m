//
//  HsSampleIndexViewController.m
//  快速集成下拉刷新
//
//  Created by Hs on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//
/*
 具体用法：查看HsRefresh.h
 */
#import "HsSampleIndexViewController.h"
#import "HsSampleIndex.h"
#import "HsRefreshTableViewController.h"
#import "HsTableView1ViewController.h"
#import "HsTableView2ViewController.h"

NSString *const HsSampleIndexCellIdentifier = @"Cell";

@interface HsSampleIndexViewController ()
{
    NSArray *_sampleIndexs;
}
@end

@implementation HsSampleIndexViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"快速集成下拉刷新";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    // 1.注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:HsSampleIndexCellIdentifier];
    
    // 2.初始化数据
    HsSampleIndex *si1 = [HsSampleIndex sampleIndexWithTitle:@"tableView刷新演示" controllerClass:[HsRefreshTableViewController class]];
    HsSampleIndex *si2 = [HsSampleIndex sampleIndexWithTitle:@"封装好的tableviewcontroller" controllerClass:[HsTableView1ViewController class]];
     HsSampleIndex *si3 = [HsSampleIndex sampleIndexWithTitle:@"封装好的二级tableviewcontroller" controllerClass:[HsTableView2ViewController class]];
    _sampleIndexs = @[si1,si2,si3];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sampleIndexs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HsSampleIndexCellIdentifier forIndexPath:indexPath];
    
    // 1.取出模型
    HsSampleIndex *si = _sampleIndexs[indexPath.row];
    
    // 2.赋值
    cell.textLabel.text = si.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取出模型
    HsSampleIndex *si = _sampleIndexs[indexPath.row];
    
    // 2.创建控制器
    UIViewController *vc = [[si.controllerClass alloc] init];
    vc.title = si.title;

    // 3.跳转
    [self.navigationController pushViewController:vc animated:YES];
}

@end
