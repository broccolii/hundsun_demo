//
//  HsUISegmentContent.m
//  SegmentTest
//
//  Created by wjd on 13-11-4.
//  Copyright (c) 2013年 wjd. All rights reserved.
//

#import "HsUISegmentContent.h"


@interface HsUISegmentContent ()

@property (nonatomic,assign) id scrolldelegate;

@property (nonatomic,assign) SEL scrollAction;

@end

@implementation HsUISegmentContent

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        contentScrollView.pagingEnabled = YES;
        contentScrollView.delegate = self;
        contentScrollView.bounces = NO;
        contentScrollView.showsHorizontalScrollIndicator = NO;
        [contentScrollView.panGestureRecognizer addTarget:self action:@selector(pan:)];
        contentScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        contentScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:contentScrollView];
    }
    return self;
}

//scrollview 滚动时会执行手势。
- (void)pan:(UIGestureRecognizer*)gesture{
    if(contentScrollView.contentOffset.x == 0 || contentScrollView.contentOffset.x == (contentScrollView.contentSize.width - contentScrollView.frame.size.width) ){
        if(self.scrolldelegate && [self.scrolldelegate respondsToSelector:_scrollAction]){
            [self.scrolldelegate performSelector:self.scrollAction withObject:gesture];
        }
    }
}

- (void)showMenu{
    contentScrollView.userInteractionEnabled = NO;
}

- (void)showCenter{
    contentScrollView.userInteractionEnabled = YES;
}

- (void)addTarget:(id)delegate didStopScrollAction:(SEL)action{
    self.scrolldelegate = delegate;
    self.scrollAction = action;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self reloadData];
}

- (void)reloadData{
    //获取子视图个数
    itemCount = 0;
    if([self.dataSource respondsToSelector:@selector(numberOfItemsInSegmentContent:)]){
        itemCount = [self.dataSource numberOfItemsInSegmentContent:self];
    }
    //清空子视图
    for (UIView *subview in contentScrollView.subviews) {
        [subview removeFromSuperview];
    }
    //加载子视图
    CGRect frame = contentScrollView.frame;
    if([self.dataSource respondsToSelector:@selector(segmentContent:viewForItemAtIndex:)]){
        for (NSInteger i =0 ; i < itemCount; i++) {
            UIView *subview = [self.dataSource segmentContent:self viewForItemAtIndex:i];
            frame.origin.x = frame.size.width * i;
            frame.origin.y = 0;
            subview.frame = frame;
            subview.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            [contentScrollView addSubview:subview];
        }
    }
    if(itemCount > 0){
        [self viewOfselected:0];
    }
    [contentScrollView setContentSize:CGSizeMake(frame.size.width * itemCount, frame.size.height)];
}
#pragma mark 选择某一个子视图
- (void)selectItemForIndex:(NSInteger)index{
    if(index < itemCount){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView setAnimationDidStopSelector:@selector(hiddenGripAfterAnimation)];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationDelegate:self];
        CGPoint pointoffset=CGPointMake(index*contentScrollView.frame.size.width, 0);
        contentScrollView.contentOffset=pointoffset;
        [UIView commitAnimations];
        [self viewOfselected:index];
    }
}
#pragma mark 选中index下的子视图
- (void)viewOfselected:(NSInteger)index{
    if(self.currentSubView != nil){
        if(self.dataSource && [self.dataSource respondsToSelector:@selector(segmentContent:didFinishView:)]){
            [self.dataSource segmentContent:self didFinishView:self.currentSubView];
        }
    }
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(selectedView:didSelectedAtIndex:)]){
        UIView *subview = [contentScrollView.subviews objectAtIndex:index];
        self.currentSubView = subview;
        [self.dataSource selectedView:subview didSelectedAtIndex:index];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(selectItemForIndex:)]){
        [self.delegate selectItemForIndex:index];
    }
}
#pragma mark 视图将要开始滑动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(segmentContent:willScrollView:)]){
        [self.dataSource performSelector:@selector(segmentContent:willScrollView:) withObject:self withObject:self.currentSubView];
    }
}
#pragma mark 选择某个子视图
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point= scrollView.contentOffset;
    NSInteger i=point.x/scrollView.frame.size.width;
    if([self.dataSource respondsToSelector:@selector(segmentContent:didSelectAtIndex:)]){
        [self.dataSource segmentContent:self didSelectAtIndex:i];
    }
    [self viewOfselected:i];
}

@end
