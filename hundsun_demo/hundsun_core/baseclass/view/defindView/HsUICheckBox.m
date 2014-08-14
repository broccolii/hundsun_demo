//
//  CheckBox.m
//  GTT_IOS
//
//  Created by allen.huang on 13-8-9.
//  Copyright (c) 2013年 wjd. All rights reserved.
//

#import "HsUICheckBox.h"

#define Q_CHECK_ICON_WH                    (15.0)
#define Q_ICON_TITLE_MARGIN                (5.0)

@implementation HsUICheckBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self onInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self onInit];
    }
    return self;
}


- (void)onInit{
    self.exclusiveTouch = YES;
    self.titleLabel.numberOfLines=2;
    if(self.unCheckedImage == nil){
        self.unCheckedImage = [UIImage imageNamed:@"checkbox_unchecked"];
    }
    if(self.checkedImage == nil){
        self.checkedImage = [UIImage imageNamed:@"checkbox_checked"];
    }
    [self addTarget:self action:@selector(checkboxBtnChecked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setChecked:(BOOL)checked {
    if (_checked == checked) {
        return;
    }
    
    _checked = checked;
    self.selected = checked;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

- (void)checkboxBtnChecked {
    self.selected = !self.selected;
    _checked = self.selected;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    if(self.style == CheckBoxStyleDefault){
        return CGRectMake(0, (CGRectGetHeight(contentRect) - Q_CHECK_ICON_WH)/2.0, Q_CHECK_ICON_WH, Q_CHECK_ICON_WH);
    }else if(self.style == CheckBoxStyleNoTitle){
        return CGRectMake(0, 0, CGRectGetWidth(contentRect), CGRectGetHeight(contentRect));
    }
    return contentRect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    if(self.style == CheckBoxStyleDefault){
        return CGRectMake(Q_CHECK_ICON_WH + Q_ICON_TITLE_MARGIN, 0,
                      CGRectGetWidth(contentRect) - Q_CHECK_ICON_WH - Q_ICON_TITLE_MARGIN,
                      CGRectGetHeight(contentRect));
    }else if(self.style == CheckBoxStyleNoTitle){
        return CGRectZero;
    }
    return contentRect;
}
- (void)setUnCheckedImage:(UIImage *)unCheckedImage{
    _unCheckedImage = unCheckedImage;
    if(unCheckedImage != nil){
        [self setImage:unCheckedImage forState:UIControlStateNormal];
    }
}
- (void)setCheckedImage:(UIImage *)checkedImage{
    _checkedImage = checkedImage;
    if(checkedImage != nil){
        [self setImage:checkedImage forState:UIControlStateSelected];
    }
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if(self.unCheckedImage != nil){
        [self setImage:self.unCheckedImage forState:UIControlStateNormal];
    }
    if(self.checkedImage != nil){
        [self setImage:self.checkedImage forState:UIControlStateSelected];
    }
}

- (void)dealloc {
    _delegate = nil;
}

@end
