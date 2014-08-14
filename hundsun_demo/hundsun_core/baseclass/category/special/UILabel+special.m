//
//  UILabel+special.m
//  hundsun_zjfae
//
//  Created by 王金东 on 14-8-1.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "UILabel+special.h"

@implementation UILabel (special)


+ (instancetype)labelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor lines:(NSInteger)lines  font:(UIFont *)font frame:(CGRect)frame lineBreakMode:(NSLineBreakMode)lineBreakMode{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.numberOfLines = lines;
    label.lineBreakMode = lineBreakMode;
    if(font != nil){
        label.font = font;
    }
    label.textColor = titleColor;
    label.text = title;
    return label;
}


+ (instancetype)labelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor lines:(NSInteger)lines font:(UIFont *)font frame:(CGRect)frame{
    return [UILabel labelWithTitle:title titleColor:titleColor lines:lines font:font frame:frame lineBreakMode:NSLineBreakByWordWrapping];
}


+ (instancetype)labelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font frame:(CGRect)frame{
    return [UILabel labelWithTitle:title titleColor:titleColor lines:0 font:font frame:frame lineBreakMode:NSLineBreakByWordWrapping];
}

+ (instancetype)labelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)frame{
    return [UILabel labelWithTitle:title titleColor:titleColor lines:0 font:nil frame:frame lineBreakMode:NSLineBreakByWordWrapping];
}

+ (instancetype)labelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor lines:(NSInteger)lines frame:(CGRect)frame{
    return [UILabel labelWithTitle:title titleColor:titleColor lines:lines font:nil frame:frame lineBreakMode:NSLineBreakByWordWrapping];
}


@end
