//
//  HsSetting.h
//  hundsun_zjfae
//
//  Created by 王金东 on 14-7-30.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsThemeManager.h"

#define ApplicationDelegate ((HsAppDelegate *)[UIApplication sharedApplication].delegate)

//tableview的第一块的head的默认高度
#define DefaultFirstSectionHeaderHeight 20.0f

//持仓详情定制的cell
#define DefaultDetailTableViewCell @"HsDetailTableViewCell"

//分隔线颜色
#define DefaultDividingLineCssName  @"dividingLine"

#define pageSize @"20"

//是否显示公式
typedef NS_ENUM(NSInteger, ExpressionType) {
    ExpressionTypeNone,//没有公式
    ExpressionTypeShow,//有公式
};