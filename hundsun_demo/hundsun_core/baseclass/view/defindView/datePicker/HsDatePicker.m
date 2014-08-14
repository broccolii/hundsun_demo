//
//  HsDatePicker.m
//
//  Created by Henry Yu on 10-11-06.
//  Copyright Sevenuc.com 2010. All rights reserved.
//  All rights reserved.
//

#import "HsDatePicker.h"
#import "NSDate+convenience.h"
#import "NSString+convenience.h"
#import "HsFormatDataPicker.h"

#define HsDatePickerWithDate @"yyyy-MM-dd"
#define HsDatePickerWithDateAndTime @"yyyy-MM-dd HH:mm:ss"

@interface HsDatePicker ()

@property (nonatomic,strong) HsFormatDataPicker *formatDataPicker;

@end

@implementation HsDatePicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.formatDataPicker = nil;
        _dateFormat = HsDatePickerWithDateAndTime;
    }
    return self;
}
- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.formatDataPicker = nil;
        _dateFormat = HsDatePickerWithDateAndTime;
    }
    return self;
}

- (BOOL)canBecomeFirstResponder
{
	return YES;	
}

// 获得相应时，显示UIActionSheet界面,并重新设置大小
- (BOOL)becomeFirstResponder
{
	if(self.formatDataPicker == nil)
    {
		[self initComponents];
    }
    UIWindow *appWindow = [self window];
    [self.formatDataPicker showInView:appWindow];
    return YES;
}

- (void)dealloc
{
    self.formatDataPicker = nil;
}

-(void) didMoveToWindow
{
	UIWindow* appWindow = [self window];  
	if (appWindow != nil) {        
        [self initComponents];        	
    }
}

// 初始化界面
- (void)initComponents
{
	if(self.formatDataPicker != nil)
    {
        return;
    }
	
	self.formatDataPicker = [[HsFormatDataPicker alloc] init];
    self.formatDataPicker.dateFormat = self.dateFormat;
    
    __weak HsDatePicker *_picker = self;
    
    self.formatDataPicker.block = ^(NSString *text){
        _picker.text = text;
        if(_picker.pickDelegate != nil){
            [_picker.pickDelegate datePicker:_picker date:text];
        }
    };
    [self fetchDefaultToDataPicker];
}

- (void)fetchDefaultToDataPicker{
    if(self.formatDataPicker != nil){
        if(self.text.length > 0){
            self.formatDataPicker.defaultDate = [self.text stringToDate:self.dateFormat];
        }else{
            self.formatDataPicker.defaultDate = [NSDate date];
        }
    }
}


- (void)setDefaultDate:(NSString *)defaultDate{
    if(_defaultDate != defaultDate){
        _defaultDate = defaultDate;
        self.text = defaultDate;
        [self fetchDefaultToDataPicker];
    }
}

- (void)setDateFormat:(NSString *)dateFormat{
    if(_dateFormat != dateFormat){
        _dateFormat = dateFormat;
        if(self.formatDataPicker != nil){
            self.formatDataPicker.dateFormat = self.dateFormat;
        }
    }
    
}


@end
