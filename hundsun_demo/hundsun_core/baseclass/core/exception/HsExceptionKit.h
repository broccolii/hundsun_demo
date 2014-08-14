//
//  HsExceptionKit.h
//  hospitalcloud
//
//  Created by 123 on 14-6-19.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const HsExceptionKeyIsNull;
extern NSString *const HsExceptionUrlIsNull;
extern NSString *const HsExceptionStringIsNull;
extern NSString *const HsExceptionFileNoExist;

@interface HsExceptionKit : NSObject

+ (void)checkExceptionWithName:(NSString *)name reason:(NSString *)error forKey:(NSString *)key;



+ (void)checkExceptionWithName:(NSString *)name reason:(NSString *)error forFileName:(NSString *)fileName extension:(NSString *)extension;

//文件名称会追加bundleName
+ (void)checkExceptionWithBundleName:(NSString *)exceptionname reason:(NSString *)error forFileName:(NSString *)fileName extension:(NSString *)extension;
//从string_bundleName.strings里面判断是否为空
+ (void)checkExceptionWithBundleName:(NSString *)name reason:(NSString *)error forKey:(NSString *)key;

@end
