//
//  HsBaseTableView.h
//  v1.0
//  Created by 王金东 on 14-7-28.
//  Copyright (c) 2014年 wjd. All rights reserved.
//
// 1)、数据源使用
// 1、先给self.itemsArray赋值 （如果你不想定制cell，想用系统的cell，那么不用再看2、3、4步骤）
// 2、设置tableViewCellClass，设置cell类
// 3、建立cell类，需要继承HsBaseTableViewCell
// 4、重写HsBaseTableViewCell的dataInfo的set方法 ，传递过去的数据源可以用于渲染视图
// 5、也可自己实现其他delegate事件，比如点击行

// 以上是基本使用步骤

// 设置多种cell步骤
// 1、先给self.itemsArray赋值
// 2、建立cell类，需要继承HsBaseTableViewCell
// 3、设置self.tableViewCellArray 数组可以是Class 也可以是UInib类
// 4、重写 - (NSInteger)baseTableView:(HsBaseTableView *)tableView typeForRowAtIndexPath:(NSIndexPath *)indexPath; 返回值是self.tableViewCellArray的索引
//

// 通过设置self.sectionIndexTitles 可定制右侧索引
//
// 如果你想自定义行 完全可以按照系统默认的写法 ，注意使用self.itemsArray当做数据源即可
// 具体的一些设置参数可以查看下面的头文件中变量的定义

// 如果你是二维数组 则开启sectionable=YES即可
// 其他步骤于上面一样
// 注意如果是数组里面不是NSArray类（比如是NSDictionary ，则我们将NSDictionary中的items字段取出来作为第二级数据）这个key也可以自定义 参看keyOfItemArray的注释

//2)、 下拉刷新\上拉加载
// 开启下拉刷新 参照<HsBaseTableViewRefreshDelegate> 协议
// self.refreshHeaderable = YES; 实现headerRereshing即可
// 开启上拉加载
// self.refreshFooterable = YES; 实现footerRereshing即可
// 刷新完调用  [super didLoaded:HsBaseRefreshTableViewHeader];
//

// 3)、查询功能
// self.searchable = YES;即可开启查询
// 可通过设置searchTableViewCellClass来定制查询界面的cell 步奏同 1）
// 不设置则默认和tableViewCellClass一样
//
// 4)、编辑删除功能
// 多行编辑 self.multiLineDeleteAction = ^(NSArray *indexPaths){}
// 单行编辑 self.singleLineDeleteAction = ^(NSIndexPath *indexPath){}:

#import <UIKit/UIKit.h>
#import "HsBaseTableViewDataSource.h"
#import "HsBaseTableViewDelegate.h"

extern NSString *const HsBaseTableViewKeyTypeForRow;

@interface HsBaseTableView : UITableView<UITableViewDelegate,UITableViewDataSource>
/**
 * 取消系统默认的delegate和datasource 用下面的来实现自定义
 **/
@property (nonatomic,weak) id<HsBaseTableViewDelegate> baseDelegate;
@property (nonatomic,weak) id<HsBaseTableViewDataSource> baseDataSource;


/**
 * cel的类名
 **/
@property (nonatomic,assign) id tableViewCellClass;

/**
 * cel的类名或xib'名称组成的数组
 **/
@property (nonatomic,strong) NSArray  *tableViewCellArray;

/**
 * 数据源
 */
@property (nonatomic, strong) NSMutableArray *itemsArray;


/**
 * 是否分块
 **/
@property (nonatomic, assign) BOOL sectionable;

/**
 * 如果itemsArray里面是NSDictionary 则第二级的数组按照keyOfItemArray来取
 * 默认是items
 **/

@property (nonatomic, strong) NSString *keyOfItemArray;


/**
 * 用取head'title得key
 **/

@property (nonatomic, strong) NSString *keyOfHeadTitle;

/**
 ** 设置默认三个控件取值的key
 ** 设置imageView 取值的key
 **/
@property (nonatomic,strong) NSString *keyForImageView;

/**
 ** 设置textLabel 取值的key
 **/
@property (nonatomic,strong) NSString *keyForTitleView;

/**
 ** 设置detailLabel 取值的key
 **/
@property (nonatomic,strong) NSString *keyForDetailView;




/**
 ** 延迟一会取消选中状态
 **/
@property(nonatomic) BOOL clearsSelectionDelay;


/**
 **  TableView右边的IndexTitles数据源
 **/
@property (nonatomic, strong) NSArray *sectionIndexTitles;

/**
 ** 设置第一个section的的head高度
 **/
@property (nonatomic,assign) float firstSectionHeaderHeight;

/**
 ** 不传cell类型时，可通过设置cell的style来初始化cell
 **/
@property (nonatomic,assign) UITableViewCellStyle tableViewCellStyle;

/**
 ** controler
 **/
@property (nonatomic,weak) HsBaseViewController *baseViewController;

@end


#pragma mark 刷新协议
@protocol HsBaseTableViewRefreshDelegate <NSObject>

/**
 **开始刷新数据
 **/
- (void)headerRereshing;

/**
 **开始加载数据
 **/
- (void)footerRereshing;

@end


typedef NS_ENUM(NSInteger, HsBaseRefreshTableViewType) {
    HsBaseRefreshTableViewHeader,//head类型
    HsBaseRefreshTableViewFooter,
};


/**
 **下拉刷新委托
 **/
@protocol HsBaseTableViewRefreshDelegate;

/**
 ** 是否开启刷新功能 默认开启
 **/

@interface HsBaseTableView (refreshable)<HsBaseTableViewRefreshDelegate>

@property (nonatomic,assign) BOOL refreshHeaderable;
@property (nonatomic,assign) BOOL refreshFooterable;

@property (nonatomic,weak) id<HsBaseTableViewRefreshDelegate> refreshDelegate;

/**
 **加载完毕后调用该方法结束加载状态
 **/
- (void)didLoaded:(HsBaseRefreshTableViewType)type;

@end



typedef void(^SingleLineDeleteAction) (NSIndexPath *indexPath);
typedef void(^MultiLineDeleteAction) (NSArray *indexPaths);

@interface HsBaseTableView (editable)

@property(nonatomic,assign,readonly) BOOL editable;

/**
 ** 开启多行删除block
 **/
@property(nonatomic,assign) MultiLineDeleteAction multiLineDeleteAction;

/**
 **设置删除的block后就可以开启编辑部模式
 **/
@property(nonatomic,assign) SingleLineDeleteAction singleLineDeleteAction;

@end

