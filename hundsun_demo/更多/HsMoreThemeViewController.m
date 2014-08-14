//
//  HsMoreThemeViewController.m
//  hundsun_zjfae
//
//  Created by 王金东 on 14-8-3.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsMoreThemeViewController.h"
#import "HsThemeManager.h"


@interface HsMoreThemeViewController ()

@end

@implementation HsMoreThemeViewController

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
    self.title = @"预设主题";
    [self.itemsArray addObject:@{HsCellKeyForTitleView:@"默认",@"themeName":@"default.css"}];
    [self.itemsArray addObject:@{HsCellKeyForTitleView:@"黑色",@"themeName":@"black.css"}];
    [self.itemsArray addObject:@{HsCellKeyForTitleView:@"蓝色",@"themeName":@"blue.css"}];
    [self.itemsArray addObject:@{HsCellKeyForTitleView:@"红色",@"themeName":@"red.css"}];
    [self.itemsArray addObject:@{HsCellKeyForTitleView:@"白色",@"themeName":@"white.css"}];
    
    // Do any additional setup after loading the view.
}

- (void)baseTableView:(HsBaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.itemsArray[indexPath.row];
    //设置主题
    [HsThemeManager shareInstance].themeName = dic[@"themeName"];
}




@end
