//
//  HsTabBarDelegate.m
//  hundsun_zjfae
//
//  Created by 王金东 on 14-7-30.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsTabBarDelegate.h"

@interface HsTabBarDelegate ()

@property (nonatomic,weak)  HsBaseTabBarController *tabBarController;

@property (nonatomic,weak)  HsBaseNavigationController *navigationController;

@end

@implementation HsTabBarDelegate


#pragma mark delegate
- (void)tabBarController:(HsBaseTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    self.tabBarController = tabBarController;
    self.navigationController = (HsBaseNavigationController *)viewController;
    
    NSUInteger index = tabBarController.selectedIndex;
    NSDictionary *dic = [self.indexViewcontrollers objectAtIndex:index];
    NSString *itemClickSelector = dic[@"itemClickSelector"];
    if(itemClickSelector.length > 0){
        SEL selector = NSSelectorFromString(itemClickSelector);
        if([self respondsToSelector:selector]){
            [self performSelector:selector];
        }
    }
}
//login方法可在UISetting.plist里面配置
- (void)login{
   
}

@end
