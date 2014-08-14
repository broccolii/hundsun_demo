//
//  RTLableScrollView.m
//  hospitalcloud_jkhn
//
//  Created by wjd on 14-4-25.
//  Copyright (c) 2014年 hundsun. All rights reserved.
//

#import "HsRCLableScrollView.h"

const HsRCLableContentPadding HsRCLableContentPaddingZero={0,0,0,0};

@interface HsRCLableScrollView ()

@property (nonatomic,strong) HsRCLable *rtLable;

@end

@implementation HsRCLableScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.rtLable.linespacing = 4.0f;
        self.rtLable.closeCopy = YES;
        self.rtLable.font = [UIFont systemFontOfSize:14.0f];
        self.rtLable.textColor = [UIColor blackColor];
        self.rtLable.lineBreakMode = HsRCTextLineBreakModeCharWrapping;
        self.rtLable = [[HsRCLable alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.rtLable];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.rtLable.linespacing = 4.0f;
        self.rtLable.closeCopy = YES;
        self.rtLable.font = [UIFont systemFontOfSize:14.0f];
        self.rtLable.textColor = [UIColor blackColor];
        self.rtLable.lineBreakMode = HsRCTextLineBreakModeCharWrapping;
        self.rtLable = [[HsRCLable alloc] initWithCoder:aDecoder];
        [self addSubview:self.rtLable];
    }
    return self;
}

- (void)setContentPadding:(HsRCLableContentPadding)contentPadding{
    _contentPadding = contentPadding;
    self.rtLable.frame = CGRectMake(contentPadding.left, contentPadding.top, self.frame.size.width-(contentPadding.left+contentPadding.right), self.frame.size.height-(contentPadding.top+contentPadding.bottom));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)layoutSubviews{
    [super layoutSubviews];    
    self.rtLable.linespacing = self.linespacing;
    self.rtLable.delegate = self.rtLableDelegate;
    self.rtLable.maxLineHeight = self.maxLineHeight;
    self.rtLable.minLineHeight = self.minLineHeight;
    self.rtLable.closeCopy = self.closeCopy;
    self.rtLable.keyword = self.keyword;
    self.rtLable.textColor = self.textColor;
    self.rtLable.font = self.font;
    self.rtLable.lineBreakMode = self.lineBreakMode;
    self.rtLable.text = self.text;
    CGRect frame = self.rtLable.frame;
    frame.size.height = self.rtLable.optimumSize.height;
    self.rtLable.frame = frame;
    
    self.contentSize = CGSizeMake(self.frame.size.width, self.rtLable.optimumSize.height+self.contentPadding.top+self.contentPadding.bottom+10);
}

@end
