//
//  HsUISegment.m
//  hospitalcloud_sdzy
//
//  Created by 123 on 14-6-18.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "HsUISegment.h"


@implementation HsUISegment{
    HsUISegmentControl *topSegment;
    HsUISegmentContent *contentView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //上部导航
        topSegment = [[HsUISegmentControl alloc]initWithFrame:CGRectMake(0,0,320, 45) withDataSource:self];
        topSegment.backgroundColor = [UIColor whiteColor];
        topSegment.titleFont = [UIFont systemFontOfSize:16.0f];
        topSegment.selectedColor = [UIColor blackColor];
        [self addSubview:topSegment];
        //下不内容视图
        contentView = [[HsUISegmentContent alloc] initWithFrame:CGRectMake(0, 45, 320, self.frame.size.height-45)];
        contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.dataSource = self;
        [self addSubview:contentView];
        topSegment.delegate = contentView;
        contentView.delegate = topSegment;
    }
    return self;
}

- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    topSegment.selectedColor = selectedColor;
}

- (void)setNormalColor:(UIColor *)normalColor{
    _normalColor = normalColor;
    topSegment.normalColor = normalColor;
}

- (void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage{
    _selectedBackgroundImage = selectedBackgroundImage;
    topSegment.selectedBackgroundImage = selectedBackgroundImage;
}

- (void)setUnselectBackgroundImage:(UIImage *)unselectBackgroundImage{
    _unselectBackgroundImage = unselectBackgroundImage;
    topSegment.unselectBackgroundImage = unselectBackgroundImage;
}

- (void)setMoveViewColor:(UIColor *)moveViewColor{
    _moveViewColor = moveViewColor;
    topSegment.moveViewColor = moveViewColor;
}

- (void)setDividingLineColor:(UIColor *)dividingLineColor{
    _dividingLineColor = dividingLineColor;
    topSegment.dividingLineColor = dividingLineColor;
}

#pragma mark -----菜单delegate
- (NSInteger)numberOfItemsInSegmentControl:(HsUISegmentControl *)sgmCtrl
{
    return [self.dataSource numberOfItemsInSegment:self];
}
- (CGFloat)widthForEachItemInsegmentControl:(HsUISegmentControl*)sgmCtrl index:(NSInteger)index
{
    return [self.dataSource widthForEachItemInsegmentControl:self index:index];
}
- (NSString*)segmentControl:(HsUISegmentControl *)sgmCtrl titleForItemAtIndex:(NSInteger)index
{
    return  [self.dataSource segmentControl:self titleForItemAtIndex:index];
}

//菜单选中了哪一项
- (void)segmentControl:(HsUISegmentControl*)sgmCtrl didSelectAtIndex:(NSInteger)index{
    if(self.delegate && [self.delegate respondsToSelector:@selector(segmentControl:didSelectSegmentAtIndex:)]){
        [self.delegate segmentControl:sgmCtrl didSelectSegmentAtIndex:index];
    }
}

#pragma mark 内容视图delegate
//里面有多少项
- (NSInteger)numberOfItemsInSegmentContent:(HsUISegmentContent*)sgmContent{
    return [self.dataSource numberOfItemsInSegment:self];
}

//对应索引项得视图是什么
- (UIView*)segmentContent:(HsUISegmentContent*)sgmContent viewForItemAtIndex:(NSInteger)index{
    return [self.dataSource segmentContent:self viewForItemAtIndex:index];
}

//当滑动的时候，菜单选中了哪一项
- (void)segmentContent:(HsUISegmentContent*)sgmContent didSelectAtIndex:(NSInteger)index{
    if(self.delegate && [self.delegate respondsToSelector:@selector(segmentContent:didSelectSegmentAtIndex:)]){
        [self.delegate segmentContent:sgmContent didSelectSegmentAtIndex:index];
    }
}

@end
