//
//  HsUITableView3ViewController.m
//  hundsun_demo
//
//  Created by 王金东 on 14-8-14.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsUITableView3ViewController.h"
#import "HsTestTableViewCell.h"

@interface HsUITableView3ViewController ()

@end

@implementation HsUITableView3ViewController

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
