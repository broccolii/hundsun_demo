//
//  GridView.h
//  GTT_IOS
//
//  Created by allen.huang on 13-8-19.
//  Copyright (c) 2013年 allen.huang. All rights reserved.
//
/**
 **九宫格
 使用如下：
 HsUIGridView *girdView = [HsUIGridView alloc] initWithFrame:CGRectZero];
 gridView.dataSource = self;
 [self addSubView:gridView];
 实现委托方法
 和UiTableview的委托相似
 **/
#import <UIKit/UIKit.h>
#import "HsUIGridViewCell.h"

@protocol HsUIGridViewDelegate;

#pragma mark 会滚动的GridView

//是否能滚动
/**
 ** self.scrollEnabled = NO：frame=conteSize
 ** self.scrollEnabled = YES：frame 不要
 ** 默认self.scrollEnabled = NO;
 **/

@interface HsUIGridView : UIScrollView

@property (nonatomic,assign) id<HsUIGridViewDelegate> dataSource;
@property (nonatomic,assign) NSInteger columns;//列数
@property (nonatomic,assign) CGFloat itempadding;//每列间隔 也可以是分隔线的宽度
@property (nonatomic) UITableViewCellSeparatorStyle separatorStyle;
@property (nonatomic,retain) UIColor               *separatorColor;
@property (nonatomic,assign) UIEdgeInsets gridViewInset;
//头视图
@property (nonatomic,strong) UIView *gridViewHeadView;
//脚视图
@property (nonatomic,strong) UIView *gridViewFootView;

- (void)reloadAllData;

@end


@protocol HsUIGridViewDelegate <NSObject>

- (NSInteger)numberOfRowsInGridView:(HsUIGridView *)gridview;//return number of section in gridview

- (HsUIGridViewCell*)gridView:(HsUIGridView*)gridview cellAtInSection:(NSIndexPath*)indepath;// retrun cell of row
//NSIndexPath 中section代表行数  row代表格子的位置
@optional

- (CGFloat)gridview:(HsUIGridView *)gridview heightInSection:(NSInteger)section;// return cell height


- (void)gridview:(HsUIGridView *)gridview didSelectRowAtIndexPath:(NSIndexPath *)indexPath;//

- (void)gridviewDidFinishedLayout:(HsUIGridView *)gridview;

- (NSArray *)widthsOfSectionInGridview:(HsUIGridView *)gridview;


@end

