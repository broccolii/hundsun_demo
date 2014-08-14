//
//  HsFileSystemViewController.m
//  hundsun_demo
//
//  Created by 王金东 on 14-8-14.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsFileSystemViewController.h"

@interface HsFileSystemViewController ()

@end

@implementation HsFileSystemViewController

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
    
    //字符串和颜色可通过下面方法获取
    //会从String_bundleName.strings和Color_bundleName.string文件中取
    //如果你没有设置bundleName(在info.plist中设置)或没有String_bundleName.strings文件
    //则会从String.strings和Color.string文件中取
    NSString *text = [NSString stringWithBundleNameForKey:@"hello"];
    UIColor *color = [UIColor colorWithBundleNameForKey:@"hellocolor"];
    [self.itemsArray addObject:text];
    [self.itemsArray addObject:@"我们都是从strings文件读取的哦"];
    [self.itemsArray addObject:@"文件也可以有继承的哦，带bundleName都继承了公共文件里面的属性"];
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
