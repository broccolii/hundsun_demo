//
//  NSDictionary+convenience.m
//  hospitalcloud
//
//  Created by wjd on 14-5-12.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "NSDictionary+convenience.h"
#import <objc/runtime.h>

@implementation NSDictionary (convenience)

//字典对象转为实体对象
- (void)dictionaryToEntity:(NSObject*)entity{
    if (entity) {
        for (NSString *keyName in [self allKeys]) {
            //构建出属性的set方法
            NSString *destMethodName = [NSString stringWithFormat:@"set%@:",[keyName capitalizedString]]; //capitalizedString返回每个单词首字母大写的字符串（每个单词的其余字母转换为小写）
            SEL destMethodSelector = NSSelectorFromString(destMethodName);
            if ([entity respondsToSelector:destMethodSelector]) {
                [entity performSelector:destMethodSelector withObject:[self objectForKey:keyName]];
            }
        }//end for
    }//end if
}

//实体对象转为字典对象
+ (NSDictionary *)entityToDictionary:(id)entity{
    if([entity isKindOfClass:[NSDictionary class]]){
        return entity;
    }
    if([entity isKindOfClass:[NSArray class]]){
        return nil;
    }
    Class clazz = [entity class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    
    NSMutableDictionary *propertiesDic = [NSMutableDictionary dictionaryWithCapacity:count];

    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        const char* propertyName = property_getName(prop);
        //NSString *key = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSString *key = [NSString stringWithUTF8String:propertyName];
        //        const char* attributeName = property_getAttributes(prop);
        //        NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
        //        NSLog(@"%@",[NSString stringWithUTF8String:attributeName]);
        id value =  nil;
        SEL sel = NSSelectorFromString(key);
        if([entity respondsToSelector:sel]){
            value = [entity performSelector:sel];
        }
        if(value == nil){
            value = [NSNull null];
        }
        if(value != [NSNull null] && [value description] == nil){
            [propertiesDic setValue:[NSDictionary entityToDictionary:value] forKey:key];
        }else{
            [propertiesDic setValue:value forKey:key];
        }
    }
    free(properties);
    NSLog(@"%@", propertiesDic);
    return propertiesDic;
}

- (NSMutableDictionary *)toMutableDictionary{
    return [NSMutableDictionary dictionaryWithDictionary:self];
}

- (id)entityForKey:(NSString *)key{
    id obj = [self valueForKey:key];
    if(obj == NULL || (NSNull *)obj == [NSNull null]){
        return nil;
    }
    return obj;
}

@end
