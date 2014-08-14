//
//  HsBaseTableViewController.m
//  hospitalcloud_sdzy
//
//  Created by 123 on 14-5-27.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "HsBaseTableViewController.h"
#import "HsBaseTableViewCell.h"

static NSString *const cellID = @"baseSerachCellID";

@interface HsBaseTableViewController (){
    BOOL _searchable;//开启搜索
    UISearchBar *_aSearchBar;//搜索框
    UISearchDisplayController *_searchController;
    __weak id<HsBaseTableViewSearchDelegate> _searchDelegate;
    //搜索的cell
    id  _searchTableViewCellClass;
    NSString *_searchKey;
    
    //结果数据源
    NSMutableArray *_filteredDataSource;
}

@end

@implementation HsBaseTableViewController

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super init];
    if(self){
        self.style = style;
    }
    return self;
}
- (void)dealloc {
    self.tableView = nil;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[HsBaseTableView alloc] initWithFrame:self.view.bounds style:self.style];
        //设置委托  不用baseDelegate的原因是该类用到查询功能实现了所有的TableViewDelegate的方法。
        //而该类对HsBaseTableView应该不做任何实现的，所以又丢给HsBaseTableView自己来实现。
        //如果改delegate 为baseDelegate，则是自己实现部分功能的，不能再丢给HsBaseTableView来实现，会造成循坏调用。
        _tableView.baseDelegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.baseDataSource = self;
        _tableView.refreshDelegate = self;
        _tableView.baseViewController = self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    }
    return _tableView;
}

- (void)setStyle:(UITableViewStyle)style{
    _style = style;
    if(style == UITableViewStyleGrouped){
        self.sectionable = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //添加表格控件
    [self.view addSubview:self.tableView];
    self.refreshHeaderable = NO;//默认是关闭刷新功能
    self.refreshFooterable = NO;
    self.clearsSelectionOnViewWillAppear = YES;
    //查询委托类
    self.searchDelegate = self;
    self.keyOfItemArray = @"items";
    //先做完自己的初始化  在考虑父类的
    //默认二级数组是Dictionary从items里面取
}

- (void)setSectionable:(BOOL)sectionable{
    self.tableView.sectionable = sectionable;
}
- (BOOL)sectionable{
    return self.tableView.sectionable;
}

- (void)setKeyOfItemArray:(NSString *)keyOfItemArray{
    self.tableView.keyOfItemArray = keyOfItemArray;
}

- (NSString *)keyOfItemArray{
    return self.tableView.keyOfItemArray;
}

- (void)setSectionIndexTitles:(NSArray *)sectionIndexTitles{
    self.tableView.sectionIndexTitles = sectionIndexTitles;
}
- (NSArray *)sectionIndexTitles{
    return self.tableView.sectionIndexTitles;
}

- (void)setTableViewCellStyle:(UITableViewCellStyle)tableViewCellStyle{
    self.tableView.tableViewCellStyle = tableViewCellStyle;
}

- (UITableViewCellStyle)tableViewCellStyle{
    return self.tableView.tableViewCellStyle;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(self.clearsSelectionOnViewWillAppear){
         [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    }
}

//注册个tableviewCell
- (void)setTableViewCellClass:(id)tableViewCellClass{
    //设置tableviewCell的时候并设置一个默认的查询cell
    if(self.searchable){
        self.searchTableViewCellClass = tableViewCellClass;
    }
    self.tableView.tableViewCellClass = tableViewCellClass;
}

- (id)tableViewCellClass{
    return self.tableView.tableViewCellClass;
}

//注册个tableviewCell
- (void)setTableViewCellArray:(NSArray *)tableViewCellArray{
    self.tableView.tableViewCellArray = tableViewCellArray;
}
- (NSArray *)tableViewCellArray{
    return self.tableView.tableViewCellArray;
}

//构造数据集合  数据源
- (void)setItemsArray:(NSMutableArray *)itemsArray{
    if(itemsArray != nil){
        NSMutableArray *array = nil;
        if([itemsArray isKindOfClass:[NSArray class]]){
            array = [itemsArray toMutableArray];
        }else{
            array = itemsArray;
        }
        self.tableView.itemsArray = array;
    }
}

- (NSMutableArray *)itemsArray{
    if(self.tableView.itemsArray == nil){
        self.tableView.itemsArray = [NSMutableArray array];
    }
    return self.tableView.itemsArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

#pragma mark 刷新功能
@implementation HsBaseTableViewController (refreshable)

//设置下拉刷新
- (void)setRefreshHeaderable:(BOOL)refreshHeaderable{
    self.tableView.refreshHeaderable = refreshHeaderable;
}
- (BOOL)refreshHeaderable{
    return self.tableView.refreshHeaderable;
}
- (BOOL)refreshFooterable{
    return self.tableView.refreshFooterable;
}
//设置上啦加载
- (void)setRefreshFooterable:(BOOL)refreshFooterable{
    self.tableView.refreshFooterable = refreshFooterable;
}
//开始刷新数据
- (void)headerRereshing{
    [self didLoaded:HsBaseRefreshTableViewHeader];
}
//开始加载数据
- (void)footerRereshing{
    [self didLoaded:HsBaseRefreshTableViewFooter];
}

//加载完调用
- (void)didLoaded:(HsBaseRefreshTableViewType)type{
    [self.tableView didLoaded:type];
}
- (void)didLoaded{
     [self.tableView didLoaded:HsBaseRefreshTableViewHeader];
     [self.tableView didLoaded:HsBaseRefreshTableViewFooter];
}

@end


#pragma mark 搜索功能
@implementation HsBaseTableViewController (searchable)


#pragma mark - Propertys 查询过滤器
- (NSMutableArray *)filteredDataSource {
    if (_filteredDataSource == nil) {
        _filteredDataSource = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _filteredDataSource;
}


- (void)setSearchTableViewCellClass:(id)searchTableViewCellClass{
    _searchTableViewCellClass = searchTableViewCellClass;
}
- (Class)searchTableViewCellClass{
    return _searchTableViewCellClass;
}
- (void)setSearchKey:(NSString *)searchKey{
    _searchKey = searchKey;
}
- (NSString *)searchKey{
    return _searchKey;
}

- (void)setSearchDelegate:(id<HsBaseTableViewSearchDelegate>)searchDelegate{
    _searchDelegate = searchDelegate;
}

- (id<HsBaseTableViewSearchDelegate>)searchDelegate{
    return _searchDelegate;
}
//开启搜索功能
- (void)setSearchable:(BOOL)searchable{
    _searchable = searchable;
    if(searchable){
        self.tableView.tableHeaderView = self.aSearchBar;
    }else{
        self.tableView.tableHeaderView = nil;
    }
}
- (BOOL)searchable{
    return _searchable;
}

#pragma mark - 判断当前的tableview是不是搜索中的tableview
- (BOOL)enableForSearchTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return YES;
    }
    return NO;
}

// searchBar 搜索

- (UISearchBar *)aSearchBar {
    if (!_aSearchBar) {
        _aSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
        _aSearchBar.delegate = self;
        _aSearchBar.backgroundColor = [UIColor clearColor];
        
        _searchController = [[UISearchDisplayController alloc] initWithSearchBar:_aSearchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsDelegate = self;
        _searchController.searchResultsDataSource = self;
    }
    return _aSearchBar;
}

- (UISearchDisplayController *)searchController{
    return _searchController;
}

// Content Filtering
- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope {
    [self.filteredDataSource removeAllObjects];
    for (id itemInfo in self.itemsArray) {
        if ([self searchText:searchText itemInfo:itemInfo]) {
            [self.filteredDataSource addObject:itemInfo];
        }
    }
}
- (BOOL)searchText:(NSString *)searchText itemInfo:(id)itemInfo{
    //itemInfo为字符串时直接按照下面比较   如果是NSDictionary 则先取出来比较
    NSString *text = nil;//数据源
    if([itemInfo isKindOfClass:[NSString class]]){
        text = itemInfo;
    }else if([itemInfo isKindOfClass:[NSDictionary class]]){
        NSAssert(self.searchKey != nil, @"要查询的key为空，无法比对");
        text = itemInfo[self.searchKey];
    }
    NSComparisonResult result = [text compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
    return result == NSOrderedSame;
}


// UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:
     [self.searchDisplayController.searchBar scopeButtonTitles][[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [self.searchDisplayController.searchBar scopeButtonTitles][searchOption]];
    
    return YES;
}

// SearchBar Delegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
}


#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self enableForSearchTableView:tableView]) {//判断是不是搜索界面
        return 1;
    }
    return 0;
}
//加enableForSearchTableView这个判断 是因为处于查询的时候tableview变了
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self enableForSearchTableView:tableView]) {//判断是搜索界面
        return self.filteredDataSource.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //设置数据源给tableviewcell
    if ([self enableForSearchTableView:tableView]) {//判断是不是搜索界面
        HsBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil){
            //给个默认的class
            if(self.searchTableViewCellClass != nil && [self.searchTableViewCellClass isKindOfClass:[UINib class]]){
                [tableView registerNib:self.searchTableViewCellClass forCellReuseIdentifier:cellID];
                cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            }else{
                if(self.searchTableViewCellClass == nil){
                    self.searchTableViewCellClass = [HsBaseTableViewCell class];
                }
                cell = [[self.searchTableViewCellClass alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            }
        }
        cell.dataInfo = self.filteredDataSource[indexPath.row];
        //把行信息也传递给cell 方便后者使用
        cell.indexPath = indexPath;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.searchDelegate && [self.searchDelegate respondsToSelector:@selector(searchTableView:didSelectRowAtIndexPath:)]){
        [self.searchDelegate searchTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}


@end


#pragma mark 编辑功能

@implementation HsBaseTableViewController (editable)

- (BOOL)editable{
    return self.tableView.editable;
}
- (void)setSingleLineDeleteAction:(SingleLineDeleteAction)singleLineDeleteAction{
    self.tableView.singleLineDeleteAction = singleLineDeleteAction;
    if(singleLineDeleteAction != nil){
        //设置编辑按钮
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithEditStyleAndTableView:self.tableView];
    }
}
- (SingleLineDeleteAction)singleLineDeleteAction{
    return self.tableView.singleLineDeleteAction;
}

- (void)setMultiLineDeleteAction:(MultiLineDeleteAction)multiLineDeleteAction{
    self.tableView.multiLineDeleteAction = multiLineDeleteAction;
    if(multiLineDeleteAction != nil){
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithEditStyleAndBlock:^(BOOL edit){
            if(edit){
                NSArray *array = [self.tableView indexPathsForSelectedRows];
                self.tableView.multiLineDeleteAction(array);
            }
        } tableView:self.tableView ];
    }
}
- (MultiLineDeleteAction)multiLineDeleteAction{
    return self.tableView.multiLineDeleteAction;
}

@end
