//
//  GridView.m
//  GTT_IOS
//
//  Created by allen.huang on 13-8-19.
//  Copyright (c) 2013年 allen.huang. All rights reserved.
//

#import "HsUIGridView.h"

#define defaultHeihgt 100.0f


#pragma mark 九宫格

@protocol HsUIGridWarpViewDelegate;

@interface HsUIGridWarpView : UIView{
    NSMutableArray *_cellHeights;//行高
    NSInteger _numOfSection;//格子总数量
    NSInteger _rowOfSection;//总行数
    NSMutableArray *_cellWidths;//列宽
}
@property (nonatomic,assign) id<HsUIGridWarpViewDelegate> dataSource;
@property (nonatomic,assign) NSInteger columns;//列数
@property (nonatomic,assign) CGFloat itempadding;//每列间隔 也指分隔线的粗度
@property(nonatomic) UITableViewCellSeparatorStyle separatorStyle;
@property(nonatomic,retain) UIColor               *separatorColor;

//头视图
@property (nonatomic,strong) UIView *gridViewHeadView;
//脚视图
@property (nonatomic,strong) UIView *gridViewFootView;

- (void)reloadAllData;
@end


#pragma mark 内部委托类
@protocol HsUIGridWarpViewDelegate <NSObject>

- (NSInteger)numberOfRowsInGridView:(HsUIGridWarpView *)gridview;//return number of section in gridview
- (HsUIGridViewCell*)gridView:(HsUIGridWarpView*)gridview cellAtInSection:(NSIndexPath*)indepath;// retrun cell of row
//NSIndexPath 中section代表行数  row代表格子的位置
@optional
- (CGFloat)gridview:(HsUIGridWarpView *)gridview heightInSection:(NSInteger)section;// return cell height

- (void)gridview:(HsUIGridWarpView *)gridview didSelectRowAtIndexPath:(NSIndexPath *)indexPath;//
- (void)gridviewDidFinishedLayout:(HsUIGridWarpView *)gridview;
- (NSArray *)widthsOfSectionInGridview:(HsUIGridWarpView *)gridview;


@end

@implementation HsUIGridWarpView{
    CGFloat _topViewHeight;
    CGFloat _bottomViewHeight;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.columns = 3;
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _topViewHeight = 0;
    _bottomViewHeight = 0;
    self.autoresizesSubviews = NO;
}


- (void)setGridViewHeadView:(UIView *)gridViewHeadView{
    if(_gridViewHeadView != gridViewHeadView){
        _gridViewHeadView = gridViewHeadView;
        _topViewHeight = gridViewHeadView.frame.size.height;
    }
}
- (void)setGridViewFootView:(UIView *)gridViewFootView{
    if(_gridViewFootView != gridViewFootView){
        _gridViewFootView = gridViewFootView;
        _bottomViewHeight = gridViewFootView.frame.size.height;
    }
}

- (void)setColumns:(NSInteger)columns{
    if(_columns != columns){
        _columns = columns;
        [self reloadAllData];
    }
}
//刷新
- (void)reloadAllData{
    CGRect frame = self.frame;
    if(frame.size.height == 0){
        frame.size.height = 10;
    }
    self.frame = frame;
    [self setNeedsLayout];
}
//移除所有子视图
- (void) removeAll{
    for (UIView *view in self.subviews){
        [view removeFromSuperview];
    }
}
//创建子视图
- (void)createGridItem{
    CGRect frame=self.frame;
    //控件高度==头视图高度+foot视图高度
    CGFloat gridViewHeight = _topViewHeight+_bottomViewHeight;
    
    //加入头视图
    if(self.gridViewHeadView){
        self.gridViewHeadView.frame = CGRectMake(0, 0, self.frame.size.width, self.gridViewHeadView.frame.size.height);
        [self addSubview:self.gridViewHeadView];
    }
    NSInteger sectioncount = 1;//就1块
    for (NSInteger i=0; i<sectioncount; i++) {
        gridViewHeight += [self countHeightToRow:_rowOfSection]+self.itempadding;
        
        for (NSInteger j=0; j< _numOfSection; j++) {
            //计算cell位置
            int column = j%_columns;
            int row = j/_columns;
            int x = [self countWidthToColumn:column]+self.itempadding;
            //用当前行距上的高度+分隔线高度+头视图的高度
            int y = [self countHeightToRow:row]+self.itempadding+_topViewHeight;
            
            NSIndexPath *indepath=[NSIndexPath indexPathForRow:j inSection:row];//section 代表行数 row代表格子数
            HsUIGridViewCell *cell = [self.dataSource gridView:self cellAtInSection:indepath];
            if(cell==nil){
                cell=[[HsUIGridViewCell alloc] initWithStyle:GridViewCellStyleWithTitle];
            }
            //给cell增加手势
            [cell addTapGesture:self action:@selector(didSelectedGridViewCell:)];
            cell.frame=CGRectMake(x, y, [_cellWidths[column] floatValue], [_cellHeights[row] floatValue]);
            [self addSubview:cell];
            cell = nil;
        }
    }
    frame.size.height=gridViewHeight;
    self.frame=frame;//gridview界面渲染完后 会执行
    
    //加入尾视图
    if(self.gridViewFootView){
        self.gridViewFootView.frame = CGRectMake(0, frame.size.height-_bottomViewHeight, self.frame.size.width, self.gridViewFootView.frame.size.height);
        [self addSubview:self.gridViewFootView];
    }
    if(self.dataSource &&[self.dataSource respondsToSelector:@selector(gridviewDidFinishedLayout:)]){
        [self.dataSource performSelector:@selector(gridviewDidFinishedLayout:) withObject:self];
    }
}
//创建分隔线
- (void)createSepartor{
    if(self.separatorStyle == UITableViewCellSeparatorStyleSingleLine){
        if(_numOfSection == 0){
            return;
        }
        NSInteger rowOfsection=_numOfSection%self.columns==0?(_numOfSection/self.columns):(_numOfSection/self.columns+1);
        for (int j = 0; j <= rowOfsection ; j++) {
            //画row格子线
            UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, [self countHeightToRow:j]+_topViewHeight, self.frame.size.width, self.itempadding)];
            view2.backgroundColor = self.separatorColor ;
            [self addSubview:view2];
        }
        for (int i = 0; i<= self.columns; i++) {
            //画column格子线
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake([self countWidthToColumn:i], _topViewHeight, self.itempadding, self.frame.size.height-(_topViewHeight+_bottomViewHeight))];
            view.backgroundColor = self.separatorColor ;
            [self addSubview:view];
        }
    }
}

//计算到第几列的宽度
- (CGFloat)countWidthToColumn:(NSInteger)column{
    CGFloat totalWidth = 0.0f;
    for (NSInteger i = 0; i < column; i++) {
        totalWidth += [_cellWidths[i] floatValue]+self.itempadding;
    }
    return totalWidth;
}

//计算到第几行的高度
- (CGFloat)countHeightToRow:(NSInteger)row{
    CGFloat totalHeight = 0.0f;
    for (NSInteger i = 0; i < row; i++) {
        totalHeight += [_cellHeights[i] floatValue]+self.itempadding;
    }
    return totalHeight;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self removeAll];//移除所有子视图
    if(self.separatorStyle != UITableViewCellSeparatorStyleNone && self.itempadding == 0){
        self.itempadding = 1;//分割线宽度为1
    }
    //加载列宽
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(widthsOfSectionInGridview:)]){
       NSArray *cellWidths = [self.dataSource performSelector:@selector(widthsOfSectionInGridview:) withObject:self];
       if(cellWidths != nil){
            NSParameterAssert(cellWidths.count == _columns);
           
           CGFloat totalWidth = 0.0f;//总宽度
           NSMutableArray *array = [NSMutableArray array];//新的数组
           for (NSInteger i = 0; i < cellWidths.count-1; i++) {
               totalWidth += [cellWidths[i] floatValue]+self.itempadding;
               [array addObject:cellWidths[i]];
           }
           totalWidth += self.itempadding;//出来最后一行的总宽度
           CGFloat lastCellWidth = self.frame.size.width - totalWidth - self.itempadding;//最后一行宽度 还包括了间隔
           if(lastCellWidth < 0 ){
               @throw [NSException exceptionWithName:@"gridview宽度溢出" reason:@"gridview最后一行超出view之外" userInfo:nil];
           }else{
               [array addObject:[[NSNumber alloc] initWithFloat:lastCellWidth]];
           }
           _cellWidths = array;
       }
    }
    //列宽为空时 给个默认值
    if(_cellWidths == nil){
        CGFloat cellWidth = 0.0f;
        if(_columns>0){
            cellWidth = (self.frame.size.width-_itempadding*(_columns+1))/_columns;
        }else{
            cellWidth = self.frame.size.width-_itempadding*2;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 0; i < _columns; i++) {
            [array addObject:[[NSNumber alloc] initWithFloat:cellWidth]];
        }
        _cellWidths = array;
    }
    
    
    //加载行高
    NSInteger numOfsection=[self.dataSource numberOfRowsInGridView:self];//获取每一个section的格子数量
    _numOfSection = numOfsection;
    _rowOfSection = numOfsection%self.columns==0?(numOfsection/self.columns):(numOfsection/self.columns+1);
    NSMutableArray *cellHeightArray = [NSMutableArray array];
    CGFloat height = 0.0f;
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(gridview:heightInSection:)]){//格子高度
        for (NSInteger row = 0; row < _rowOfSection; row++) {
            height = [self.dataSource gridview:self heightInSection:row];
            if(height == 0.0f){
                height = defaultHeihgt;//默认高度为0.0f
            }
            [cellHeightArray addObject:[[NSNumber alloc] initWithFloat:height]];
        }
    }
    if(cellHeightArray.count == 0){
        for (NSInteger row = 0; row < _rowOfSection; row++) {
            [cellHeightArray addObject:[[NSNumber alloc] initWithFloat:defaultHeihgt]];
        }
    }
    _cellHeights = cellHeightArray;
   
    //以上都是在处理数据
    [self createGridItem];
    
    if(self.separatorColor == nil){
        self.separatorColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];//分割线默认颜色
    }
    [self createSepartor];
}

- (void)didSelectedGridViewCell:(UIGestureRecognizer *)gesture{
    HsUIGridViewCell *cell = (HsUIGridViewCell *)gesture.view;
    if(cell.enabled){
        NSInteger i = [cell locationAtSuperView];
        if(self.dataSource && [self.dataSource respondsToSelector:@selector(gridview:didSelectRowAtIndexPath:)]){
            [self.dataSource performSelector:@selector(gridview:didSelectRowAtIndexPath:) withObject:self withObject:[NSIndexPath indexPathForRow:i inSection:i/_columns]];
        }
    }
}

@end


@interface HsUIGridView ()<HsUIGridViewDelegate>

@property (nonatomic,strong) HsUIGridWarpView *gridView;

@end

@implementation HsUIGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollEnabled = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.columns = 3;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.gridView = [[HsUIGridWarpView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 10)];
        [self addSubview:self.gridView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.columns = 3;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.gridView = [[HsUIGridWarpView alloc] initWithCoder:aDecoder];
        [self addSubview:self.gridView];
    }
    return self;
}

//刷新
- (void)reloadAllData{
    [self.gridView reloadAllData];
}
//移除所有子视图
- (void) removeAll{
    [self.gridView removeAll];
}

- (void)setGridViewInset:(UIEdgeInsets)gridViewInset{
    _gridViewInset = gridViewInset;
    self.gridView.frame = CGRectMake(gridViewInset.left, gridViewInset.top, self.frame.size.width-gridViewInset.left-gridViewInset.right, 10);
}
#pragma mark delegate

- (NSInteger)numberOfRowsInGridView:(HsUIGridWarpView *)gridview{
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInGridView:)]){
        return [self.dataSource numberOfRowsInGridView:self];
    }
    return 0;
}

- (HsUIGridViewCell*)gridView:(HsUIGridWarpView*)gridview cellAtInSection:(NSIndexPath*)indepath{
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(gridView:cellAtInSection:)]){
        return [self.dataSource gridView:self cellAtInSection:indepath];
    }
    return nil;
}
- (CGFloat)gridview:(HsUIGridWarpView *)gridview heightInSection:(NSInteger)section{
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(gridview:heightInSection:)]){
        return [self.dataSource gridview:self heightInSection:section];
    }
    return 0.0f;
}

- (void)gridview:(HsUIGridWarpView *)gridview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(gridview:didSelectRowAtIndexPath:)]){
        return [self.dataSource gridview:self didSelectRowAtIndexPath:indexPath];
    }
}

- (void)gridviewDidFinishedLayout:(HsUIGridWarpView *)gridview{
    self.contentSize = CGSizeMake(self.frame.size.width, gridview.frame.size.height+self.gridViewInset.top+self.gridViewInset.bottom);
    if(!self.scrollEnabled){
        CGRect frame = self.frame;
        frame.size.height = self.contentSize.height;
        frame.size.width = self.contentSize.width;
        self.frame = frame;
    }
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(gridviewDidFinishedLayout:)]){
        return [self.dataSource gridviewDidFinishedLayout:self];
    }
}
- (NSArray *)widthsOfSectionInGridview:(HsUIGridWarpView *)gridview{
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(widthsOfSectionInGridview:)]){
        return [self.dataSource widthsOfSectionInGridview:self];
    }
    return nil;
}


- (void)setGridViewHeadView:(UIView *)gridViewHeadView{
    if(_gridViewHeadView != gridViewHeadView){
        self.gridView.gridViewHeadView = gridViewHeadView;
    }
}
- (void)setGridViewFootView:(UIView *)gridViewFootView{
    if(_gridViewFootView != gridViewFootView){
        self.gridView.gridViewFootView = gridViewFootView;
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gridView.columns = self.columns;
    self.gridView.dataSource = self;
    self.gridView.itempadding = self.itempadding;
    self.gridView.separatorStyle = self.separatorStyle;
    self.gridView.separatorColor = self.separatorColor;
}


@end

