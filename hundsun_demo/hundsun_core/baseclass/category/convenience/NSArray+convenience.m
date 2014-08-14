//
//  NSArray+convenience.m
//  hospitalcloud_sdzy
//
//  Created by 123 on 14-6-11.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "NSArray+convenience.h"

@implementation NSArray (convenience)

- (NSMutableArray *)toMutableArray{
    NSMutableArray *array = [NSMutableArray array];
    for (id item in self) {
        if([item isKindOfClass:[NSDictionary class]]){
            [array addObject:[((NSDictionary *)item) toMutableDictionary]];
        }else if([item isKindOfClass:[NSArray class]]){
            [array addObject:[((NSArray *)item) toMutableArray]];
        }else{
            [array addObject:item];
        }
    }
    return array;
}

@end
