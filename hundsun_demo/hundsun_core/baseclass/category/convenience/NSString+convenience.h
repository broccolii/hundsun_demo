//
//  NSString+convenience.h
//  hospitalcloud_jkhn
//
//  Created by wjd on 14-4-19.
//  Copyright (c) 2014年 hundsun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (convenience)

#pragma mark -------------- 字符串处理 -----------------
//验证手机号码
- (BOOL)isValidMobilePhone;
//验证邮件格式
- (BOOL)isValidEmail;
//身份证号
- (BOOL)isValidIdentityCard;
//从身份证上判断性别 NO为女  YES为男
+ (BOOL)sexInfo:(NSString *)identityCard;

#pragma mark  --------------	date操作   --------------
//从老的日期格式转换成新的日期格式
- (NSString *)stringOldFormat:(NSString*)format_old toNewFormat:(NSString*)format_new;

//string转date
- (NSDate *)stringToDate:(NSString *)format;

#pragma mark  --------------	url操作   --------------
//	application
- (BOOL)openURL;//打开url

- (BOOL)canOpenURL;//能否打开

- (BOOL)canTelPhone;//是否能打电话

- (BOOL)telPhone;//打电话
//	url操作
- (NSURL *)toURL;

#pragma mark -------------- 格式处理 --------------

/**
 ** 首字母大写 其他保持不变  capitalizedString是首字母大写，其他都变成小写了
 **/
- (NSString *)toCapitalizedString;

- (NSString *)UTF8Encoding;

//获得字符串实际尺寸
- (CGSize)textSizeOfFont:(UIFont *)font inSize:(CGSize)size;

//获得字符串实际尺寸
- (CGSize)textSizeOfFont:(UIFont *)font inSize:(CGSize)size options:(NSStringDrawingOptions)options;

//按银行家算法将float保留2位 
+ (NSString *)float2ToString:(CGFloat)value;

//将stringJson转换为对象
- (id)JSONValue;

#pragma mark -------------- app基本功能 --------------
//可以获取appname
+ (NSString *)appName;
//获取app信息
+ (NSDictionary *)appInfo;


@end