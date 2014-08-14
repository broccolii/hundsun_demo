//
//  UIImage+convenience.h
//  hospitalcloud_jkhn
//
//  Created by wjd on 14-4-19.
//  Copyright (c) 2014年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ArrowsDirection){
    ArrowsDirectionUp,//三角朝上
    ArrowsDirectionDown,//三角朝下
    ArrowsDirectionLeft,//三角朝左
    ArrowsDirectionRight,//三角朝右
};

@interface UIImage (convenience)

//缩放大小
- (UIImage *)scaleToSize:(CGSize )size;

/**
 *从图片中按指定的位置大小截取图片的一部分
 * CGRect rect 要截取的区域
 */
- (UIImage *)imageInRect:(CGRect)rect;

//缩放倍数
- (UIImage *)scaleMultiple:(CGFloat )multiple;


//pragma mark 根据颜色生成uiimage
+ (UIImage *)createImageWithColor:(UIColor*)color;

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;


//创建虚线
+ (UIImage *)createDashImage:(UIColor *)color;

//画椭圆
+ (UIImage *)createEllipseImage:(UIColor *)color inSize:(CGSize)size;

//画圆角矩形
+ (UIImage *)createCornerArc:(UIColor *)color radius:(CGFloat)radius  inSize:(CGSize)size;

//创建三角指示器
+ (UIImage *)createArrowsImage:(UIColor *)color direction:(ArrowsDirection)direction inSize:(CGSize)size;


@end
