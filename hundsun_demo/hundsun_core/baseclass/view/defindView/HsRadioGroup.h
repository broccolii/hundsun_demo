//
//  HsRadioGroup.h
//  hundsun_zjfae
//
//  Created by 王金东 on 14-8-6.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, HsRadioGroupOrientation) {
    HsRadioGroupHorizontal,
    HsRadioGroupVertical,
};

typedef void(^HsRadioGroupSelectedBlock) (NSInteger position);


@interface HsRadioGroup : UIScrollView

@property (nonatomic,assign) CGFloat padding;

//排列方向
@property (nonatomic,assign) HsRadioGroupOrientation orientation;

//选中的block
@property (nonatomic,copy) HsRadioGroupSelectedBlock selectedBlock;

//选中字体颜色
@property (nonatomic,strong) UIColor *selectColor;
//未选中字体颜色
@property (nonatomic,strong) UIColor *unSelectColor;


//选中背景
@property (nonatomic,strong) UIImage *selectedBackgroundImage;
//未选中背景
@property (nonatomic,strong) UIImage *unSelectedBackgroundImage;

//选中的索引
@property (nonatomic,assign) NSInteger selectedIndex;


- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;

@end

@interface HsRadioGroupItem : NSObject

@property (nonatomic,strong) UIImage *selectedImage;
@property (nonatomic,strong) UIImage *unSelectedImage;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,assign) BOOL selected;

@property (nonatomic,strong) UIButton *button;

- (instancetype)initWithTitle:(NSString *)text selectedImage:(UIImage *)selectedImage unselectedImage:(UIImage *)unSelectedImage;

@end

