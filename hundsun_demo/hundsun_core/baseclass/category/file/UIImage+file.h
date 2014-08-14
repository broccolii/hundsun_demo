//
//  UIImage+file.h
//  hospitalcloud
//
//  Created by 123 on 14-6-24.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (file)

//加载图片，可根据图片名称区别加载 iphone5的文件格式可以是name-568h.png
//-568后缀是可选的
+ (UIImage *)imageNamedWithIPhone5:(NSString *)name;

//加载图片，可根据图片名称区别加载 规则是先根据name_bundlename取，如果没有再从根据name取
//注：图片的名称可以加入-568.h来区分iphone5
+ (UIImage *)imageNamedWithBundleName:(NSString *)name;

@end
