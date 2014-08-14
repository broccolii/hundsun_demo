//
//  UIScrollView+MJRefresh.m
//  MJRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIScrollView+HsRefresh.h"
#import "HsRefreshHeaderView.h"
#import "HsRefreshFooterView.h"
#import <objc/runtime.h>

#define showDefaultRefresh NO

 NSString *RefreshHeaderViewKey = @"HsRefreshHeaderViewKey";
 NSString *RefreshFooterViewKey = @"HsRefreshFooterViewKey";

@interface UIScrollView()
@property (weak, nonatomic) UIView *header;
@property (weak, nonatomic) HsRefreshFooterView *footer;
@end


@implementation UIScrollView (HsRefresh)

#pragma mark - 运行时相关
static char HsRefreshHeaderViewKey;
static char HsRefreshFooterViewKey;

- (void)setHeader:(HsRefreshHeaderView *)header {
    [self willChangeValueForKey:RefreshHeaderViewKey];
    objc_setAssociatedObject(self, &HsRefreshHeaderViewKey,
                             header,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:RefreshHeaderViewKey];
}

- (HsRefreshHeaderView *)header {
    return objc_getAssociatedObject(self, &HsRefreshHeaderViewKey);
}

- (void)setFooter:(HsRefreshFooterView *)footer {
    [self willChangeValueForKey:RefreshFooterViewKey];
    objc_setAssociatedObject(self, &HsRefreshFooterViewKey,
                             footer,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:RefreshFooterViewKey];
}

- (HsRefreshFooterView *)footer {
    return objc_getAssociatedObject(self, &HsRefreshFooterViewKey);
}

#pragma mark - 下拉刷新
/**
 *  添加一个下拉刷新头部控件
 * NS_AVAILABLE_IOS(5_0)
 *  @param callback 回调
 */
- (void)addHeaderWithCallback:(void (^)())callback
{
    if(!showDefaultRefresh){
        // 1.创建新的header
        if (!self.header) {
            HsRefreshHeaderView *header = [HsRefreshHeaderView header];
            [self addSubview:header];
            self.header = header;
        }
        // 2.设置block回调
        HsRefreshHeaderView *header = (HsRefreshHeaderView *)self.header;
        header.beginRefreshingCallback = callback;
    }else{//使用默认的下拉刷新 不能使用block
        @throw [NSException exceptionWithName:@"使用非法方法" reason:@"系统版本>6.0 不能使用该方法" userInfo:nil];
    }
}

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action
{
    // 1.创建新的header
    if (!self.header) {
        if(showDefaultRefresh){//使用默认的下拉刷新
            UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
            [self addSubview:refreshControl];
            self.header = refreshControl;
        }else{
            HsRefreshHeaderView *header = [HsRefreshHeaderView header];
            [self addSubview:header];
            self.header = header;
        }
    }
    if(showDefaultRefresh){//使用默认的下拉刷新事件
        UIRefreshControl *header = (UIRefreshControl *)self.header;
        [header addTarget:target
                           action:action
                 forControlEvents:UIControlEventValueChanged];
    }else{
        // 2.设置目标和回调方法
        HsRefreshHeaderView *header = (HsRefreshHeaderView *)self.header;
        header.beginRefreshingTaget = target;
        header.beginRefreshingAction = action;
    }
}

/**
 *  移除下拉刷新头部控件
 */
- (void)removeHeader
{
    [self.header removeFromSuperview];
    self.header = nil;
}

/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)headerBeginRefreshing
{
    if(showDefaultRefresh){//使用默认的下拉刷新 开始刷新
        UIRefreshControl *header = (UIRefreshControl *)self.header;
        [header beginRefreshing];
    }else{
        // 2.设置目标和回调方法
        HsRefreshHeaderView *header = (HsRefreshHeaderView *)self.header;
        [header beginRefreshing];
    }
}

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing
{
    if(showDefaultRefresh){//使用默认的下拉刷新 结束刷新
        UIRefreshControl *header = (UIRefreshControl *)self.header;
        [header endRefreshing];
    }else{
        // 2.设置目标和回调方法
        HsRefreshHeaderView *header = (HsRefreshHeaderView *)self.header;
        [header endRefreshing];
    }
}

/**
 *  下拉刷新头部控件的可见性
 */
- (void)setHeaderHidden:(BOOL)hidden
{
    self.header.hidden = hidden;
}

- (BOOL)isHeaderHidden
{
    return self.header.isHidden;
}

#pragma mark - 上拉刷新
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param callback 回调
 */
- (void)addFooterWithCallback:(void (^)())callback
{
    // 1.创建新的footer
    if (!self.footer) {
        HsRefreshFooterView *footer = [HsRefreshFooterView footer];
        [self addSubview:footer];
        self.footer = footer;
    }
    
    // 2.设置block回调
    self.footer.beginRefreshingCallback = callback;
}

/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action
{
    // 1.创建新的footer
    if (!self.footer) {
        HsRefreshFooterView *footer = [HsRefreshFooterView footer];
        [self addSubview:footer];
        self.footer = footer;
    }
    
    // 2.设置目标和回调方法
    self.footer.beginRefreshingTaget = target;
    self.footer.beginRefreshingAction = action;
}

/**
 *  移除上拉刷新尾部控件
 */
- (void)removeFooter
{
    [self.footer removeFromSuperview];
    self.footer = nil;
}

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing
{
    [self.footer beginRefreshing];
}

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing
{
    [self.footer endRefreshing];
}

/**
 *  下拉刷新头部控件的可见性
 */
- (void)setFooterHidden:(BOOL)hidden
{
    self.footer.hidden = hidden;
}

- (BOOL)isFooterHidden
{
    return self.footer.isHidden;
}
@end
