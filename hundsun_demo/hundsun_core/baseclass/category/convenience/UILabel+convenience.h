//
//  UILabel+convenience.h
//  GTT_IOS
//
//  Created by allen.huang on 13-12-26.
//  Copyright (c) 2013年 allen.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    UILabelResizeType_constantHeight = 1,//固定高度
    UILabelResizeType_constantWidth,//固定宽度
} UILabelResizeType;

@interface UILabel (convenience)

@property (nonatomic) CGSize viewSize;//得到该控件文本的size  不能用textSize字段

@property (nonatomic,assign)NSInteger maxLines;//最大行数

//自动调整frame
- (void)autoReSizeFrame;


// 调整UILabel尺寸
// UILabelResizeType_constantHeight 高度不变
- (void)resize:(UILabelResizeType)type;

// 返回估计的尺寸
- (CGSize) estimateUISizeByHeight:(CGFloat)height;
- (CGSize) estimateUISizeByWidth:(CGFloat)width;

//类方法计算文本size
+ (CGSize)textSize:(NSString *)string font:(UIFont *)font width:(CGFloat)width;


@end
