//
//  NSObject+convenience.m
//  hospitalcloud_sdzy
//
//  Created by 123 on 14-6-12.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "NSObject+convenience.h"
#import <objc/runtime.h>
#import "NSDictionary+convenience.h"

static char associatedObjectsKey;

@implementation NSObject (convenience)

#pragma mark 给对象增加额外属性
- (id)associatedObjectForKey:(NSString*)key {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &associatedObjectsKey);
    return [dict objectForKey:key];
}

- (void)setAssociatedObject:(id)object forKey:(NSString*)key {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &associatedObjectsKey);
    if (!dict) {
        dict = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &associatedObjectsKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [dict setObject:object forKey:key];
}

- (NSString*)autoDescription
{
    NSDictionary *dic = [NSDictionary entityToDictionary:self];
    NSString *description =  [dic description];
    return [NSString stringWithFormat:@"[%@ {%@}]", NSStringFromClass([self class]),
            description];
}


//处理空对象
+ (instancetype)toTrimNull:(id)obj{
    if(obj == nil || obj == NULL || (NSNull *)obj == [NSNull null]){
        return nil;
    }
    return obj;
}

//判断是否为空
+ (BOOL)isNullObject:(id)obj{
    if(obj == nil || obj == NULL || (NSNull *)obj == [NSNull null]){
        return YES;
    }
    return NO;
}

//判断是否为空
+ (BOOL)isEmptyObject:(id)obj{
    if(obj == nil || obj == NULL || (NSNull *)obj == [NSNull null]){
        return YES;
    }
    if([obj isKindOfClass:[NSString class]]){
        NSString *str = obj;
        if(str.length == 0){
            return YES;
        }
    }else if([obj isKindOfClass:[NSArray class]]){
        NSArray *array = obj;
        if(array.count == 0){
            return YES;
        }
    }else if([obj isKindOfClass:[NSDictionary class]]){
        NSDictionary *dic = obj;
        if(dic.count == 0){
            return YES;
        }
    }
    return NO;
}

//将对象转换为json字符串
- (NSString *)toJSONString{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
}

- (NSString *)UTF8EncodingString
{
	if ( [self isKindOfClass:[NSNull class]] )
		return nil;
	if ( [self isKindOfClass:[NSString class]] )
	{
		return [(NSString *)self UTF8Encoding];
	}
	else if ( [self isKindOfClass:[NSData class]] )
	{
		NSData * data = (NSData *)self;
		return [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
	}
	else
	{
		return [NSString stringWithFormat:@"%@", [self autoDescription]];
	}
}


@end
