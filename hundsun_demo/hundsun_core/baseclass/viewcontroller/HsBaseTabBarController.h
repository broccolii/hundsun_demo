//
//  HsBaseTabBarController.h
//  HsDefindViewDemo
//
//  Created by 王金东 on 14-7-26.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HsBaseTabBarController : UITabBarController

@property (nonatomic,strong) NIDOM *dom;

//可重写css样式名称
- (NSString *)cssName;


// 将viewcontroller 添加到tab上
- (void)addViewController:(UIViewController *)viewcontroller toArrays:(NSMutableArray *)toArray title:(NSString *)title tag:(NSInteger)tag defaultImage:(UIImage *)defaultImage selectedImage:(UIImage *)selectedImage;

@end
