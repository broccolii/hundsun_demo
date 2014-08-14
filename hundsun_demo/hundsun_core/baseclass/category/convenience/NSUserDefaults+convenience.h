//
//  NSUserDefaults+convenience.h
//  hospitalcloud_sdzy
//
//  Created by 123 on 14-6-14.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (convenience)

//保存对象  一行代码就可以了
+ (void)saveValue:(id)value forKey:(NSString *)key;

//获取对象
+ (id)getValueForKey:(NSString *)key;

@end
