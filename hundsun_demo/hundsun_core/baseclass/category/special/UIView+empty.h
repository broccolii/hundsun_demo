//
//  UIView+emptyInfo.h
//  hundsun_zjfae
//
//  Created by 王金东 on 14-7-30.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM (NSInteger,EmptyViewType){
    NoDataView,//没有数据
    NetWorkFailView,//网络失败
    NetWorkLoading,//正在加载
    OtherType,//其他自定义
};

typedef void(^EmptyViewClickBlock)(void);

@interface UIView (empty)

//显示活动指示器
- (void)showActivityIndicator;
//显示活动指示器
- (void)showActivityIndicator:(CGRect)rect;
//隐藏活动指示器
- (void)hideActivityIndicator;

//显示加载中
- (void)showLoading;
//隐藏加载中
- (void)hideLoading;

//显示空视图
- (void)showEmptyView;
//显示空视图 带单击事件
- (void)showEmptyViewWithClickBlock:(EmptyViewClickBlock)clickBlock;

//显示空视图
- (void)showEmptyView:(EmptyViewType) type;

//显示空视图
- (void)showEmptyView:(EmptyViewType) type clickBlock:(EmptyViewClickBlock)clickBlock;

//显示空内容
- (void)showEmptyTitle:(NSString *) title;
- (void)showEmptyTitle:(NSString *) title clickBlock:(EmptyViewClickBlock)clickBlock;

//隐藏空视图
- (void)hideEmptyView;



//给view增加标识图片

- (void)addImageNameMark:(NSString *)markImageName;

- (void)addImageNameMark:(NSString *)markImageName inRect:(CGRect)rect;

- (void)addImageMark:(UIImage *)markImage;

- (void)addImageMark:(UIImage *)markImage inRect:(CGRect)rect;

- (void)addImageMark:(UIImage *)markImage inRect:(CGRect)rect autoResize:(UIViewAutoresizing)autoresizeing;

//移除标识图片
- (void)removeMakrImage;


@end
