//
//  HsBaseAppDelegate.h
//  hundsun_zjfae
//
//  Created by 王金东 on 14-8-8.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NimbusCore.h"
#import "NimbusCSS.h"


@interface HsBaseAppDelegate : UIResponder<UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, readonly, retain) NIStylesheetCache* stylesheetCache;

@end
