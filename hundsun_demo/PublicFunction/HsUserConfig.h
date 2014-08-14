//
//  HsUserConfig.h
//  hospitalcloud
//
//  Created by hundsun on 14-3-15.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//


#import <Foundation/Foundation.h>
typedef void(^ClearLoginInfoBlock)(void);

@interface HsUserConfig : NSObject

//是否登陆
+ (BOOL)login;

+ (NSString *)userId;

+ (NSDictionary *)userInfo;

+ (NSString *)userAccount;

//保存用户信息
+ (void)saveUserInfo:(NSDictionary *)userInfo;

@end
