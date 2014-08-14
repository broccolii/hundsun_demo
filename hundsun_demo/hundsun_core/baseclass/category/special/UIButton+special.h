//
//  UIButton+special.h
//  hospitalcloud
//
//  Created by 123 on 14-7-1.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchButtonBlock)(UIButton *);

@interface UIButton (special)

//添加block事件
- (void)addTargetBlock:(TouchButtonBlock)block;

//设置提交按钮样式
- (void)setSubmitBtnStyle;

//设置操作按钮样式
- (void)setOperateBtnStyle;

//设置登陆按钮样式
- (void)setLoginBtnStyle;

//设置取消按钮样式
- (void)setCancelBtnStyle;

//设置其他按钮样式
- (void)setOtherBtnStyle;

//设置成蓝色背景
- (void)setBlueStyle;

//设置成白色背景
- (void)setWhiteStyle;

/**
 ** 构造button
 **/

+ (instancetype)buttonWithTitle:(NSString *)title  titleColor:(UIColor *)titleColor backgroundImage:(UIImage *)backgroundImage frame:(CGRect)frame target:(id)target action:(SEL)action;


/**
 ** 主题色按钮
 **/
+ (instancetype)buttonWithThemeTitle:(NSString *)title frame:(CGRect)frame target:(id)target action:(SEL)action;

@end
