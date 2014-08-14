//
//  ThemeManager.m
//  WXWeibo
//
//  Created by wei.chen on 13-5-14.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "HsThemeManager.h"
#import "AppStorage.h"

static HsThemeManager *sigleton = nil;


#pragma mark thememanager

@implementation HsThemeManager
@synthesize themeName = _themeName;

- (void)setThemeName:(NSString *)themeName{
    if(_themeName != themeName){
        _themeName = themeName;
         NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setValue:themeName forKey:@"themeName"];
        [userDefault synchronize];
        
        [HsThemeManager sendChangeInTheme];
    }
}

- (NSString *)themeName{
    if(_themeName == nil){
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        _themeName = [userDefault valueForKey:@"themeName"];
        if(_themeName == nil){
            _themeName = [NSString stringWithBundleNameForKey:@"themeName"];
        }
    }
    return _themeName;
}

//限制当前对象创建多实例
#pragma mark - sengleton setting
+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sigleton == nil) {
            sigleton = [super allocWithZone:zone];
        }
    }
    return sigleton;
}


#pragma mark - 单列相关的方法
+ (HsThemeManager *)shareInstance {
    if (sigleton == nil) {
        @synchronized(self){
            sigleton = [[HsThemeManager alloc] init];
        }
    }
    return sigleton;
}

+ (void)sendChangeInTheme{
    [UINavigationController sendChangeInTheme];
}

@end
