//
//  HsUISegmentControl.m
//  HsUICustomSegmenControl
//
//  Created by wjd on 12-2-19.
//  Copyright (c) 2012年 wjd. All rights reserved.


#import "HsUISegmentControl.h"
#import <QuartzCore/QuartzCore.h>

#define EACH_ITEM_WIDTH 60

@interface HsUISegmentControl ()

- (void)setLeftTagViewHidden:(BOOL)state;
- (void)setRightTagViewHidden:(BOOL)state;

@end

@implementation HsUISegmentControl

- (id)initWithFrame:(CGRect)frame
{
    return [[HsUISegmentControl alloc] initWithFrame:frame withDataSource:nil];
}
- (void)dealloc
{
    self.titleFont = nil;
    self.moveImgView = nil;
    self.itemBackgroundImageLeft = nil;
    self.itemBackgroundImageRight = nil;
    self.itemBackgroundImageMiddle = nil;
    self.selectedColor = nil;
    self.normalColor = nil;;
}
- (id)initWithFrame:(CGRect)frame withDataSource:(id<HsUISegmentControlDataSource>)mDataSource
{
    if (self = [super initWithFrame:frame]) {
        self.itemBackgroundImageLeft = [UIImage createImageWithColor:[UIColor whiteColor]];
        self.itemBackgroundImageMiddle = [UIImage createImageWithColor:[UIColor whiteColor]];
        self.itemBackgroundImageRight = [UIImage createImageWithColor:[UIColor whiteColor]];
        
        self.dataSource = mDataSource;
        //set back scrollView
        backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
        backScrollView.showsHorizontalScrollIndicator = NO;
        backScrollView.delegate = self;
        [self addSubview:backScrollView];
        //设置默认的分割线颜色
        self.dividingLineColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
        bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
        bottomView.backgroundColor = self.dividingLineColor;
        bottomView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:bottomView];
    }
    return self;
}

- (void)setDividingLineColor:(UIColor *)dividingLineColor{
    if(_dividingLineColor != dividingLineColor){
        _dividingLineColor = dividingLineColor;
        bottomView.backgroundColor = self.dividingLineColor;
        [self setNeedsLayout];
    }
}

#pragma mark - reload data
- (void) reloadData
{
    //clear subviews
    for (UIView *subView in backScrollView.subviews) {
        if (subView == self.moveImgView) {
            continue;
        }
        [subView removeFromSuperview];
    }
    backScrollView.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
    [self setNeedsLayout];
}

#pragma mark - HsUISegmentItemDelegate 点击item时处理事件
- (void)didTapOnItem:(HsUISegmentItem *)item
{    
    if (_selectedIndex == item.index) {
        return;
    }
    //change grip
    lastSelectedIndex = _selectedIndex;
    
    [self selectItemForIndex:item.index];
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(segmentControl:didSelectAtIndex:)]) {
        [self.dataSource segmentControl:self didSelectAtIndex:item.index];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(selectItemForIndex:)]){
        [self.delegate selectItemForIndex:item.index];
    }
    _selectedIndex = item.index;
    
}

#pragma mark - selectedImgView move action 移动图片结束移动后
- (void)hiddenGripAfterAnimation
{
    //动画结束后将当前选中的item切换到选中状态
    HsUISegmentItem *selectItem = [self itemForIndex:_selectedIndex];
    [selectItem switchToSelected];
}

#pragma mark 选择某个item 底部图片也跟着移动
- (void)selectItemForIndex:(NSInteger)index{
    if(index != _selectedIndex){
        if(index < allItemsCount){
            //CGRect visibleBounds = backScrollView.bounds;
            //NSLog(@"%@",NSStringFromCGRect(visibleBounds));
            //设置选中区域
            UIView *subView = backScrollView.subviews[index];
            [backScrollView scrollRectToVisible:subView.frame animated:YES];
            if(_selectedIndex > index){
                if(index > 0){
                    UIView *subViewPre = backScrollView.subviews[index-1];
                    [backScrollView scrollRectToVisible:subViewPre.frame animated:YES];
                }
            }else{
                if(index < allItemsCount - 1){
                    UIView *subViewNext = backScrollView.subviews[index+1];
                    [backScrollView scrollRectToVisible:subViewNext.frame animated:YES];
                }
            }
            //开启移动图片的动画
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationRepeatAutoreverses:NO];
            [UIView setAnimationDidStopSelector:@selector(hiddenGripAfterAnimation)];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationDelegate:self];
           //设置下面图片偏移量
            _moveImgView.frame = CGRectMake(subView.frame.origin.x,_moveImgView.frame.origin.y,subView.frame.size.width,_moveImgView.frame.size.height);
            [UIView commitAnimations];
            //更新上一次选中位置变量
            lastSelectedIndex = _selectedIndex;
            _selectedIndex = index;
            if(lastSelectedIndex != _selectedIndex){
                //如果上一次和这个不是同一位置 则把上次位置切换到正常状态
                HsUISegmentItem *item = [self itemForIndex:lastSelectedIndex];
                [item switchToNormal];
            }
        }
    }
}

#pragma mark scrollview滚动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    
    if (offset.x == 0 && offset.x <= scrollView.frame.size.width+0.5 && scrollView.contentSize.width > scrollView.frame.size.width+0.5) {
        [self setLeftTagViewHidden:YES];
        [self setRightTagViewHidden:NO];
    }else if((scrollView.contentSize.width-offset.x) <= scrollView.frame.size.width+0.5){
        [self setRightTagViewHidden:YES];
        [self setLeftTagViewHidden:NO];
    }else if(scrollView.contentSize.width < scrollView.frame.size.width+0.5){
        [self setRightTagViewHidden:YES];
        [self setLeftTagViewHidden:YES];
    }else {
        [self setLeftTagViewHidden:NO];
        [self setRightTagViewHidden:NO];
    }
}
- (void)setLeftTagViewHidden:(BOOL)state{
    
}
- (void)setRightTagViewHidden:(BOOL)state{
    
}

#pragma mark 获取到某一位置的item
- (HsUISegmentItem*)itemForIndex:(NSInteger)index
{
    for (UIView *view in backScrollView.subviews) {
        if ([view isKindOfClass:[HsUISegmentItem class]]) {
            HsUISegmentItem *item = (HsUISegmentItem *)view;
            if(index == item.index)
                return item;
        }
    }
    return nil;
}



#pragma mark 布局
- (void)layoutSubviews{
    [super layoutSubviews];
    [self initSubViews];
}

- (void)initSubViews
{
    
    if (self.dataSource == nil) {
        NSAssert(self.dataSource=nil,@"dataSource can't be nil");
    }
    
    allItemsCount = 0;
    
    //begin init subview
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsInSegmentControl:)]) {
        
        allItemsCount = [self.dataSource numberOfItemsInSegmentControl:self];
        
    }else {
        NSAssert([self.dataSource respondsToSelector:@selector(numberOfItemsInSegmentControl:)] == NO,@"segment must can response datasource method ");
    }
    
    
    //set items
    CGFloat scrollTotalWidth = 0;
    for (int i = 0; i < allItemsCount; i++) {
        //item width
        CGFloat itemWidth = 0;
        //取得每个item的宽
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(widthForEachItemInsegmentControl:index:)]) {
            itemWidth = [self.dataSource widthForEachItemInsegmentControl:self index:i];
        }else {
            itemWidth = EACH_ITEM_WIDTH;
        }
        
        CGRect itemFrame = CGRectMake(scrollTotalWidth,0,itemWidth,backScrollView.frame.size.height);
        
        scrollTotalWidth = scrollTotalWidth + itemWidth;
        
        NSString *title = nil;
        //取得每个item的title
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(segmentControl:titleForItemAtIndex:)]) {
            title = [self.dataSource segmentControl:self titleForItemAtIndex:i];
        }else {
            title = @"";
        }
        
        HsUISegmentItem *item = nil;
        if (i!=allItemsCount-1 && i!=0) {
            item = [[HsUISegmentItem alloc]initWithFrame:itemFrame  withTitle:title isLastRightItem:NO withBackgroundImage:self.itemBackgroundImageMiddle];
        }else if(i==0){
            item = [[HsUISegmentItem alloc]initWithFrame:itemFrame  withTitle:title isLastRightItem:YES withBackgroundImage:self.itemBackgroundImageLeft];
            
        }else if(i==allItemsCount-1){
            item = [[HsUISegmentItem alloc]initWithFrame:itemFrame  withTitle:title isLastRightItem:YES withBackgroundImage:self.itemBackgroundImageRight];
            
        }
        item.index = i;
        item.selectedBackgroundImage = self.selectedBackgroundImage;
        item.unselectBackgroundImage = self.unselectBackgroundImage;
        item.delegate = self;
        item.titleFont = self.titleFont;
        item.normalColor = self.normalColor;
        item.selectedColor = self.selectedColor;
        item.backgroundColor = self.dividingLineColor;
        [backScrollView addSubview:item];
        //default selected 0
        if (i==0) {
            [item switchToSelected];
        }
    }
    
    //set backScroll content
    backScrollView.contentSize = CGSizeMake(scrollTotalWidth,self.frame.size.height);
    
    //    //set selectImageView default on the first
    if (self.moveImgView == nil) {
        UIView *firstView = nil;
        if(backScrollView.subviews.count > 0){
            firstView = backScrollView.subviews[0];
        }
        _moveImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,self.frame.size.height-2,firstView.frame.size.width,2)];
        
        if(_moveViewColor == nil){
            self.moveViewColor = [UIColor colorWithRed:123.0/255 green:123.0/255 blue:123.0/255 alpha:0.5];
        }
        _moveImgView.backgroundColor = self.moveViewColor;
        //above the backscrollview
        [backScrollView addSubview:_moveImgView];
    }else {
        [backScrollView scrollRectToVisible:backScrollView.frame animated:NO];
        [backScrollView bringSubviewToFront:_moveImgView];
        [self selectItemForIndex:0];
    }
    
    //set default right tag
    if (backScrollView.contentSize.width > backScrollView.frame.size.width) {
        [self setRightTagViewHidden:NO];
    }
    
}


@end
