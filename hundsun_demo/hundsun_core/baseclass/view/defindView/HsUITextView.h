//
//  HsUITextView.h
//  nbhssppma_client
//
//  Created by 王金东 on 14-7-21.
//  Copyright (c) 2014年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TextViewAutoResizeDelegate;

@interface HsUITextView : UITextView


/**
 The string that is displayed when there is no other text in the text view.
 
 The default value is `nil`.
 */
@property (nonatomic, strong) NSString *placeholder;

/**
 The color of the placeholder.
 
 The default is `[UIColor lightGrayColor]`.
 */
@property (nonatomic, strong) UIColor *placeholderColor;

//高度自适应
@property (nonatomic, assign) BOOL  autoResize;

@property (nonatomic, assign) id<TextViewAutoResizeDelegate> autoresizeDelegate;

@property (nonatomic, assign) CGFloat minHeight;

@property (nonatomic, assign) CGFloat maxHeight;

@property (nonatomic, assign) NSInteger limitLength;//长度限制


@end

@protocol TextViewAutoResizeDelegate <NSObject>

-(void)didChangeFrame:(CGRect)textviewframe;

@end

