//
//  HsUISegmentContent.h
//  SegmentTest
//
//  Created by wjd on 13-11-4.
//  Copyright (c) 2013年 wjd. All rights reserved.
//
/**
 使用如下
 //上部导航
 HsUISegmentControl *topSegment = [[HsUISegmentControl alloc]initWithFrame:CGRectMake(0,0,320, 45) withDataSource:self];
 topSegment.backgroundColor = [UIColor whiteColor];
 topSegment.titleFont = [UIFont systemFontOfSize:16.0f];
 topSegment.selectedColor = [UIColor blackColor];
 [self.view addSubview:topSegment];
 //下不内容视图
 HsUISegmentContent *contentView = [[HsUISegmentContent alloc] initWithFrame:CGRectMake(0, 45, 320, self.view.frame.size.height-45-NAV_HEIGHT)];
 contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
 contentView.backgroundColor = [UIColor whiteColor];
 contentView.dataSource = self;
 [self.view addSubview:contentView];
 topSegment.delegate = contentView;
 contentView.delegate = topSegment;
 **/

#import <UIKit/UIKit.h>

@class HsUISegmentContent;

//内容视图数据源
@protocol HsUISegmentContentDataSource <NSObject>
//里面有多少项
- (NSInteger)numberOfItemsInSegmentContent:(HsUISegmentContent*)sgmContent;

//对应索引项得视图是什么
- (UIView*)segmentContent:(HsUISegmentContent*)sgmContent viewForItemAtIndex:(NSInteger)index;

@optional

//当将要滑动的时候，将开始滚动得子视图
- (void)segmentContent:(HsUISegmentContent*)sgmContent willScrollView:(UIView*)subview;

//不论通过什么方式选中的子view
- (void)selectedView:(UIView*)subview didSelectedAtIndex:(NSInteger)index;

//当滑动的时候，已经结束的view
- (void)segmentContent:(HsUISegmentContent*)sgmContent didFinishView:(UIView*)subview;

//当滑动的时候，菜单选中了哪一项
- (void)segmentContent:(HsUISegmentContent*)sgmContent didSelectAtIndex:(NSInteger)index;

@end

@interface HsUISegmentContent : UIView<UIScrollViewDelegate>{
    UIScrollView *contentScrollView;
    NSInteger itemCount ;
}
@property (nonatomic,strong) UIView *currentSubView;//当前子视图
@property (nonatomic,assign) id<HsUISegmentContentDataSource> dataSource;

@property (nonatomic,weak) id delegate;

- (void)addTarget:(id)delegate didStopScrollAction:(SEL)action;//当滚到边 将事件交给其他人

- (void)reloadData;
- (void)selectItemForIndex:(NSInteger)index;
@end

