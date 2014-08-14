//
//  HsUISegmentItem.m
//  HsUICustomSegmenControl
//
//  Created by wjd on 12-2-19.
//  Copyright (c) 2012年 wjd. All rights reserved.

#import "HsUISegmentItem.h"

#define sepImageWidth 0

@implementation HsUISegmentItem{
    UIImage *defaultBackgroundImage;
}
@synthesize titleLabel;
@synthesize index;
@synthesize delegate;
@synthesize backgroundImgView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

- (void)dealloc
{
    self.backgroundImgView = nil;
    self.titleFont = nil;
    self.selectedColor = nil;
    self.normalColor = nil;
}
//点击item的事件
- (void)tapOnSelf:(UITapGestureRecognizer*)tapR
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapOnItem:)]) {
        [self.delegate didTapOnItem:self];
    }
}
//切换到正常状态
- (void)switchToNormal
{
    //设置title的颜色
    if(self.normalColor == nil){
        self.titleLabel.textColor = [UIColor blackColor];
    }else{
        self.titleLabel.textColor = self.normalColor;
    }
    //设置背景颜色
    if(self.unselectBackgroundImage != nil){
        self.backgroundImgView.image = self.unselectBackgroundImage;
    }else{
        self.backgroundImgView.image = defaultBackgroundImage;
    }
}
//切换到选中状态
- (void)switchToSelected
{
    //设置title的颜色
    if(self.selectedColor == nil){
        self.titleLabel.textColor = [UIColor blueColor];
    }else{
        self.titleLabel.textColor = self.selectedColor;
    }
    //设置背景颜色
    if(self.selectedBackgroundImage != nil){
        self.backgroundImgView.image = self.selectedBackgroundImage;
    }else{
        self.backgroundImgView.image = defaultBackgroundImage;
    }
}
- (void)setNormalColor:(UIColor *)normalColor{
    if(_normalColor != normalColor){
        _normalColor = normalColor;
    }
    if(normalColor != nil){
        self.titleLabel.textColor = normalColor;
    }
}

- (void)setTitleFont:(UIFont *)titleFont{
    if(_titleFont != titleFont){
        _titleFont  = titleFont;
    }
    if(titleFont != nil){
        self.titleLabel.font = titleFont;
    }
}

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title isLastRightItem:(BOOL)state withBackgroundImage:(UIImage *)backImage
{
    if (self = [super initWithFrame:frame]) {
        //set backgroundImageView
        self.backgroundImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0.4,0,frame.size.width-0.8, frame.size.height)];
        self.backgroundImgView.image = backImage;
        defaultBackgroundImage = backImage;
        [self addSubview:backgroundImgView];
        
        //set title
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.4,0,frame.size.width-sepImageWidth-0.8,frame.size.height)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.text = title;
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        UITapGestureRecognizer *tapR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnSelf:)];
        [self addGestureRecognizer:tapR];
        
    }
    return self;
}

@end
