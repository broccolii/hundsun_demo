//
//  HsRefreshFooterView.m
//  HsRefresh
//
//  Created by Hs on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  上拉加载更多

#import "HsRefreshFooterView.h"
#import "HsRefreshConst.h"
#import "UIScrollView+Extension.h"

@interface HsRefreshFooterView()
@property (assign, nonatomic) int lastRefreshCount;
@end

@implementation HsRefreshFooterView

+ (instancetype)footer
{
    return [[HsRefreshFooterView alloc] init];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.statusLabel.frame = self.bounds;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 旧的父控件
    [self.superview removeObserver:self forKeyPath:HsRefreshContentSize context:nil];
    
    if (newSuperview) { // 新的父控件
        // 监听
        [newSuperview addObserver:self forKeyPath:HsRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
        
        // 重新调整frame
        [self adjustFrameWithContentSize];
    }
}

#pragma mark 重写调整frame
- (void)adjustFrameWithContentSize
{
    // 内容的高度
    CGFloat contentHeight = self.scrollView.contentSizeHeight;
    // 表格的高度
    CGFloat scrollHeight = self.scrollView.frameHeight - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom;
    // 设置位置和尺寸
    self.frameY = MAX(contentHeight, scrollHeight);
}

#pragma mark 监听UIScrollView的属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 不能跟用户交互，直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    
    if ([HsRefreshContentSize isEqualToString:keyPath]) {
        // 调整frame
        [self adjustFrameWithContentSize];
    } else if ([HsRefreshContentOffset isEqualToString:keyPath]) {
#warning 这个返回一定要放这个位置
        // 如果正在刷新，直接返回
        if (self.state == HsRefreshStateRefreshing) return;
        
        // 调整状态
        [self adjustStateWithContentOffset];
    }
}

/**
 *  调整状态
 */
- (void)adjustStateWithContentOffset
{
    // 当前的contentOffset
    CGFloat currentOffsetY = self.scrollView.contentOffsetY;
    // 尾部控件刚好出现的offsetY
    CGFloat happenOffsetY = [self happenOffsetY];
    
    // 如果是向下滚动到看不见尾部控件，直接返回
    if (currentOffsetY <= happenOffsetY) return;
    
    if (self.scrollView.isDragging) {
        // 普通 和 即将刷新 的临界点
        CGFloat normal2pullingOffsetY = happenOffsetY + self.frameHeight;
        
        if (self.state == HsRefreshStateNormal && currentOffsetY > normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = HsRefreshStatePulling;
        } else if (self.state == HsRefreshStatePulling && currentOffsetY <= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = HsRefreshStateNormal;
        }
    } else if (self.state == HsRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        self.state = HsRefreshStateRefreshing;
    }
}

#pragma mark - 状态相关
#pragma mark 设置状态
- (void)setState:(HsRefreshState)state
{
    // 1.一样的就直接返回
    if (self.state == state) return;
    
    // 2.保存旧状态
    HsRefreshState oldState = self.state;
    
    // 3.调用父类方法
    [super setState:state];
    
    // 4.根据状态来设置属性
	switch (state)
    {
		case HsRefreshStateNormal:
        {
            // 设置文字
            self.statusLabel.text = HsRefreshFooterPullToRefresh;
            
            // 刷新完毕
            if (HsRefreshStateRefreshing == oldState) {
                self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                [UIView animateWithDuration:HsRefreshSlowAnimationDuration animations:^{
                    self.scrollView.contentInsetBottom = self.scrollViewOriginalInset.bottom;
                }];
            } else {
                // 执行动画
                [UIView animateWithDuration:HsRefreshFastAnimationDuration animations:^{
                    self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                }];
            }
            
            CGFloat deltaH = [self heightForContentBreakView];
            int currentCount = [self totalDataCountInScrollView];
            // 刚刷新完毕
            if (HsRefreshStateRefreshing == oldState && deltaH > 0 && currentCount != self.lastRefreshCount) {
                self.scrollView.contentOffsetY = self.scrollView.contentOffsetY;
            }
			break;
        }
            
		case HsRefreshStatePulling:
        {
            // 设置文字
            self.statusLabel.text = HsRefreshFooterReleaseToRefresh;
            
            [UIView animateWithDuration:HsRefreshFastAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformIdentity;
            }];
			break;
        }
            
        case HsRefreshStateRefreshing:
        {
            // 设置文字
            self.statusLabel.text = HsRefreshFooterRefreshing;
            
            // 记录刷新前的数量
            self.lastRefreshCount = [self totalDataCountInScrollView];
            
            [UIView animateWithDuration:HsRefreshFastAnimationDuration animations:^{
                CGFloat bottom = self.frameHeight + self.scrollViewOriginalInset.bottom;
                CGFloat deltaH = [self heightForContentBreakView];
                if (deltaH < 0) { // 如果内容高度小于view的高度
                    bottom -= deltaH;
                }
                self.scrollView.contentInsetBottom = bottom;
            }];
			break;
        }
            
        default:
            break;
	}
}

- (int)totalDataCountInScrollView
{
    int totalCount = 0;
    if ([self.scrollView isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.scrollView;
        
        for (int section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self.scrollView isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self.scrollView;
        
        for (int section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

#pragma mark 获得scrollView的内容 超出 view 的高度
- (CGFloat)heightForContentBreakView
{
    CGFloat h = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
    return self.scrollView.contentSize.height - h;
}

#pragma mark - 在父类中用得上
/**
 *  刚好看到上拉刷新控件时的contentOffset.y
 */
- (CGFloat)happenOffsetY
{
    CGFloat deltaH = [self heightForContentBreakView];
    if (deltaH > 0) {
        return deltaH - self.scrollViewOriginalInset.top;
    } else {
        return - self.scrollViewOriginalInset.top;
    }
}
@end