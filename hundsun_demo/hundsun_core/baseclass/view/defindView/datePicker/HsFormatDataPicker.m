//
//  FormatDataPicker.m
//  GTT_IOS
//
//  Created by allen.huang on 13-8-27.
//  Copyright (c) 2013年 allen.huang. All rights reserved.
//

#import "HsFormatDataPicker.h"
#import "NSDate+convenience.h"

#define hsDateFormatWithDate @"yyyy-MM-dd"
#define hsDateFormatWithDateAndTime @"yyyy-MM-dd HH:mm:ss"

@implementation HsFormatDataPicker

@synthesize action,dateFormat,datePicker;
- (void)showInView:(UIView*)view{
    inview=view;
    if(dateFormat == nil){
        dateFormat = hsDateFormatWithDateAndTime;
    }
    if(action == nil)
    {
		[self initComponents];
    }else{
        [self setDefaultDateWhenShow];
    }
	
    [action showInView: inview];
    [action setBounds:CGRectMake(0, 0, SCREEN_WIDTH, 500)];

}

- (void)setDateFormat:(NSString *)dateformat{
    if(dateFormat != dateformat){
        dateFormat = dateformat;
    }
    [self setPickerFormat];    
}

- (void)setPickerFormat{
    if(datePicker != nil){
        if([hsDateFormatWithDate isEqualToString:self.dateFormat]){
            datePicker.datePickerMode = UIDatePickerModeDate;
        }else{
            datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        }
    }
}

- (void)setDefaultDateWhenShow{
    //设置日期
    if(self.defaultDate == nil){
        [datePicker setDate:[NSDate date] animated:NO];
    }else{
        [datePicker setDate:self.defaultDate animated:NO];
    }
}
// 取消操作
- (void)doCancelClick:(id)sender
{
    if(action != nil)
    {
	    [action dismissWithClickedButtonIndex:1  animated:YES];
	}
}

// 确认操作
- (void)doDoneClick:(id)sender
{
    NSDate *date = [datePicker date];
	NSString *dateString = [date stringOfFormat:dateFormat];
    self.block(dateString);    
	[self doCancelClick:sender];
}

// 初始化界面
- (void)initComponents
{
	if(action != nil)
    {
        return;
    }
	
	action = [[UIActionSheet alloc] initWithTitle:@""
										 delegate:nil
								cancelButtonTitle:nil
						   destructiveButtonTitle:nil
								otherButtonTitles:nil];
	if(IOS7){
        action.backgroundColor = [UIColor whiteColor];
    }
	datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
    [self setPickerFormat];
    //datePicker.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] autorelease];
    [datePicker addTarget:self action:@selector(dateChanged:)
         forControlEvents:UIControlEventValueChanged];
    
	
	UIToolbar *datePickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    if(IOS7){
        datePickerToolbar.barStyle = UIBarStyleDefault;
    }else{
        datePickerToolbar.barStyle = UIBarStyleBlackOpaque;
    }
	[datePickerToolbar sizeToFit];
	
	NSMutableArray *barItems = [[NSMutableArray alloc] init];
	UIBarButtonItem *btnFlexibleSpace = [[UIBarButtonItem alloc]
										 initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
										 target:self action:nil];
	[barItems addObject:btnFlexibleSpace];
		
	UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(doCancelClick:)];
	[barItems addObject:btnCancel];
	
	UIBarButtonItem *btnDone = [[UIBarButtonItem alloc]
                                initWithTitle:@"确定"
                                style:UIBarButtonItemStyleDone
								target:self
								action:@selector(doDoneClick:)];
	[barItems addObject:btnDone];
    
	[datePickerToolbar setItems:barItems animated:YES];
    [self setDefaultDateWhenShow];	
	[action addSubview: datePickerToolbar];
	[action addSubview: datePicker];
    
}
- (void)dateChanged:(id)sender
{
//	NSDate *date = [datePicker date];
//	self.dateString = [Common dateTimeParseToString:date andFormatter:dateFormat];
//    self.block(self.dateString);
}

- (void)dealloc
{
    action = nil;
}

@end
