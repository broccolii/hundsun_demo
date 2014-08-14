//
//  NSDate+convenience.h
//
//  Created by in 't Veen Tjeerd on 4/23/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//

#define SECOND	(1)
#define MINUTE	(60 * SECOND)
#define HOUR	(60 * MINUTE)
#define DAY		(24 * HOUR)
#define MONTH	(30 * DAY)

#import <Foundation/Foundation.h>

@interface NSDate (Convenience)

//计算偏移月的日期
- (NSDate *)offsetMonth:(int)numMonths;

//计算偏移日的日期
- (NSDate *)offsetDay:(int)numDays;

//计算偏移小时的日期
- (NSDate *)offsetHours:(int)hours;

//计算当前月 多少天
- (int)numDaysInMonth;

//计算当前月第一天所在位置
- (int)firstWeekDayInMonth;

//获取年
- (int)year;

//获取月
- (int)month;

//获取天
- (int)day;

//本周第一天所在日期
+ (NSDate *)dateStartOfWeek;

//本周最后一天所在日期
+ (NSDate *)dateEndOfWeek;

//格式化日期
- (NSString *)stringOfFormat:(NSString *)format;

//时间戳
+ (long long)timeStamp;

//转换
- (NSString *)timeAgo;

// 返回距离aDate有多少天
- (NSInteger)distanceInDaysToDate:(NSDate *)aDate;

@end
