//
//  HsBaseTableViewCell.h
//  HsDefindViewDemo
//
//  Created by 王金东 on 14-7-25.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

/**
 ** 默认的cell中的3个控件对应的key如下
 ** image:imageview
 ** title:textLable
 ** detail:detailLable
 **
 **/
#import <UIKit/UIKit.h>

/**
 ** 3个控件的文本key
 **/
extern NSString *const HsCellKeyForImageView;
extern NSString *const HsCellKeyForTitleView;
extern NSString *const HsCellKeyForDetailView;

/**
 ** 样式设置key
 **/
extern NSString *const HsCellColorForTitleView;
extern NSString *const HsCellFontForTitleView;

extern NSString *const HsCellColorForDetailView;
extern NSString *const HsCellFontForDetailView;



//用于点击事件
extern NSString *const HsCellKeySelectedBlock;

/**
 ** 可以将block放入到cell的数据源中
 **/
typedef void(^OnSelectedRowBlock)(NSIndexPath *indexPath);


@class HsBaseViewController;
@interface HsBaseTableViewCell : UITableViewCell

/**
 ** 单例
 **/
+ (instancetype)sharedInstance;

/**
 **行数据
 **/
@property (nonatomic,strong) id dataInfo;

/**
 **行数
 **/
@property (nonatomic,strong) NSIndexPath *indexPath;

/**
 ** 获取tableview
 **/

@property (nonatomic,weak) UITableView *tableView;

/**
 ** 上层的viewcontroller
 **/
@property (nonatomic,weak) HsBaseViewController *baseViewController;

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
 ** 计算行高
 **/
- (CGFloat)baseTableView:(UITableView *)tableView cellInfo:(id)dataInfo;

@end

/**
 ** 为了cell构造数据源方便 增加NSDictionary的Category
 **/
@interface NSDictionary (celldatainfo)

/**
 ** 构造数据源
 ** title：对应textLable
 ** imageName：对应imageView
 ** detail：对应detailLabel
 ** block：对应点击行
 **/
+ (instancetype)title:(NSString *)title imageName:(NSString *)imageName  detail:(NSString *)detail selected:(OnSelectedRowBlock)block;

+ (instancetype)title:(NSString *)title imageName:(NSString *)imageName detail:(NSString *)detail;

+ (instancetype)title:(NSString *)title imageName:(NSString *)imageName;

+ (instancetype)title:(NSString *)title imageName:(NSString *)imageName selected:(OnSelectedRowBlock)block;

+ (instancetype)title:(NSString *)title detail:(NSString *)detail;
+ (instancetype)title:(NSString *)title detail:(NSString *)detail selected:(OnSelectedRowBlock)block;


+ (instancetype)title:(NSString *)title;
+ (instancetype)title:(NSString *)title selected:(OnSelectedRowBlock)block;

@end



