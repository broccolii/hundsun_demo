//
//  HsMoreThemeViewController.h
//  hundsun_zjfae
//
//  Created by 王金东 on 14-8-3.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsBaseTableViewController.h"

/**
 * 更多预设的主题
 **/

typedef void(^SettingSuccessBlock)(void);

@interface HsMoreThemeViewController : HsBaseTableViewController

@property (nonatomic,copy) SettingSuccessBlock settingSuccessBlock;

@end
