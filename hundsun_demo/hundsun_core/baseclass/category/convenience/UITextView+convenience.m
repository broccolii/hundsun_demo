//
//  UITextView+convenience.m
//  GTT_IOS
//
//  Created by allen.huang on 13-11-25.
//  Copyright (c) 2013年 allen.huang. All rights reserved.
//

#import "UITextView+convenience.h"
#import <objc/runtime.h>

static const void *tminHeight = &tminHeight;
static const void *tmaxHeight = &tmaxHeight;

@implementation UITextView (convenience)
@dynamic textSize;

//类方法计算文本size
+ (CGSize)textSize:(NSString *)string font:(UIFont *)font width:(CGFloat)width{
    if(string.length == 0){
        return CGSizeZero;
    }
    CGSize maxSize = CGSizeMake(width-16, MAXFLOAT);
    CGSize size= [string textSizeOfFont:font inSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading];
    CGSize textSize = CGSizeMake(size.width, size.height+16);
    return textSize;
}

- (CGSize)textSize{
    CGFloat minHeight = self.minHeight;
    CGFloat maxHeight = self.maxHeight;
    if(maxHeight == 0 ){
        maxHeight = MAXFLOAT;
    }
    if(minHeight <= 0 && (self.text.length == 0 || self.text == nil)){
        return CGSizeZero ;
    }
    //计算文本size
    CGSize size = [UITextView textSize:self.text font:self.font width:self.bounds.size.width];
    CGSize textsize = CGSizeMake(size.width, size.height);
    //处理文本siz以满足设定条件
    if(size.height <= minHeight){
        if(minHeight == 0){
            textsize.height = 0;
        }else{
            textsize.height = minHeight+16;
        }
    }else if(size.height >= maxHeight){
        textsize.height = maxHeight+16;
    }
    return textsize;    
}

- (void)setMinHeight:(CGFloat)minHeight{
    objc_setAssociatedObject(self, tminHeight, [NSNumber numberWithFloat:minHeight], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)minHeight{
    NSNumber *height = objc_getAssociatedObject(self, tminHeight);
    return [height floatValue];
}
- (void)setMaxHeight:(CGFloat)maxHeight{
    objc_setAssociatedObject(self, tmaxHeight, [NSNumber numberWithFloat:maxHeight], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)maxHeight{
    NSNumber *height = objc_getAssociatedObject(self, tmaxHeight);
    return [height floatValue];
}

@end
