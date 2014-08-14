//
//  UIColor+hospitalcloud.m
//  hospitalcloud
//
//  Created by 123 on 14-6-20.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "UIColor+file.h"
#import "HsAppPlatform.h"

@implementation UIColor (file)

+ (instancetype)colorWithBundleNameForKey:(NSString *)key{
    NSString *table = [@"Color" stringByAppendingString:[HsAppPlatform bundleName]];
    NSString *color = NSLocalizedStringFromTable(key, table, nil);
    if(color == nil || [key isEqualToString:color]){//如果color_bundleName 没有则从color公用的里面去取
        color = NSLocalizedStringFromTable(key,@"Color", nil);
        if(color == nil || [key isEqualToString:color]){//还没有则显示默认
            color = @"#000000";
        }
    }
    return [UIColor colorFromHexString:color];
}

@end
