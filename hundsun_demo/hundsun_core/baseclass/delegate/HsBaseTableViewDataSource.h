//
//  HsBaseTableViewDataSource.h
//  hundsun_zjfae
//
//  Created by 王金东 on 14-7-30.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HsBaseTableView.h"

@class HsBaseTableView;
@protocol HsBaseTableViewDataSource <NSObject>


@optional

- (NSInteger)baseTableView:(HsBaseTableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)baseTableView:(HsBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)numberOfSectionsInBaseTableView:(HsBaseTableView *)tableView;              // Default is 1 if not implemented

- (NSString *)baseTableView:(HsBaseTableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
- (NSString *)baseTableView:(HsBaseTableView *)tableView titleForFooterInSection:(NSInteger)section;

// Index

- (NSArray *)sectionIndexTitlesForBaseTableView:(UITableView *)tableView;
// return list of section titles to display in section index view (e.g. "ABCD...Z#")
//- (NSInteger)baseTableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;  // tell table which section corresponds to section title/index (e.g. "B",1))

//tableview可以配置多个cell类型
//可以用该方法让tableview在某一row去取它需要的cell类型
//返回的是cellArray的索引位置
- (NSInteger)baseTableView:(HsBaseTableView *)tableView typeForRowAtIndexPath:(NSIndexPath *)indexPath;


/**
 ** 可以设置行样式
 **/
- (void)baseTableView:(HsBaseTableView *)tableView cellStyleForRowAtIndexPath:(HsBaseTableViewCell *)cell;

/**
 **设置指示器类型
 **/
- (UITableViewCellAccessoryType)baseTableView:(HsBaseTableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath;


@end
