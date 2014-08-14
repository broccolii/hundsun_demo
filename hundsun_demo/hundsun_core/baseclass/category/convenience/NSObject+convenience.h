//
//  NSObject+convenience.h
//  hospitalcloud_sdzy
//
//  Created by 123 on 14-6-12.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_NULL_STRING(__POINTER) \
(__POINTER == nil || \
__POINTER == (NSString *)[NSNull null] || \
![__POINTER isKindOfClass:[NSString class]] || \
![__POINTER length])

@interface NSObject (convenience)

#pragma mark 给对象增加额外属性
- (id)associatedObjectForKey:(NSString*)key;

- (void)setAssociatedObject:(id)object forKey:(NSString*)key;

#pragma mark 解析属性成字符串
- (NSString*)autoDescription;

//处理空对象
+ (instancetype)toTrimNull:(id)obj;


//判断是否为空
+ (BOOL)isNullObject:(id)obj;

//判断是否为空
+ (BOOL)isEmptyObject:(id)obj;

//将对象转换为json字符串
- (NSString *)toJSONString;

//将对象转换成utf8格式的字符串
- (NSString *)UTF8EncodingString;

@end
