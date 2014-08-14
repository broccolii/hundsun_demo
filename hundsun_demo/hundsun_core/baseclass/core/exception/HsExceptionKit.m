//
//  HsExceptionKit.m
//  hospitalcloud
//
//  Created by 123 on 14-6-19.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "HsExceptionKit.h"
#import "HsAppPlatform.h"

NSString *const HsExceptionKeyIsNull = @"key is null";
NSString *const HsExceptionUrlIsNull = @"url is null";
NSString *const HsExceptionStringIsNull = @"string is null";
NSString *const HsExceptionFileNoExist = @"file no exist";

@implementation HsExceptionKit

//从string_bundleName.strings里面判断是否为空
+ (void)checkExceptionWithBundleName:(NSString *)name reason:(NSString *)error forKey:(NSString *)key{
    NSString *table = [@"String" stringByAppendingString:[HsAppPlatform bundleName]];
    NSString *value = NSLocalizedStringFromTable(key, table, nil);
    if(value == nil || [key isEqualToString:value]){
        @throw [NSException exceptionWithName:name reason:[NSString stringWithFormat:@"%@ %@",key,error] userInfo:nil];
    }
}

+ (void)checkExceptionWithName:(NSString *)name reason:(NSString *)error forKey:(NSString *)key{
    NSString *value = NSLocalizedString(key, nil);
    if(value == nil || [key isEqualToString:value]){
        @throw [NSException exceptionWithName:name reason:[NSString stringWithFormat:@"%@ %@",key,error] userInfo:nil];
    }
}

+ (void)checkExceptionWithBundleName:(NSString *)exceptionname reason:(NSString *)error forFileName:(NSString *)fileName extension:(NSString *)extension{
    fileName = [fileName stringByAppendingFormat:@"%@",[HsAppPlatform bundleName]];
    [self checkExceptionWithName:exceptionname reason:error forFileName:fileName extension:extension];
}

/**
 **extension :后缀
 **/
+ (void)checkExceptionWithName:(NSString *)exceptionname reason:(NSString *)error forFileName:(NSString *)fileName extension:(NSString *)extension{
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:extension];
    if(url == nil){
        @throw [NSException exceptionWithName:exceptionname reason:[NSString stringWithFormat:@"%@ %@",fileName,error] userInfo:nil];
    }
}

@end
