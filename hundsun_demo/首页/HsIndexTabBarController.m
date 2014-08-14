//
//  HsIndexTabBarController.m
//  hundsun_zjfae
//
//  Created by 王金东 on 14-7-29.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsIndexTabBarController.h"
#import "HsBaseNavigationController.h"
#import "HsBaseTabBarController.h"

#import "HsTabBarDelegate.h"


@interface HsIndexTabBarController ()

@property (nonatomic,strong) NSArray *indexViewcontrollers;

@property (nonatomic,strong) HsTabBarDelegate *tabBarDelegate;

@end

@implementation HsIndexTabBarController

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
    self.tabBarDelegate = [[NSClassFromString([NSString stringWithBundleNameForKey:@"tabBarDelegate"]) alloc] init];
    self.delegate = self.tabBarDelegate;
    //创建tabbar
    NSMutableArray *localControllersArray = [NSMutableArray array];

    NSDictionary *uiDic = [NSDictionary dictionaryWithContentsOfFile:[NSString pathWithBundleNameForResource:@"UISetting" ofType:@"plist"]];
    self.indexViewcontrollers = uiDic[@"indexViewController"];
    
    //将界面配置信息给delegate类
    self.tabBarDelegate.indexViewcontrollers = self.indexViewcontrollers;
    
    for (NSDictionary *dic in self.indexViewcontrollers) {
        NSString *controllerClass = dic[@"controllerClass"];
        NSInteger itemTag = [dic[@"itemTag"] integerValue];
        NSString *itemText = dic[@"itemText"];
        NSString *itemImage = dic[@"itemImage"];
        NSString *itemSelectedImage = dic[@"itemSelectedImage"];
        HsBaseViewController *viewcontroller = [[NSClassFromString(controllerClass) alloc] init];
        viewcontroller.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"button_index"] target:self action:@selector(gotoIndex)];
        
        [self  addViewController:viewcontroller toArrays:localControllersArray title:itemText tag:itemTag defaultImage:[UIImage imageNamed:itemImage] selectedImage:[UIImage imageNamed:itemSelectedImage]];
        
    }
    // tab bar
    self.viewControllers = localControllersArray;
    // Do any additional setup after loading the view.
}

//跳转到首页
- (void)gotoIndex{
    //goto login
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
