//
//  HsBaseTableView.m
//  hospitalcloud
//
//  Created by 王金东 on 14-7-28.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "HsBaseTableView.h"
#import "HsRefresh.h"

static NSString *const _cellID = @"baseCellID";

NSString *const HsBaseTableViewKeyTypeForRow = @"typeForRow";

#pragma mark ---------------------我是分割线------------------------------
#pragma mark ----------下面是重写TableView实现-------------------------

@interface HsBaseTableView (){
    BOOL _refreshHeaderable;//下拉刷新
    BOOL _refreshFooterable;//开启上啦加载
    
    NSMutableArray *_itemsArray;//数据源
    
    __weak id<HsBaseTableViewRefreshDelegate> _refreshDelegate;//刷新委托类
    
    //开启编辑能力
    BOOL _editable;
    //单行编辑
    SingleLineDeleteAction _singleLineDeleteAction;
    //多行删除
    MultiLineDeleteAction _multiLineDeleteAction;
}

@end

@implementation HsBaseTableView


- (void)dealloc{
    self.itemsArray = nil;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if(self){
        [self setup];
    }
    return self;
}
- (instancetype)init{
    self = [super init];
    if(self){
        [self setup];
    }
    return self;
}


- (void)setup{
    //去掉多余的分隔线
    [self setExtraCellLineHidden];
    //实例化数据源
    self.delegate = self;
    self.dataSource = self;
    
    self.refreshDelegate = self;
    self.keyOfItemArray = @"items";
}
#pragma mark 注册cell
//注册个tableviewCell
- (void)setTableViewCellClass:(id)tableViewCellClass{
    if(tableViewCellClass != nil){
        _tableViewCellClass = tableViewCellClass;
        //生成cellid
        NSString *cellID = [_cellID stringByAppendingString:@"_0"];
        if([tableViewCellClass isKindOfClass:[UINib class]]){
            [self registerNib:tableViewCellClass forCellReuseIdentifier:cellID];
        }else{
            [self registerClass:tableViewCellClass forCellReuseIdentifier:cellID];
        }
    }
}

//注册tableviewCell
- (void)setTableViewCellArray:(NSArray *)tableViewCellArray{
    if(tableViewCellArray != nil){
        _tableViewCellArray = tableViewCellArray;
        for (NSInteger i = 0; i< tableViewCellArray.count; i++) {
            id cell = tableViewCellArray[i];
            //生成cellid
            NSString *cellID = [_cellID stringByAppendingFormat:@"_%d",i];
            if([cell isKindOfClass:[UINib class]]){
                [self registerNib:cell forCellReuseIdentifier:cellID];
            }else{
                [self registerClass:cell forCellReuseIdentifier:cellID];
            }
        }
    }
}

#pragma mark 构造数据集合  数据源
- (void)setItemsArray:(NSMutableArray *)itemsArray{
    if([itemsArray isKindOfClass:[NSArray class]]){
        _itemsArray = [itemsArray toMutableArray];
    }else{
        _itemsArray = itemsArray;
    }
}

- (NSMutableArray *)itemsArray{
    if(_itemsArray == nil){
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}

@end

#pragma mark ---------------------我是分割线------------------------------
#pragma mark ----------下面是重写TableView的dataSource-------------------------
@interface  HsBaseTableView (baseDataSource)
@end

@implementation HsBaseTableView (baseDataSource)

// HsBaseTableViewDataSource  返回的是cellArray的索引位置
- (NSInteger)tableView:(HsBaseTableView *)tableView typeForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tableViewCellArray != nil){
        if (tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(baseTableView:typeForRowAtIndexPath:)]) {
            return [tableView.baseDataSource baseTableView:tableView typeForRowAtIndexPath:indexPath];
        }else{
            id dataInfo = [self dataInfoforCellatTableView:tableView IndexPath:indexPath];
            if([dataInfo isKindOfClass:[NSDictionary class]]){
                NSInteger type = [dataInfo[HsBaseTableViewKeyTypeForRow] integerValue];
                if(type >= self.tableViewCellArray.count){//如果得到的type大于数组的长度 则默认等于0位置的type
                    type = 0;
                }
                return type;
            }
        }
    }
    return 0;
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(HsBaseTableView *)tableView {
    //自定义
    if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(numberOfSectionsInBaseTableView:)]){
        return [tableView.baseDataSource numberOfSectionsInBaseTableView:tableView];
    }
    if(tableView.sectionable){//分块 二维数组
        NSLog(@"分块显示");
        return tableView.itemsArray.count;
    }
    return 1;
}

//加enableForSearchTableView这个判断 是因为处于查询的时候tableview变了
- (NSInteger)tableView:(HsBaseTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //自定义
    if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(baseTableView:numberOfRowsInSection:)]){
        return [tableView.baseDataSource baseTableView:tableView numberOfRowsInSection:section];
    }
    if(tableView.sectionable){//分块 二维数组
        id cellInfo = tableView.itemsArray[section];
        if([cellInfo isKindOfClass:[NSArray class]]){
            return [(NSArray *)cellInfo count];
        }else if([cellInfo isKindOfClass:[NSDictionary class]]){
            NSArray *array = cellInfo[tableView.keyOfItemArray];
            if(array != nil && [array isKindOfClass:[NSArray class]]){
                return  [array count];
            }
        }
        return 0;
    }
    return tableView.itemsArray.count;
}


//加入右侧索引
- (NSArray *)sectionIndexTitlesForTableView:(HsBaseTableView *)tableView {
    //自定义
    if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(sectionIndexTitlesForBaseTableView:)]){
        return [tableView.baseDataSource sectionIndexTitlesForBaseTableView:tableView];
    }
    return tableView.sectionIndexTitles;
}

- (UITableViewCell *)tableView:(HsBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //自定义
    if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(baseTableView:cellForRowAtIndexPath:)]){
        return [tableView.baseDataSource baseTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    //生成cellid
    NSString *cellID = [_cellID stringByAppendingFormat:@"_%d",[self tableView:tableView typeForRowAtIndexPath:indexPath]];
    HsBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        //给个默认的class
        cell = [[HsBaseTableViewCell alloc] initWithStyle:self.tableViewCellStyle reuseIdentifier:cellID];
    }
    
    NSAssert([cell isKindOfClass:[HsBaseTableViewCell class]], @"cell必须是HsBaseTableViewCell的子类");
    //把行信息也传递给cell 方便后者使用
    cell.indexPath = indexPath;
    cell.baseViewController = _baseViewController;
    cell.keyForTitleView = self.keyForTitleView;
    cell.keyForDetailView = self.keyForDetailView;
    cell.keyForImageView = self.keyForImageView;
    cell.accessoryType = [self tableView:tableView accessoryForRowAtIndexPath:indexPath];
    
    cell.tableView = self;
    cell.dataInfo = [self dataInfoforCellatTableView:tableView IndexPath:indexPath];
    //设置行样式
    [self tableView:tableView cellStyleForRowAtIndexPath:cell];
    return cell;
}


// 可根据行设置行样式  可自定义
- (void)tableView:(HsBaseTableView *)tableView cellStyleForRowAtIndexPath:(HsBaseTableViewCell *)cell{
    if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(baseTableView:cellStyleForRowAtIndexPath:)]){
        [tableView.baseDataSource baseTableView:tableView cellStyleForRowAtIndexPath:cell];
    }
}

// 显示指示器类型
- (UITableViewCellAccessoryType)tableView:(HsBaseTableView *)tableView accessoryForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(baseTableView:accessoryTypeForRowWithIndexPath:)]){
        return [tableView.baseDataSource baseTableView:tableView accessoryTypeForRowWithIndexPath:indexPath];
    }
    return UITableViewCellAccessoryDisclosureIndicator;
}

- (NSString *)tableView:(HsBaseTableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(baseTableView:titleForHeaderInSection:)]){
        return [tableView.baseDataSource baseTableView:tableView titleForHeaderInSection:section];
    }else{
        if(self.keyOfHeadTitle.length > 0){
            return self.itemsArray[section][self.keyOfHeadTitle];
        }
    }
    return nil;
}

- (NSString *)tableView:(HsBaseTableView *)tableView titleForFooterInSection:(NSInteger)section{
    if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(baseTableView:titleForFooterInSection:)]){
       return [tableView.baseDataSource baseTableView:tableView titleForFooterInSection:section];
    }
    return nil;
}


- (id)dataInfoforCellatTableView:(HsBaseTableView *)tableView IndexPath:(NSIndexPath *)indexPath{
    id dataInfo = nil;
    //设置数据源给tableviewcell
    if(tableView.sectionable){//分块
        id cellInfo = tableView.itemsArray[indexPath.section];
        if([cellInfo isKindOfClass:[NSArray class]]){
            dataInfo = cellInfo[indexPath.row];
        }else if([cellInfo isKindOfClass:[NSDictionary class]]){
            NSArray *array = cellInfo[tableView.keyOfItemArray];
            if(array != nil && [array isKindOfClass:[NSArray class]]){
               dataInfo = array[indexPath.row];
            }
        }
    }else{
        dataInfo = tableView.itemsArray[indexPath.row];
    }
    return dataInfo;
}

@end

#pragma mark ---------------------我是分割线------------------------------
#pragma mark ----------下面是重写TableView的delegate-------------------------
@interface HsBaseTableView (baseDelegate)
@end
@implementation HsBaseTableView (baseDelegate)

- (void)tableView:(HsBaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.clearsSelectionDelay){
        [tableView deselectCurrentRow];
    }
    //自定义
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(baseTableView:didSelectRowAtIndexPath:)]){
        return [tableView.baseDelegate baseTableView:tableView didSelectRowAtIndexPath:indexPath];
    }else{
        id dataInfo = [self dataInfoforCellatTableView:tableView IndexPath:indexPath];
        if ([dataInfo isKindOfClass:[NSDictionary class]]) {
            OnSelectedRowBlock block = dataInfo[HsCellKeySelectedBlock];
            if(block != nil){
                block(indexPath);
            }
        }
    }
}

- (CGFloat)tableView:(HsBaseTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(baseTableView:heightForRowAtIndexPath:)]){
        return [tableView.baseDelegate baseTableView:tableView heightForRowAtIndexPath:indexPath];
    }else{
        //将计算高度的方法交给cell来处理
        //生成cellid
        NSString *cellID = [_cellID stringByAppendingFormat:@"_%d",[self tableView:tableView typeForRowAtIndexPath:indexPath]];
        HsBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell != nil){
            cell.indexPath = indexPath;
            cell.keyForTitleView = self.keyForTitleView;
            cell.keyForDetailView = self.keyForDetailView;
            cell.keyForImageView = self.keyForImageView;
            //给cell的dataInfo赋值,并计算高度
            return [cell baseTableView:tableView cellInfo:[self dataInfoforCellatTableView:tableView IndexPath:indexPath]];
        }else{
            return 44.0f;
        }
    }
}

- (CGFloat)tableView:(HsBaseTableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(baseTableView:heightForHeaderInSection:)]){
        return [tableView.baseDelegate baseTableView:tableView heightForHeaderInSection:section];
    }else if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(baseTableView:titleForHeaderInSection:)]){
        NSString *title = [tableView.baseDataSource baseTableView:tableView titleForHeaderInSection:section];
        if(title != nil){
            return 35.0f;
        }
    }else{
        if(self.keyOfHeadTitle.length > 0){
            return 35.0f;
        }
    }
    if(section == 0){
        return self.firstSectionHeaderHeight;
    }
    return 0.0f;
}

- (CGFloat)tableView:(HsBaseTableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(baseTableView:heightForFooterInSection:)]){
        return [tableView.baseDelegate baseTableView:tableView heightForFooterInSection:section];
    }else if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(baseTableView:titleForFooterInSection:)]){
        NSString *title = [tableView.baseDataSource baseTableView:tableView titleForFooterInSection:section];
        if(title != nil){
            return 40.0f;
        }
    }
    return 0.0f;
}

- (UIView *)tableView:(HsBaseTableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(baseTableView:viewForHeaderInSection:)]){
        return [tableView.baseDelegate baseTableView:tableView viewForHeaderInSection:section];
    }else if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(baseTableView:titleForHeaderInSection:)]){
        //如果设置了 title，则不重写head
        return nil;
    }else{//如果不自定义headview并且也没设置title，则给个透明的headview 不然设置了firstSectionHeaderHeight后第一块headview会出现被挡住的效果
        if(self.keyOfHeadTitle == nil){
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, self.firstSectionHeaderHeight)];
            view.backgroundColor = [UIColor clearColor];
            return view;
        }
    }
    return nil;
}
- (UIView *)tableView:(HsBaseTableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(baseTableView:viewForFooterInSection:)]){
        return [tableView.baseDelegate baseTableView:tableView viewForFooterInSection:section];
    }
    return nil;
}

- (void)scrollViewDidScroll:(HsBaseTableView *)tableView{
    if([tableView isKindOfClass:[HsBaseTableView class]] && tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(baseTableViewDidScroll:)]){
        [tableView.baseDelegate baseTableViewDidScroll:tableView];
    }
}

- (void)scrollViewDidEndDecelerating:(HsBaseTableView *)tableView{
    if([tableView isKindOfClass:[HsBaseTableView class]] && tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(baseTableViewDidEndDecelerating:)]){
        [tableView.baseDelegate baseTableViewDidEndDecelerating:tableView];
    }
}

@end

#pragma mark ------------------------------------我是分割线------------------------------
#pragma mark ------------------------------------下面是拓展的功能-------------------------
#pragma mark 刷新功能
@implementation HsBaseTableView (refreshable)

- (void)setRefreshDelegate:(id<HsBaseTableViewRefreshDelegate>)refreshDelegate{
    _refreshDelegate = refreshDelegate;
}

- (id<HsBaseTableViewRefreshDelegate>)refreshDelegate{
    return _refreshDelegate;
}

//设置下拉刷新
- (void)setRefreshHeaderable:(BOOL)refreshHeaderable{
    _refreshHeaderable = refreshHeaderable;
    if(refreshHeaderable){
        // 下拉刷新
        [self addHeaderWithTarget:self.refreshDelegate action:@selector(headerRereshing)];
    }else{
        [self removeHeader];
    }
}
- (BOOL)refreshHeaderable{
    return _refreshHeaderable;
}
- (BOOL)refreshFooterable{
    return _refreshFooterable;
}
//设置上啦加载
- (void)setRefreshFooterable:(BOOL)refreshFooterable{
    _refreshFooterable = refreshFooterable;
    if(refreshFooterable){
        // 上拉加载更多
        [self addFooterWithTarget:self.refreshDelegate action:@selector(footerRereshing)];
    }else{
        [self removeFooter];
    }
}
/**
 **开始刷新数据
 **/
- (void)headerRereshing{
    [self didLoaded:HsBaseRefreshTableViewHeader];
}

/**
 **开始加载数据
 **/
- (void)footerRereshing{
    [self didLoaded:HsBaseRefreshTableViewFooter];
}
//加载完调用
- (void)didLoaded:(HsBaseRefreshTableViewType)type{
    // 刷新表格
    [self reloadData];
    if(type == HsBaseRefreshTableViewHeader){
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self headerEndRefreshing];
    }else{
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self footerEndRefreshing];
    }
}

@end




#pragma mark 编辑能力
@implementation HsBaseTableView (editable)

- (BOOL)editable{
    return _editable;
}
- (void)setSingleLineDeleteAction:(SingleLineDeleteAction)singleLineDeleteAction{
    _singleLineDeleteAction = singleLineDeleteAction;
    if(_singleLineDeleteAction != nil){
        _editable = YES;
    }else{
        _editable = NO;
    }
}
- (SingleLineDeleteAction)singleLineDeleteAction{
    return _singleLineDeleteAction;
}

- (void)setMultiLineDeleteAction:(MultiLineDeleteAction)multiLineDeleteAction{
    _multiLineDeleteAction = multiLineDeleteAction;
    if(_multiLineDeleteAction != nil){
        _editable = YES;
    }else{
        _editable = NO;
    }
}
- (MultiLineDeleteAction)multiLineDeleteAction{
    return _multiLineDeleteAction;
}

#pragma mark 编辑模式

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _editable;
}

//编缉按扭样式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_multiLineDeleteAction != nil){
        return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        _singleLineDeleteAction(indexPath);
    }
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
