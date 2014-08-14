//
//  HsBaseTabBarController.m
//  HsDefindViewDemo
//
//  Created by 王金东 on 14-7-26.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsBaseTabBarController.h"
#import "HsThemeManager.h"

@interface HsBaseTabBarController ()

@end

@implementation HsBaseTabBarController

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
    //注册刷新广播
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidLayoutWithTheme) name:ViewControllerReloadView object:nil];
    
    [self.tabBar setTranslucent:NO];
    
    //css样式
    if([self cssName] != nil){
        NIStylesheetCache* stylesheetCache =
        [(HsBaseAppDelegate *)[UIApplication sharedApplication].delegate stylesheetCache];
        NIStylesheet* stylesheet = [stylesheetCache stylesheetWithPath:[self cssName]];
        _dom = [[NIDOM alloc] initWithStylesheet:stylesheet];
        [_dom registerView:self.tabBar];
    }
}

- (NSString *)cssName{
    return [HsThemeManager shareInstance].themeName;
}

/**
 ** baseViewController的公共方法 可对viewController统一设置、刷新
 **/
- (void)viewDidLayoutWithTheme{
    if([HsThemeManager shareInstance].themeName != nil){
        NIStylesheetCache* stylesheetCache =
        [(HsBaseAppDelegate *)[UIApplication sharedApplication].delegate stylesheetCache];
        NIStylesheet *stylesheet = [stylesheetCache stylesheetWithPath:[HsThemeManager shareInstance].themeName];
        [_dom updateStylesheet:stylesheet];
        
        NICSSRuleset *ruleset = [_dom rulesetforClass:@"UITabBar"];
        UIColor *textColor =   [ruleset colorFromCssRuleForKey:@"color"];
        UIColor *tintColor = [ruleset colorFromCssRuleForKey:@"-ios-tint-color"];
        
        for (UIBarButtonItem *item in self.tabBar.items) {
            [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:textColor,NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
            [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:tintColor,NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
        }
        
    }
    [_dom refresh];
}

#pragma mark 将viewcontroller 添加到tab上
- (void)addViewController:(UIViewController *)viewcontroller toArrays:(NSMutableArray *)toArray title:(NSString *)title tag:(NSInteger)tag defaultImage:(UIImage *)defaultImage selectedImage:(UIImage *)selectedImage{
    //设置 tabbar
    UITabBarItem *barItem = nil;
    if(IOS7){
        barItem = [[UITabBarItem alloc] initWithTitle:title image:defaultImage selectedImage:selectedImage];
        barItem.tag = tag;
    }else{
        barItem = [[UITabBarItem alloc] initWithTitle:title image:nil tag:tag];
        [barItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:defaultImage];
    }
    viewcontroller.tabBarItem = barItem;
    
    NICSSRuleset *ruleset = [_dom rulesetforClass:@"UITabBar"];
    UIColor *textColor =   [ruleset colorFromCssRuleForKey:@"color"];
    UIColor *tintColor = [ruleset colorFromCssRuleForKey:@"-ios-tint-color"];
    
    [barItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:textColor, NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:tintColor, NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateSelected];

    //将viewcontroller加入导航控制器中
    HsBaseNavigationController *navigationController = [[HsBaseNavigationController alloc] initWithRootViewController:viewcontroller];
    [toArray addObject:navigationController];
    
    //设置controller的title
    viewcontroller.title = title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    //清理样式
    [_dom unregisterAllViews];
    _dom = nil;
    //取消通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
