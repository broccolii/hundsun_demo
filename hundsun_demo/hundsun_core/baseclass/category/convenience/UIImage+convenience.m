//
//  UIImage+convenience.m
//  hospitalcloud_jkhn
//
//  Created by wjd on 14-4-19.
//  Copyright (c) 2014年 hundsun. All rights reserved.
//

#import "UIImage+convenience.h"

@implementation UIImage (convenience)

-(UIImage *)scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


/**
 *从图片中按指定的位置大小截取图片的一部分
 * CGRect rect 要截取的区域
 */
- (UIImage *)imageInRect:(CGRect)rect {
    CGImageRef sourceImageRef = [self CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}




- (UIImage *)scaleMultiple:(CGFloat )multiple{
    // 压缩图片
    float compressWidth = self.size.width;
    float compressHeight = self.size.height;
    compressWidth = compressWidth * multiple;
    compressHeight = compressHeight * multiple;
    // 开始重绘图片内容
    CGSize size = CGSizeMake(compressWidth, compressHeight);
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, compressWidth, compressHeight)]; // 重新绘制图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    // 获得新图片
    // 完成重绘图片内容
    UIGraphicsEndImageContext();
    return newImage;
}


//pragma mark 根据颜色生成uiimage
+ (UIImage *)createImageWithColor:(UIColor*)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


//给UIImage添加的类别

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size{
    @autoreleasepool {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,
                                       
                                       color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }
}




+ (UIImage *)createDashImage:(UIColor *)color{
    const CGFloat lengths[2] = {1,1};//画2格点 空2个点
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, color.CGColor);
    CGContextSetLineDash(line, 0, lengths, 1);  //画虚线
    CGContextMoveToPoint(line, 0.0, 10.0);    //开始画线
    CGContextAddLineToPoint(line, 320.0, 10.0);
    CGContextStrokePath(line);
    return UIGraphicsGetImageFromCurrentImageContext();
}

+ (UIImage *)createEllipseImage:(UIColor *)color inSize:(CGSize)size{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color set];
    CGContextSetLineWidth(context, 1.0);
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, size.width,size.height)); //椭圆
    CGContextDrawPath(context, kCGPathFill);//kCGPathStroke
    return UIGraphicsGetImageFromCurrentImageContext();
}

+ (UIImage *)createCornerArc:(UIColor *)color radius:(CGFloat)radius inSize:(CGSize)size{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color set];
    float width = size.width;
    float height = size.height;    
    // 移动到初始点
    CGContextMoveToPoint(context, radius, 0);
    // 绘制第1条线和第1个1/4圆弧
    CGContextAddLineToPoint(context, width - radius, 0);
    CGContextAddArc(context, width - radius, radius, radius, -0.5 * M_PI, 0.0, 0);
    // 绘制第2条线和第2个1/4圆弧
    CGContextAddLineToPoint(context, width, height - radius);
    CGContextAddArc(context, width - radius, height - radius, radius, 0.0, 0.5 * M_PI, 0);
    
    // 绘制第3条线和第3个1/4圆弧
    CGContextAddLineToPoint(context, radius, height);
    CGContextAddArc(context, radius, height - radius, radius, 0.5 * M_PI, M_PI, 0);
    
    // 绘制第4条线和第4个1/4圆弧
    CGContextAddLineToPoint(context, 0, radius);
    CGContextAddArc(context, radius, radius, radius, M_PI, 1.5 * M_PI, 0);
    
    // 闭合路径
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFill);    
    
    return UIGraphicsGetImageFromCurrentImageContext();
}

+ (UIImage *)createArrowsImage:(UIColor *)color direction:(ArrowsDirection)direction inSize:(CGSize)size{
    if(color == nil){
        color = [UIColor colorWithRed:0.5 green:0.5 blue:0.6 alpha:0.5];
    }
    //支持retina高分的关键
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat x1 = 4,y1 = 4;
    CGFloat x2 = 0,y2 = 0;
    CGFloat x3 = 0,y3 = 0;
    if(direction == ArrowsDirectionDown){
        //箭头 Arrows
        x1 = 4,y1 = 4;
        x2 = size.width/2,y2 = size.height-4;
        x3 = size.width-4,y3 = 4;
    }else if(direction == ArrowsDirectionRight){
        x1 = 4,y1 = 4;
        x2 = size.width-4,y2 = size.height/2;
        x3 = 4,y3 = size.height-4;
    }else if(direction == ArrowsDirectionUp){
        x1 = 4,y1 = size.height-4;
        x2 = size.width/2,y2 = 4;
        x3 = size.width-4,y3 = size.height-4;
    }else if(direction == ArrowsDirectionLeft){
        x1 = size.width-4,y1 = 4;
        x2 = 4,y2 = size.height/2;
        x3 = size.width-4,y3 = size.height-4;
    }
    CGContextBeginPath(context);
    [color set];
   // CGContextSetRGBStrokeColor(context,0.5,0.5,0.5,0.8);//画笔线的颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
    CGContextMoveToPoint(context, x1, y1);
    CGContextAddLineToPoint(context,x2,y2);
    CGContextAddLineToPoint(context,x3,y3);
    //CGContextDrawPath(context, kCGPathFill);
    CGContextStrokePath(context);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
