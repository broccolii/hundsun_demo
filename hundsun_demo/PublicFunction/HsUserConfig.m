//
//  HsUserConfig.m
//  hospitalcloud
//
//  Created by hundsun on 14-3-15.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "HsUserConfig.h"

static NSString *UerInfoKey = @"userInfo";

@implementation HsUserConfig{
    
}

//是否登陆
+ (BOOL)login{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefault valueForKey:UerInfoKey];
    if(userInfo != nil){
        return YES;
    }
    return NO;
}

+ (NSString *)userId{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefault valueForKey:UerInfoKey];
    return userInfo[@"id"];
}

+ (NSDictionary *)userInfo{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault valueForKey:UerInfoKey];
}

+ (NSString *)userAccount{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefault valueForKey:UerInfoKey];
    return userInfo[@"account"];
}

+ (void)saveUserInfo:(NSDictionary *)userInfo{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:userInfo forKey:UerInfoKey];
    [userDefault synchronize];
}

@end
