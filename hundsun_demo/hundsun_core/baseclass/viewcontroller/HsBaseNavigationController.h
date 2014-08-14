//
//  HsBaseNavigationController.h
//  HsDefindViewDemo
//
//  Created by 王金东 on 14-7-26.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HsBaseAppDelegate.h"

@interface UINavigationController (APSafeTransition)

//界面正在transition
@property(nonatomic, assign, getter = isTransitionInProgress) BOOL transitionInProgress;

@end

@interface HsBaseNavigationController : UINavigationController

@property (nonatomic,strong) NIDOM *dom;


/**
 ** 替换最后一个viewcontroller
 **/
- (void)replaceLastViewController:(UIViewController*)withViewController animated:(BOOL)animated;

@end
