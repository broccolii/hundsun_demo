//
//  UILabel+convenience.m
//  GTT_IOS
//
//  Created by allen.huang on 13-12-26.
//  Copyright (c) 2013年 allen.huang. All rights reserved.
//

#import "UILabel+convenience.h"
#import <objc/runtime.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define MB_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define MB_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif

static const void *tmaxLines = &tmaxLines;

@implementation UILabel (convenience)


//获得字符串实际尺寸
+ (CGSize)textSize:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    if(string.length == 0){
        return CGSizeZero;
    }
    //设置一个行高上限
   CGSize maxSize = CGSizeMake(width,MAXFLOAT);
   return  [string textSizeOfFont:font inSize:maxSize];
}


- (CGSize)viewSize{
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize size = [UILabel textSize:self.text font:self.font width:self.bounds.size.width];
    if(self.maxLines > 0){
        CGFloat lineHeight = self.font.lineHeight;
        CGFloat maxHeight = lineHeight * self.maxLines;
        if(size.height > maxHeight){
            size.height = maxHeight;
        }
    }
    
    return size;
}

- (void)setViewSize:(CGSize)viewSize{
    CGRect frame = self.frame;
    frame.size.width = viewSize.width;
    frame.size.height = viewSize.height;
    self.frame = frame;
}

- (void)setMaxLines:(NSInteger)maxLines{
    self.lineBreakMode = NSLineBreakByTruncatingTail;
    self.numberOfLines = 0;
    objc_setAssociatedObject(self, tmaxLines, [NSNumber numberWithFloat:maxLines], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)maxLines{
    NSNumber *lines = objc_getAssociatedObject(self, tmaxLines);
    return [lines integerValue];
}

- (void)autoReSizeFrame{
    CGSize size = self.viewSize;
    CGSize frameSize = CGSizeMake(size.width, size.height);
    self.viewSize = frameSize;
}



- (void)resize:(UILabelResizeType)type{
    CGSize size;
    if (type == UILabelResizeType_constantHeight) {
        // 高不变
        size = [self estimateUISizeByHeight:self.bounds.size.height];
        if (!CGSizeEqualToSize(CGSizeZero, size)) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, self.bounds.size.height);
        }
    }else if (type == UILabelResizeType_constantWidth) {
        // 宽不变
        size = [self estimateUISizeByWidth:self.bounds.size.width];
        if (!CGSizeEqualToSize(CGSizeZero, size)) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, size.height);
        }
        
    }
}

- (CGSize)estimateUISizeByBound:(CGSize)bound
{
	if ( nil == self.text || 0 == self.text.length )
		return CGSizeZero;
    
	return MB_MULTILINE_TEXTSIZE(self.text, self.font, bound, self.lineBreakMode);
}

- (CGSize)estimateUISizeByWidth:(CGFloat)width
{
	if ( nil == self.text || 0 == self.text.length )
		return CGSizeMake( width, 0.0f );
    
	if ( self.numberOfLines )
	{
		return MB_MULTILINE_TEXTSIZE(self.text, self.font, CGSizeMake(width, self.font.lineHeight * self.numberOfLines + 1), self.lineBreakMode);
	}
	else
	{
		return MB_MULTILINE_TEXTSIZE(self.text, self.font, CGSizeMake(width, 999999.0f), self.lineBreakMode);
	}
}

- (CGSize)estimateUISizeByHeight:(CGFloat)height
{
	if ( nil == self.text || 0 == self.text.length )
		return CGSizeMake( 0.0f, height );
    
	return MB_MULTILINE_TEXTSIZE(self.text, self.font, CGSizeMake(999999.0f, height), self.lineBreakMode);
}


@end
