//
//  HsUISegmentControl.h
//  HsUICustomSegmenControl
//
//  Created by wjd on 12-2-19.
//  Copyright (c) 2012年 wjd All rights reserved.

#import <UIKit/UIKit.h>
#import "HsUISegmentItem.h"

@class HsUISegmentControl;
@protocol HsUISegmentControlDataSource <NSObject>

//菜单里面有多少项
- (NSInteger)numberOfItemsInSegmentControl:(HsUISegmentControl*)sgmCtrl;

//每一项得宽度是多少
- (CGFloat)widthForEachItemInsegmentControl:(HsUISegmentControl*)sgmCtrl index:(NSInteger)index;

//对应索引项得标题是什么
- (NSString*)segmentControl:(HsUISegmentControl*)sgmCtrl titleForItemAtIndex:(NSInteger)index;

@optional
//菜单选中了哪一项
- (void)segmentControl:(HsUISegmentControl*)sgmCtrl didSelectAtIndex:(NSInteger)index;
@end

@interface HsUISegmentControl : UIView<HsUISegmentItemDelegate,UIScrollViewDelegate>
{    
    UIScrollView *backScrollView;
    NSInteger lastSelectedIndex;
    NSInteger allItemsCount;
    UIView *bottomView;
}
//数据源
@property (nonatomic,assign) id<HsUISegmentControlDataSource> dataSource;

//会移动的view
@property (nonatomic,strong) UIImageView *moveImgView;
@property (nonatomic)NSInteger selectedIndex;
@property (nonatomic,strong) UIFont *titleFont;

//第一个item的背景图片
@property (nonatomic,strong) UIImage *itemBackgroundImageLeft;
//最后一个的背景图片
@property (nonatomic,strong) UIImage *itemBackgroundImageRight;
//中间的item的背景图片
@property (nonatomic,strong) UIImage *itemBackgroundImageMiddle;

//底部移动的view颜色
@property (nonatomic,strong) UIColor *moveViewColor;

//分隔线的颜色
@property (nonatomic,strong) UIColor *dividingLineColor;

//选中的字体颜色
@property (nonatomic,strong) UIColor *selectedColor;

@property (nonatomic,strong) UIColor *normalColor;
//选中的背景图片
@property (nonatomic,strong) UIImage *selectedBackgroundImage;

@property (nonatomic,strong) UIImage *unselectBackgroundImage;

@property (nonatomic,weak) id delegate;

//使用这个初始化，配置统一的UI
- (id)initWithFrame:(CGRect)frame withDataSource:(id<HsUISegmentControlDataSource>)mDataSource;

//获取item
- (HsUISegmentItem*)itemForIndex:(NSInteger)index;

//重新载入控件数据
- (void)reloadData;
//选择某个item
- (void)selectItemForIndex:(NSInteger)index;
@end
