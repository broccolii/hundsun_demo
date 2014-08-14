//
//  HsRCLableScrollView.h
//  hospitalcloud_jkhn
//
//  Created by wjd on 14-4-25.
//  Copyright (c) 2014年 wjd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HsRCLable.h"

#define HsRCLABLE_STATIC_INLINE	static inline //静态内联

//wjd
typedef struct HsRCLableContentPadding{
    CGFloat top, right, bottom,left;
}HsRCLableContentPadding;

//静态内联 可以防止别处import时 生成重复结构体
HsRCLABLE_STATIC_INLINE HsRCLableContentPadding HsRCLableContentPaddingMake(CGFloat top,CGFloat right,CGFloat bottom,CGFloat left){
    HsRCLableContentPadding padding = {top, left, bottom, right};
    return padding;
}

extern const HsRCLableContentPadding HsRCLableContentPaddingZero;

@interface HsRCLableScrollView : UIScrollView

@property (nonatomic, assign) CGFloat linespacing;//行间距

@property (nonatomic, assign) id<HsRCLabelDelegate> rtLableDelegate;//代理类

@property (nonatomic,assign) NSInteger maxLineHeight;

@property (nonatomic,assign) NSInteger minLineHeight;

@property (nonatomic,retain) NSString *text;//当前文本

@property (nonatomic,assign) BOOL closeCopy;//关闭copy功能

@property (nonatomic,strong) NSString *keyword;//关键字

@property (nonatomic,strong) UIColor *textColor;

@property (nonatomic,assign) HsRCLableContentPadding contentPadding;

@property (nonatomic,strong) UIFont *font;

@property (nonatomic,assign) HsRCTextLineBreakMode lineBreakMode;

@end
