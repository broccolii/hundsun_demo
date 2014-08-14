//
//  CheckBox.h
//  GTT_IOS
//
//  Created by allen.huang on 13-8-9.
//  Copyright (c) 2013年 allen.huang. All rights reserved.
//
/**
 **checkbox  可以自定义图标
 **/
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CheckBoxStyle){
    CheckBoxStyleDefault,
    CheckBoxStyleNoTitle,
    CheckBoxStyleCustom,
};

@protocol HsUICheckBoxDelegate;

@interface HsUICheckBox : UIButton

@property(nonatomic, weak)id<HsUICheckBoxDelegate> delegate;
@property(nonatomic, assign)BOOL checked;
@property(nonatomic, strong)id userInfo;

@property(nonatomic,strong) UIImage *checkedImage;
@property(nonatomic,strong) UIImage *unCheckedImage;
@property(nonatomic,assign) CheckBoxStyle style;

@end

@protocol HsUICheckBoxDelegate <NSObject>

@optional

- (void)didSelectedCheckBox:(HsUICheckBox *)checkbox checked:(BOOL)checked;

@end