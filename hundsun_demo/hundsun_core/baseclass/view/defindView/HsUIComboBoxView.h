//
//  UIComboBoxView.h
//  GTT_IOS
//
//  Created by allen.huang on 13-3-8.
//  Copyright (c) 2013年 allen.huang. All rights reserved.
//
/**
 **combbox控件  IOS用UIActionSheet实现样式
 **/
#import <UIKit/UIKit.h>

@protocol HsUIComboBoxViewDelegate;

@interface HsUIComboBoxView : UITextField<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSInteger currentRow;
@property (nonatomic, assign) BOOL defaultValue;
@property (nonatomic, assign) id<HsUIComboBoxViewDelegate> dataSource;
@property (nonatomic, strong) UIColor *bordColor;

//右侧三角的颜色
@property (nonatomic, strong) UIColor *arrowColor;


//初始化组件
- (void)initWithCompontes;
- (void)reloadData;
- (void)showInView:(UIView *)view;

@end


@protocol HsUIComboBoxViewDelegate <NSObject>

@optional

- (NSInteger)numberOfUIComboBoxView:(HsUIComboBoxView *)comboBoxView;

// 显示所有的行数
- (NSInteger)comboBoxView:(HsUIComboBoxView *)comboBoxView numberOfRowsInComponent:(NSInteger)component;

// 显示选择某一行时的数据
- (NSString *)comboBoxView:(HsUIComboBoxView *)comboBoxView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

- (void)comboBoxView:(HsUIComboBoxView *)comboBoxView didSelectedForRow:(NSInteger)row forComponent:(NSInteger)component;

@end