//
//  NSDictionary+convenience.h
//  hospitalcloud
//
//  Created by wjd on 14-5-12.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (convenience)

//字典对象转为实体对象
- (void)dictionaryToEntity:(NSObject*)entity;

//实体对象转为字典对象
+ (NSDictionary *)entityToDictionary:(id)entity;

//将NSDictionary 转换为NSMutableDictionary
- (NSMutableDictionary *)toMutableDictionary;

//排除null 和 NSNull
- (id)entityForKey:(NSString *)key;

@end
