//
//  UITextView+convenience.h
//  GTT_IOS
//
//  Created by allen.huang on 13-11-25.
//  Copyright (c) 2013年 allen.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (convenience)

@property (nonatomic,assign) CGSize textSize;//得到文本size
@property (nonatomic,assign) CGFloat minHeight;//最小高
@property (nonatomic,assign) CGFloat maxHeight;//最大高

//类方法计算文本size
+ (CGSize)textSize:(NSString *)string font:(UIFont *)font width:(CGFloat)width;


@end
