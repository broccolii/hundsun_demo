//
//  HsUISegmentItem.h
//  HsUICustomSegmenControl
//
//  Created by wjd on 12-2-19.
//  Copyright (c) 2012年 wjd. All rights reserved.


#import <UIKit/UIKit.h>

@class HsUISegmentItem;
@protocol HsUISegmentItemDelegate <NSObject>
- (void)didTapOnItem:(HsUISegmentItem*)item;
@end
@interface HsUISegmentItem : UIView
{    
    UIImageView *backgroundImgView;
    UILabel *titleLabel;    
    NSInteger index;
}

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic) NSInteger index;

//字体
@property (nonatomic,strong) UIFont *titleFont;

//选中的字体颜色
@property (nonatomic,strong) UIColor *selectedColor;
@property (nonatomic,strong) UIColor *normalColor;

//选中的背景图片
@property (nonatomic,strong) UIImage *selectedBackgroundImage;

@property (nonatomic,strong) UIImage *unselectBackgroundImage;


@property (nonatomic,assign)id<HsUISegmentItemDelegate> delegate;

//背景
@property (nonatomic,strong)UIImageView *backgroundImgView;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString*)title isLastRightItem:(BOOL)state withBackgroundImage:(UIImage*)backImage;
//切换到选中状态
- (void)switchToSelected;
//切换到正常状态
- (void)switchToNormal;
@end
