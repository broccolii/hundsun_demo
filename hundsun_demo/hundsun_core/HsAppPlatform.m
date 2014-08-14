//
//  HsAppPlatform.m
//  hospitalcloud_sdzy
//
//  Created by 123 on 14-6-17.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "HsAppPlatform.h"

@implementation HsAppPlatform

+ (NSString *)bundleName{
     NSDictionary *dic    =   [[NSBundle mainBundle] infoDictionary];//获取info－plist
    NSString *name = dic[(NSString *)kCFBundleNameKey];
    if(name == nil){
        return @"";
    }
    return [@"_" stringByAppendingString:name];/*用BundleName取文件，一些文件在引用出错后给予错误提示*/
}

@end
