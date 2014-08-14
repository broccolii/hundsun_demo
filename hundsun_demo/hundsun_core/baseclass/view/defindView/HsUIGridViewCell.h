//
//  HsUIGridViewCell.h
//  hundsun_zjfae
//
//  Created by 王金东 on 14-8-1.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HsUIKitHeader.h"

@protocol HsUIGridViewCellDelegate;

@interface HsUIGridViewCell : UIView
{
    UIImageView *backgroundImageView;
    HsUIGridViewCellStyle _style;
}

@property (nonatomic,assign) id info;
@property (nonatomic,strong) UIImageView *imageView;//居上的 imageview

@property (nonatomic,strong) UILabel *title;//居上的 lableview

@property (nonatomic,strong) UILabel *content;//居低的 描述内容

@property (nonatomic,assign) HsUIGridViewPading imageMargin;//图片 偏距

@property (nonatomic,assign) CGFloat titleMargin;//标题偏距

@property (nonatomic,strong) UIImage *backgroundImage;//背景图片

@property (nonatomic,strong) UIImage *deleteImage;//编辑图片

@property (nonatomic,strong)  UIColor *normalColor;//正常背景颜色

@property (nonatomic,strong) UIColor *selectedColor;//选择后的背景颜色

@property (nonatomic,assign) id<HsUIGridViewCellDelegate> delegate;

@property (nonatomic,assign) BOOL enabled;//是否可点击

@property (nonatomic,assign) BOOL canDelete;

- (id)initWithStyle:(HsUIGridViewCellStyle)style;

- (id)initWithStyle:(HsUIGridViewCellStyle)style frame:(CGRect)frame DEPRECATED_ATTRIBUTE; //创建指定类型的cell

@end

@protocol HsUIGridViewCellDelegate <NSObject>

- (void)didSelected:(HsUIGridViewCell*)cell;
- (void)didDeleted:(HsUIGridViewCell*)cell;

@end
