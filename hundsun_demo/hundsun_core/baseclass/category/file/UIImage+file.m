//
//  UIImage+file.m
//  hospitalcloud
//
//  Created by 123 on 14-6-24.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "UIImage+file.h"
#import "HsAppPlatform.h"

@implementation UIImage (file)

+ (UIImage *)imageNamedWithIPhone5:(NSString *)name
{
    NSString *type = [name pathExtension];
    NSString *imgName = [name stringByDeletingPathExtension];
    if (iPhone5) {
        if(type.length > 0){
            imgName = [NSString stringWithFormat:@"%@-568h.%@",imgName,type];
        }else{
            imgName = [NSString stringWithFormat:@"%@-568h",imgName];
        }
    }else{
        imgName = name;
    }
    UIImage *image = [UIImage imageNamed:imgName];
    if(image == nil){
        image = [UIImage imageNamed:name];
    }
    return image;
}

//加载图片，可根据图片名称区别加载
+ (UIImage *)imageNamedWithBundleName:(NSString *)name{
    NSString *bundleName = [HsAppPlatform bundleName];
    UIImage *image =  [UIImage imageNamedWithIPhone5:[name stringByAppendingFormat:@"%@",bundleName]];
    if(image == nil){//如果带bundleName 没有，则从不带bundleName 去取。
        image = [UIImage imageNamedWithIPhone5:name];
    }
    return image;
}

@end
