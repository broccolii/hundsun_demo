//
//  VerticallyAlignedLabel.m
//  GTT_IOS
//
//  Created by allen.huang on 13-7-18.
//  Copyright (c) 2013年 allen.huang. All rights reserved.
//

#import "HsUILabel.h"

@implementation HsUILable

@synthesize verticalAlignment = verticalAlignment_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.verticalAlignment = HsVerticalAlignmentMiddle;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.verticalAlignment = HsVerticalAlignmentMiddle;
    }
    return self;
}

- (void)setVerticalAlignment:(HsVerticalAlignment)verticalAlignment
{
    verticalAlignment_ = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    //左上 不做处理
    //左中
    if(self.verticalAlignment == (HsVerticalAlignmentLeft | HsVerticalAlignmentMiddle)){
        textRect.origin.x = bounds.origin.x;
        textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }else if(self.verticalAlignment == (HsVerticalAlignmentLeft | HsVerticalAlignmentBottom) || self.verticalAlignment == HsVerticalAlignmentBottom){//左下
        textRect.origin.x = bounds.origin.x;
        textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
    }else if(self.verticalAlignment == (HsVerticalAlignmentMiddle | HsVerticalAlignmentTop)){//中上
        textRect.origin.x = bounds.origin.x + (bounds.size.width - textRect.size.width)/2.0f;
        textRect.origin.y = bounds.origin.y;
    }else if(self.verticalAlignment == HsVerticalAlignmentMiddle){//中中
        textRect.origin.x = bounds.origin.x + (bounds.size.width - textRect.size.width)/2.0f;
        textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }else if(self.verticalAlignment == (HsVerticalAlignmentMiddle | HsVerticalAlignmentBottom)){//中下
        textRect.origin.x = bounds.origin.x + (bounds.size.width - textRect.size.width)/2.0f;
        textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
    }else if(self.verticalAlignment == (HsVerticalAlignmentRight | HsVerticalAlignmentTop ) || self.verticalAlignment ==HsVerticalAlignmentRight) {//右上
        textRect.origin.x = bounds.origin.x+bounds.size.width - textRect.size.width;
        textRect.origin.y = bounds.origin.y;
    }else if(self.verticalAlignment == (HsVerticalAlignmentRight | HsVerticalAlignmentMiddle) ){//右中
        textRect.origin.x = bounds.origin.x + bounds.size.width - textRect.size.width;
        textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height)/2.0f;
    }else if(self.verticalAlignment == (HsVerticalAlignmentRight | HsVerticalAlignmentBottom)){//右下
        textRect.origin.x = bounds.origin.x + bounds.size.width - textRect.size.width;
        textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect
{
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
