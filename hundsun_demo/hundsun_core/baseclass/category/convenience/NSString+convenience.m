//
//  NSString+convenience.m
//  hospitalcloud_jkhn
//
//  Created by wjd on 14-4-19.
//  Copyright (c) 2014年 hundsun. All rights reserved.
//

#import "NSString+convenience.h"

@implementation NSString (convenience)
//手机号码验证
- (BOOL)isValidMobilePhone{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    if (!isMatch) {
        return NO;
    }
    return YES;
}
//邮箱
- (BOOL)isValidEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
//身份证号
- (BOOL)isValidIdentityCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

//从身份证上判断性别
+ (BOOL)sexInfo:(NSString *)identityCard{
    NSInteger sex = 0;
    if(identityCard.length == 15){
        sex = [[identityCard substringFromIndex:14] integerValue];
    }else if(identityCard.length == 18){
        sex = [[identityCard substringWithRange:NSMakeRange(16, 1)] integerValue];
    }
    return sex %2 == 0?NO:YES;
}

#pragma mark Time & Date
- (NSString*)stringOldFormat:(NSString*)format_old toNewFormat:(NSString*)format_new
{
	NSString* dateStr = self;
	//	Convert string to date object
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:format_old];
	NSDate *date = [dateFormat dateFromString:dateStr];
	//	Convert date object to desired output format
	[dateFormat setDateFormat:format_new];
	dateStr = [dateFormat stringFromDate:date];    
	return dateStr;
}

- (NSDate *)stringToDate:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:self];
}

#pragma mark Application

- (BOOL)openURL
{
	NSString* s = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:s]];
}

- (BOOL)canOpenURL
{
	NSString* s = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:s]];
}

#pragma mark 是否能打电话
- (BOOL)canTelPhone{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:"]];
}
//打电话
- (BOOL)telPhone{
    if([self canTelPhone]){
        return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self]]];
    }
    return NO;
}

#pragma mark URL

- (NSURL *)toURL{
    return [NSURL URLWithString:self];
}

/**
 ** 首字母大写 其他保持不变  capitalizedString是首字母大写，其他都变成小写了
 **/
- (NSString *)toCapitalizedString{
    if(self.length <= 1){
        return [self uppercaseString];
    }
    NSString *firstChar = [[self substringToIndex:1] uppercaseString];
    NSString *otherChar = [self substringFromIndex:1];
    return [firstChar stringByAppendingString:otherChar];
}

- (NSString*)UTF8Encoding
{
	return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


+ (NSString *)trimZeroOfFloat:(NSString *)stringFloat
{
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    int i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0') {
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}

////////////////////////////////////////////////////////
//获得字符串实际尺寸
- (CGSize)textSizeOfFont:(UIFont *)font inSize:(CGSize)size
{
    return [self textSizeOfFont:font inSize:size options:NSStringDrawingUsesLineFragmentOrigin];
    
}

- (CGSize)textSizeOfFont:(UIFont *)font inSize:(CGSize)size options:(NSStringDrawingOptions)options{
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize;
    if (IOS7)
    {
        CGRect rec = [self boundingRectWithSize:size
                                        options:options
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
        labelsize=CGSizeMake(ceil(rec.size.width), ceil(rec.size.height));
    }
    else
    {
        labelsize= [self sizeWithFont:font constrainedToSize:size lineBreakMode:0];
    }
    return labelsize;
}


//按银行家算法将float保留2位
+ (NSString *)float2ToString:(CGFloat)value{
    value = roundf((value+0.001)*100)/100;
    return [NSString trimZeroOfFloat:[NSString stringWithFormat:@"%.2f",value]];
}

//将stringJson转换为对象
- (id)JSONValue;
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

#pragma mark -------------- app基本功能 --------------

+ (NSString *)appName{
    NSDictionary *plistDic = [[NSBundle mainBundle] infoDictionary];//获取inof-plist；
    NSString *appName = plistDic[@"CFBundleDisplayName"];//获取CFBundleDisplayName
    return appName;
}

+ (NSDictionary *)appInfo{
    // NSString *deviceID   =   [[UIApplication sharedApplication] uuid];
    NSString *systemVersion   =   [[UIDevice currentDevice] systemVersion];//系统版本
    NSString *systemModel    =   [[UIDevice currentDevice] model];//是iphone 还是 ipad
    NSDictionary *dic    =   [[NSBundle mainBundle] infoDictionary];//获取info－plist
    NSString *appId  =   [dic objectForKey:@"CFBundleIdentifier"];//获取Bundle identifier
    NSString *appName  =   [dic objectForKey:@"CFBundleDisplayName"];//获取CFBundleDisplayName
    NSString *appVersion   =   [dic valueForKey:@"CFBundleVersion"];//获取Bundle Version
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:
                              systemVersion, @"systemVersion",
                              systemModel, @"systemModel",
                              appName, @"appName",
                              appId,@"appId",
                              appVersion, @"appVersion",nil];
    return userInfo;
}

@end