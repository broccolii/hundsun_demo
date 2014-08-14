//
//  HsTableViewController.m
//  快速集成下拉刷新
//
//  Created by Hs on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//
/*
 具体用法：查看HsRefresh.h
 */
#import "HsRefreshTableViewController.h"
#import "HsRefresh.h"

NSString *const HsTableViewCellIdentifier = @"Cell";

@interface HsRefreshTableViewController ()

@end

@implementation HsRefreshTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.refreshHeaderable = YES;//开启头刷新
    self.refreshFooterable = YES;//开启底部加载
    // 2.初始化假数据
    for (int i = 0; i<12; i++) {
        int random = arc4random_uniform(1000000);
        [self.itemsArray addObject:[NSString stringWithFormat:@"随机数据---%d", random]];
    }
}

//开始刷新数据
- (void)headerRereshing{
    // 增加5条假数据
    for (int i = 0; i<5; i++) {
        int random = arc4random_uniform(1000000);
        [self.itemsArray insertObject:[NSString stringWithFormat:@"随机数据---%d", random] atIndex:0];
    }
    // 模拟延迟加载数据，因此2秒后才调用）
    GCD_AfterBlock(^{
        [self didLoaded:HsBaseRefreshTableViewHeader];
    }, 2.0f);
    
}

//开始加载数据
- (void)footerRereshing{
    // 增加5条假数据
    for (int i = 0; i<5; i++) {
        int random = arc4random_uniform(1000000);
        [self.itemsArray addObject:[NSString stringWithFormat:@"随机数据---%d", random]];
    }
    
    // 模拟延迟加载数据，因此2秒后才调用）
    GCD_AfterBlock(^{
        [self didLoaded:HsBaseRefreshTableViewFooter];
    }, 2.f);
}

/**
 为了保证内部不泄露，在dealloc中释放占用的内存
 */
- (void)dealloc
{
    NSLog(@"HsTableViewController--dealloc---");
   // [_header free];
   // [_footer free];
}

@end
