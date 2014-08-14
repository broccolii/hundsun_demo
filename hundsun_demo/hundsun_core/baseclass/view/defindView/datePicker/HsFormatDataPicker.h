//
//  FormatDataPicker.h
//  GTT_IOS
//
//  Created by allen.huang on 13-8-27.
//  Copyright (c) 2013年 allen.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DatePickerDimss)(NSString*);

@interface HsFormatDataPicker : NSObject{
    UIView *inview;
}

//格式
@property(nonatomic,strong) NSString *dateFormat;

@property(nonatomic,strong) UIDatePicker *datePicker;

@property(nonatomic,strong) UIActionSheet *action;

@property(nonatomic,assign) NSInteger tag;

@property(nonatomic,copy)  DatePickerDimss block;

//默认时间
@property(nonatomic,strong) NSDate *defaultDate;

- (void)showInView:(UIView*)view;

@end
