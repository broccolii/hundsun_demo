//
//  UIButton+special.m
//  hospitalcloud
//
//  Created by 123 on 14-7-1.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "UIButton+special.h"
#import <objc/runtime.h>

#define UIButton_key_clicked	"UIButton.clicked"

@implementation UIButton (special)

#pragma mark 添加block事件
- (void)addTargetBlock:(TouchButtonBlock)block{
    objc_setAssociatedObject(self, UIButton_key_clicked, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)touchAction:(id)sender
{
    TouchButtonBlock block = objc_getAssociatedObject(self, UIButton_key_clicked);
    if (block) block(self);
}
#pragma mark 统一设置按钮样式
//设置提交按钮样式
- (void)setSubmitBtnStyle{
    [self setBackgroundImage:[[UIImage imageNamed:@"button_submit"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 4,10 , 4)] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithBundleNameForKey:@"buttonTextColor"] forState:UIControlStateNormal];
}
//设置操作按钮样式
- (void)setOperateBtnStyle{
    UIColor *titleColor = [UIColor colorWithRed:0.5 green:0.5 blue:1 alpha:1];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRed:0.7 green:0.7 blue:1 alpha:1] forState:UIControlStateHighlighted];
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [self.layer setBorderWidth:1.0]; //边框宽度
    [self addTarget:self action:@selector(buttonUpRecover:) forControlEvents:UIControlEventTouchUpInside];//button 点击回调方法
    [self addTarget:self action:@selector(buttonUpRecover:) forControlEvents:UIControlEventTouchUpOutside];//button 点击回调方法
    [self addTarget:self action:@selector(buttonDonwRecover:) forControlEvents:UIControlEventTouchDown];//button 点击回调方法
    //    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.5, 0.5, 1, 1 });
    [self.layer setBorderColor:titleColor.CGColor];//边框颜色
}
- (void)buttonDonwRecover:(UIButton *)btn{
    UIColor *titleColor = [UIColor colorWithRed:0.7 green:0.7 blue:1 alpha:1];
    [btn.layer setBorderColor:titleColor.CGColor];//边框颜色
}
- (void)buttonUpRecover:(UIButton *)btn{
    UIColor *titleColor = [UIColor colorWithRed:0.5 green:0.5 blue:1 alpha:1];
    [btn.layer setBorderColor:titleColor.CGColor];//边框颜色
}
//设置登陆按钮样式
- (void)setLoginBtnStyle{
    [self setBackgroundImage:[[UIImage imageNamed:@"button_login"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 4,10 , 4)] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithBundleNameForKey:@"loginBtnTextColor"] forState:UIControlStateNormal];
}

//设置取消按钮样式
- (void)setCancelBtnStyle{
}
//设置其他按钮样式
- (void)setOtherBtnStyle{
    [self setBackgroundImage:[[UIImage imageNamed:@"pink_button"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 4,10 , 4)] forState:UIControlStateNormal];
    
    [self setBackgroundImage:[[UIImage imageNamed:@"pink_button_hover"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 4,10 , 4)] forState:UIControlStateHighlighted];
}


//设置成蓝色背景
- (void)setBlueStyle{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[[UIImage imageNamed:@"button_blue_style"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
}

//设置成白色背景
- (void)setWhiteStyle{
    [self setTitleColor:[UIColor colorFromHexString:@"#333333"] forState:UIControlStateNormal];
    [self setBackgroundImage:[[UIImage imageNamed:@"button_white_style"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
}


#pragma mark 定制按钮
+ (instancetype)buttonWithTitle:(NSString *)title  titleColor:(UIColor *)titleColor backgroundImage:(UIImage *)backgroundImage frame:(CGRect)frame target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    if(backgroundImage != nil){
        [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (instancetype)buttonWithThemeTitle:(NSString *)title frame:(CGRect)frame target:(id)target action:(SEL)action{
    return [UIButton buttonWithTitle:title titleColor:[UIColor whiteColor] backgroundImage:[UIImage imageNamed:@"button_main"] frame:frame target:target action:action];
}

@end
