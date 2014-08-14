//
//  HsBaseTableViewDelegate.h
//  hundsun_zjfae
//
//  Created by 王金东 on 14-7-30.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HsBaseTableView.h"

@protocol HsBaseTableViewDelegate <NSObject>


@optional

- (CGFloat)baseTableView:(HsBaseTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)baseTableView:(HsBaseTableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)baseTableView:(HsBaseTableView *)tableView heightForFooterInSection:(NSInteger)section;

// Section header & footer information. Views are preferred over title should you decide to provide both

- (UIView *)baseTableView:(HsBaseTableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
- (UIView *)baseTableView:(HsBaseTableView *)tableView viewForFooterInSection:(NSInteger)section;   // custom view for footer. will be adjusted to default or specified footer height

- (void)baseTableView:(HsBaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)baseTableView:(HsBaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


- (void)baseTableViewDidScroll:(HsBaseTableView *)tableView;

- (void)baseTableViewDidEndDecelerating:(HsBaseTableView *)tableView;


// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
//- (NSIndexPath *)baseTableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSIndexPath *)baseTableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
//// Called after the user changes the selection.
//
//- (void)baseTableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);

// Accessories (disclosures).
//- (void)baseTableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
//
//// Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
//// If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
//- (CGFloat)baseTableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0);
//- (CGFloat)baseTableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
//- (CGFloat)baseTableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);


@end
