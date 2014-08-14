//
//  UILabel+special.h
//  hundsun_zjfae
//
//  Created by 王金东 on 14-8-1.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (special)


+ (instancetype)labelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor lines:(NSInteger)lines font:(UIFont *)font frame:(CGRect)frame lineBreakMode:(NSLineBreakMode)lineBreakMode;

+ (instancetype)labelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor lines:(NSInteger)lines font:(UIFont *)font frame:(CGRect)frame;


+ (instancetype)labelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font frame:(CGRect)frame ;


+ (instancetype)labelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)frame;

+ (instancetype)labelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor lines:(NSInteger)lines frame:(CGRect)frame;

@end
