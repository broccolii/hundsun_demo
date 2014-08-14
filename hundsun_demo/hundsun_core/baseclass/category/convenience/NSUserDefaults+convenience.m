//
//  NSUserDefaults+convenience.m
//  hospitalcloud_sdzy
//
//  Created by 123 on 14-6-14.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "NSUserDefaults+convenience.h"

@implementation NSUserDefaults (convenience)

+ (void)saveValue:(id)value forKey:(NSString *)key{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setValue:value forKeyPath:key];
    [userdefault synchronize];
}

+ (id)getValueForKey:(NSString *)key{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    return [userdefault valueForKey:key];
}

@end
