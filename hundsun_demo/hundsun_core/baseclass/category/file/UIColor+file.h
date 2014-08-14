//
//  UIColor+hospitalcloud.h
//  hospitalcloud
//
//  Created by 123 on 14-6-20.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (file)

//从app中根据key来取颜色值 规则是先从Color_bundlename取，如果没有再从Color里面取
+ (instancetype)colorWithBundleNameForKey:(NSString *)key;

@end
