//
//  ThemeManager.h
//  WXWeibo
//
//  Created by wei.chen on 13-5-14.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HsThemeManager : NSObject

//主题css名称
@property (nonatomic,strong) NSString *themeName;

+ (HsThemeManager *)shareInstance;

@end

