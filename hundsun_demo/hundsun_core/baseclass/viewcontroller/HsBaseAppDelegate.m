//
//  HsBaseAppDelegate.m
//  hundsun_zjfae
//
//  Created by 王金东 on 14-8-8.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsBaseAppDelegate.h"

@implementation HsBaseAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString* pathPrefix = NIPathForBundleResource(nil, @"");
    _stylesheetCache = [[NIStylesheetCache alloc] initWithPathPrefix:pathPrefix];
    
    return YES;
}

@end
