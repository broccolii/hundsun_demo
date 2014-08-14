//
//  HsUISegment.h
//  hospitalcloud_sdzy
//
//  Created by 123 on 14-6-18.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HsUISegmentContent.h"
#import "HsUISegmentControl.h"

@protocol HsUISegmentDataSource;
@protocol HsUISegmentDelegate;

@interface HsUISegment : UIView<HsUISegmentContentDataSource,HsUISegmentControlDataSource>

@property (weak,nonatomic) id<HsUISegmentDataSource> dataSource;

@property (weak,nonatomic) id<HsUISegmentDelegate> delegate;

//选中字体的颜色
@property (nonatomic,strong) UIColor *selectedColor;

@property (nonatomic,strong) UIColor *normalColor;

//选中状态的图片
@property (nonatomic,strong) UIImage *selectedBackgroundImage;

@property (nonatomic,strong) UIImage *unselectBackgroundImage;

//下面移动控件的颜色
@property (nonatomic,strong) UIColor *moveViewColor;

//分隔线的颜色
@property (nonatomic,strong) UIColor *dividingLineColor;


@end


@protocol HsUISegmentDataSource <NSObject>

@required

//有多少块
- (NSInteger)numberOfItemsInSegment:(HsUISegment *)sgm;

//导航的宽
- (CGFloat)widthForEachItemInsegmentControl:(HsUISegment*)sgmCtrl index:(NSInteger)index;

//导航的内容
- (NSString*)segmentControl:(HsUISegment *)sgmCtrl titleForItemAtIndex:(NSInteger)index;

//对应索引项得视图是什么
- (UIView*)segmentContent:(HsUISegment*)sgmContent viewForItemAtIndex:(NSInteger)index;


@end


@protocol HsUISegmentDelegate <NSObject>

//选择内容视图
- (void)segmentContent:(HsUISegmentContent *)segmContent didSelectSegmentAtIndex:(NSInteger)index;
//选中导航条
- (void)segmentControl:(HsUISegmentControl *)sgmCtrl didSelectSegmentAtIndex:(NSInteger)index;

@end