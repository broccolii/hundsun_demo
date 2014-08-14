//
//
//  Created by 王金东 on 14-7-3.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsWelcomeTableViewController.h"
#import "HsLinearLayoutViewController.h"
#import "HsGridViewController.h"
#import "HsGridScorllViewController.h"
#import "HsLabelViewController.h"
#import "HsRichTextViewController.h"
#import "HsSegmentViewController.h"
#import "HsSampleIndexViewController.h"
#import "HsViewController.h"
#import "ShowAllImageViewController.h"
#import "HsFileSystemViewController.h"

typedef void(^ClickBlock)(NSString *title);

@interface MenuInfo : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,copy) ClickBlock clickblock;
+ (instancetype)menuWithTitile:(NSString *)title click:(ClickBlock)click;
@end

@implementation MenuInfo
+ (instancetype)menuWithTitile:(NSString *)title click:(ClickBlock)click{
    MenuInfo *menuInfo = [[MenuInfo alloc] init];
    menuInfo.title = title;
    menuInfo.clickblock = click;
    return menuInfo;
}
@end

@interface HsWelcomeTableViewController ()

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation HsWelcomeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"demo导航";
    
    self.dataArray = [NSArray arrayWithObjects:
    [MenuInfo menuWithTitile:@"线性布局" click:^(NSString *title){
        HsLinearLayoutViewController *controller = [[HsLinearLayoutViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }],
    [MenuInfo menuWithTitile:@"封装的UITableView" click:^(NSString *title){
        HsSampleIndexViewController *controller = [[HsSampleIndexViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }],
    [MenuInfo menuWithTitile:@"grid布局" click:^(NSString *title){
        HsGridViewController *controller = [[HsGridViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }],
    [MenuInfo menuWithTitile:@"会滚动的grid布局" click:^(NSString *title){
        HsGridScorllViewController *controller = [[HsGridScorllViewController alloc] init];
        controller.title = title;;
        [self.navigationController pushViewController:controller animated:YES];
    }],
    [MenuInfo menuWithTitile:@"能定位的lable控件" click:^(NSString *title){
        HsLabelViewController *controller = [[HsLabelViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }],
    [MenuInfo menuWithTitile:@"富文本控件" click:^(NSString *title){
        HsRichTextViewController *controller = [[HsRichTextViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }],
    [MenuInfo menuWithTitile:@"tab视图" click:^(NSString *title){
        HsSegmentViewController *controller = [[HsSegmentViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }],
    [MenuInfo menuWithTitile:@"基本控件" click:^(NSString *title){
        HsViewController *controller = [[HsViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }],
    [MenuInfo menuWithTitile:@"图片查看器" click:^(NSString *title){
        ShowAllImageViewController *controller  = [[ShowAllImageViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
    }],[MenuInfo menuWithTitile:@"特色文件系统" click:^(NSString *title){
        HsFileSystemViewController *controller = [[HsFileSystemViewController alloc] init];
        controller.title = title;
        [self.navigationController pushViewController:controller animated:YES];
        
    }],nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const cellID = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    MenuInfo *info = self.dataArray[indexPath.row];
    cell.textLabel.text = info.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuInfo *info = self.dataArray[indexPath.row];
    info.clickblock(info.title);
}
@end
