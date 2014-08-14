//
//  HsUITextView.m
//  nbhssppma_client
//
//  Created by 王金东 on 14-7-21.
//  Copyright (c) 2014年 hundsun. All rights reserved.
//

#import "HsUITextView.h"

@interface HsUITextView ()

@property (nonatomic,strong) UILabel *limitLable;//显示长度限制文本
- (void)_initialize;
- (void)_updateShouldDrawPlaceholder;
- (void)_textChanged:(NSNotification *)notification;

@end

@implementation HsUITextView{
    BOOL _shouldDrawPlaceholder;
}

#pragma mark - Accessors

- (void)setText:(NSString *)string {
    [super setText:string];
    [self _updateShouldDrawPlaceholder];
}


- (void)setPlaceholder:(NSString *)string {
    if ([string isEqual:_placeholder]) {
        return;
    }
    _placeholder = string;
    _shouldDrawPlaceholder = YES;
    [self setNeedsDisplay];
}

- (void)setLimitLength:(NSInteger)limitLength{
    _limitLength = limitLength;
    if(limitLength > 0){
        _limitLable = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-100, self.frame.size.height-20, 95, 18)];
        _limitLable.font = [UIFont systemFontOfSize:12.0f];
        _limitLable.textColor = [UIColor grayColor];
        _limitLable.text = [NSString stringWithFormat:@"%d",limitLength];
        _limitLable.textAlignment = NSTextAlignmentRight;
        _limitLable.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|
        UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:_limitLable];
    }
}


#pragma mark - NSObject

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
    [self removeObserver:self forKeyPath:@"contentOffset" context:nil];
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self _initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self _initialize];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_shouldDrawPlaceholder) {
        [_placeholderColor set];
        [_placeholder drawInRect:CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f, self.frame.size.height - 16.0f) withFont:self.font];
    }
}


#pragma mark - Private

- (void)_initialize {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textChanged:) name:UITextViewTextDidChangeNotification object:self];
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    self.placeholderColor = [UIColor colorWithWhite:0.702f alpha:1.0f];
    _shouldDrawPlaceholder = NO;
    
    self.minHeight=20;
    self.maxHeight = MAXFLOAT;
}


- (void)_updateShouldDrawPlaceholder {
    BOOL prev = _shouldDrawPlaceholder;
    _shouldDrawPlaceholder = self.placeholder && self.placeholderColor && self.text.length == 0;
    _limitLable.text = [NSString stringWithFormat:@"%d",(self.limitLength - self.text.length)];
    if (prev != _shouldDrawPlaceholder) {
        [self setNeedsDisplay];
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGRect frame = _limitLable.frame;
         frame.origin.y = self.contentOffset.y+self.frame.size.height-20;
        _limitLable.frame = frame;
    }
}
- (void)_textChanged:(NSNotification *)notificaiton {
    [self _updateShouldDrawPlaceholder];
    if(self.autoResize){
        [self changeFrame];
    }
}

- (void)changeFrame{
    CGSize size=[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width-16, self.maxHeight) lineBreakMode:NSLineBreakByCharWrapping];
    CGRect frame=self.frame;
    
    if(size.height>self.minHeight&&size.height<self.maxHeight){
        frame.size.height=size.height+16;
    }else if(size.height<=self.minHeight){
        frame.size.height=self.minHeight+16;
    }else if(size.height>=self.maxHeight){
        frame.size.height=self.maxHeight+16;
    }
    self.frame=frame;
    if(self.autoresizeDelegate && [self.autoresizeDelegate respondsToSelector:@selector(didChangeFrame:)]){
        [self.autoresizeDelegate didChangeFrame:frame];
    }
}


@end
