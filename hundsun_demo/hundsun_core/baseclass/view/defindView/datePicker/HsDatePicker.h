//
//  HsDatePicker.h
//
//  Created by Henry Yu on 10-11-06.
//  Copyright Sevenuc.com 2010. All rights reserved.
//  All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HsDatePickerDelegate;

@interface HsDatePicker : UITextField<UITextFieldDelegate>

//日期格式
@property(nonatomic,strong) NSString *dateFormat;

@property(nonatomic,assign) NSInteger tag;

@property(nonatomic,assign) id<HsDatePickerDelegate> pickDelegate;

//默认值
@property(nonatomic,strong) NSString *defaultDate;

- (void)initComponents;

@end


@protocol HsDatePickerDelegate

- (void)datePicker:(HsDatePicker *)hsDate date:(NSString *)dateString;

@end

//@protocol HsDatePickerDelegate
//@required
//- (void)dateChanged:(NSDate*)date;
//- (void)buttonClicked:(NSInteger)button;

//@end
