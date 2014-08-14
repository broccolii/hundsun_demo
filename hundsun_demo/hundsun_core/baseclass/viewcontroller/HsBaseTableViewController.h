//
//  HsBaseTableViewController.h
//  v1.0
//  Created by wjd on 14-7-27.
//  Copyright (c) 2014年 wjd. All rights reserved.
//
// 1)、数据源使用
// 1、先给self.itemsArray赋值（如果你不想定制cell，想用系统的cell，那么不用再看2、3、4步骤）
// 2、设置tableViewCellClass，设置cell类
// 3、建立cell类，需要继承HsBaseTableViewCell
// 4、重写HsBaseTableViewCell的dataInfo的set方法 ，传递过去的数据源可以用于渲染视图
// 5、也可自己实现其他delegate事件，比如点击行
// 以上是基本使用步骤
//
// 如果你想自定义行 完全可以按照系统默认的写法 ，注意使用self.itemsArray当做数据源即可
// 具体的一些设置参数可以查看下面的头文件中变量的定义
//
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
#import "HsBaseTableViewCell.h"
#import "HsBaseTableView.h"
#import "HsBaseViewController.h"

#pragma mark 处理数据源
@interface HsBaseTableViewController : HsBaseViewController<HsBaseTableViewDataSource, HsBaseTableViewDelegate>

- (id)initWithStyle:(UITableViewStyle)style;

/**
 **设置tablview的风格 如果style = UITableViewStyleGrouped 会默认开启sectionable
 **/
@property (nonatomic,assign) UITableViewStyle style;

/**
 ** 显示大量数据的控件
 **/
@property (nonatomic,strong) HsBaseTableView *tableView;

/**
 **cel的类名
 **/
@property (nonatomic,assign) id tableViewCellClass;


/**
 **cel的类名或xib'名称组成的数组
 **/
@property (nonatomic,strong) NSArray  *tableViewCellArray;

/**
 ** 不传cell类型时，可通过设置cell的style来初始化cell
 **/
@property (nonatomic,assign) UITableViewCellStyle tableViewCellStyle;




/**
 **NS_AVAILABLE_IOS(3_2);defaults to YES. If YES, any selection is cleared in viewWillAppear:
 **/
@property(nonatomic) BOOL clearsSelectionOnViewWillAppear;
/**
 ** 数据源
 */
@property (nonatomic, strong) NSMutableArray *itemsArray;


/**
 ** 是否分块
 **/
@property (nonatomic, assign) BOOL sectionable;

/**
 **如果itemsArray里面是NSDictionary 则第二级的数组按照keyOfItemArray来取
 **默认是items
 **/
@property (nonatomic, strong) NSString *keyOfItemArray;


/**
 **  TableView右边的IndexTitles数据源
 **/
@property (nonatomic, strong) NSArray *sectionIndexTitles;


@end


#pragma mark刷新功能
@interface HsBaseTableViewController (refreshable)<HsBaseTableViewRefreshDelegate>

@property (nonatomic,assign) BOOL refreshHeaderable;
@property (nonatomic,assign) BOOL refreshFooterable;

/**
 **加载完毕后调用该方法结束加载状态
 **/
- (void)didLoaded:(HsBaseRefreshTableViewType)type;
- (void)didLoaded;

@end


#pragma mark 搜索功能

@protocol HsBaseTableViewSearchDelegate <NSObject>

- (void)searchTableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HsBaseTableViewController (searchable)<UISearchBarDelegate,UISearchDisplayDelegate,HsBaseTableViewSearchDelegate>

/**
 ** v1.0 只支持cell是一种类型的查询
 ** 查询界面cel的类名
 **/
@property (nonatomic,assign) id  searchTableViewCellClass;


/**
 ** 搜索后的结果数据源
 **/
@property (nonatomic, strong,readonly) NSMutableArray *filteredDataSource;


/**
 **开启查询能力
 **/
@property (nonatomic,assign) BOOL searchable;

/**
 **搜索框
 **/
@property (nonatomic, strong,readonly) UISearchBar *aSearchBar;

/**
 **搜索框绑定的控制器
 **/
@property (nonatomic,strong,readonly) UISearchDisplayController *searchController;


/**
 **查询要比对的key
 **/
@property (nonatomic, strong) NSString *searchKey;

/**
 **判断当前的tableview是不是搜索中的tableview
 **/

- (BOOL)enableForSearchTableView:(UITableView *)tableView;

/**
 ** 查询委托事件
 **/
@property (nonatomic,assign) id<HsBaseTableViewSearchDelegate> searchDelegate;

/**
 **是否符合查询的条件 可重写该判断条件 默认itemInfo是字符串
 **/
- (BOOL)searchText:(NSString *)text itemInfo:(id)itemInfo;


@end

#pragma mark 编辑功能
@interface HsBaseTableViewController (editable)

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
