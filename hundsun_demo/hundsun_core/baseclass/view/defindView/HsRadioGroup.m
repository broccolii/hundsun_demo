//
//  HsRadioGroup.m
//  hundsun_zjfae
//
//  Created by 王金东 on 14-8-6.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsRadioGroup.h"

@implementation HsRadioGroup{
    NSArray *_items;
}


- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items{
    self = [super initWithFrame:frame];
    if(self){
        _items = items;
        if(frame.size.width > frame.size.height){
            self.orientation = HsRadioGroupHorizontal;
        }else{
            self.orientation = HsRadioGroupVertical;
        }
        self.padding = 10.0f;
        self.scrollEnabled = NO;
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    //清理子视图
    [self removeSubView];
    
    CGFloat x = self.padding;
    CGFloat y = 0;
    
    CGFloat itemWidth = 0;
    CGFloat itemHeight = 0;
    
    NSInteger num = _items.count;
    if(self.orientation == HsRadioGroupHorizontal){//水平
        if(!self.scrollEnabled){
            itemWidth = (self.frame.size.width-num*self.padding-self.padding)/num;
        }
        itemHeight = self.frame.size.height;
        for (NSInteger i = 0;i < num;i++) {
            HsRadioGroupItem *item = _items[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:item.unSelectedImage forState:UIControlStateNormal];
            [button setImage:item.selectedImage forState:UIControlStateHighlighted];
            [button setImage:item.selectedImage forState:UIControlStateSelected];
            [button setBackgroundImage:self.unSelectedBackgroundImage forState:UIControlStateNormal];
            [button setBackgroundImage:self.selectedBackgroundImage forState:UIControlStateHighlighted];
            [button setBackgroundImage:self.selectedBackgroundImage forState:UIControlStateSelected];
            [button setTitleColor:self.unSelectColor forState:UIControlStateNormal];
            [button setTitleColor:self.selectColor forState:UIControlStateHighlighted];
            [button setTitleColor:self.selectColor forState:UIControlStateSelected];
            
            button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            [button setTitle:item.text forState:UIControlStateNormal];
            CGSize size = [item.text textSizeOfFont:[UIFont systemFontOfSize:12.0f] inSize:CGSizeMake(button.frame.size.width, 20)];
            button.imageEdgeInsets = UIEdgeInsetsMake(0,0,20,-size.width);
            
            [button setTitleEdgeInsets:UIEdgeInsetsMake(25.0, -item.unSelectedImage.size.width, 0.0, 0.0)];
            [button addTarget:self action:@selector(selectRadio:) forControlEvents:UIControlEventTouchUpInside];
            if(itemWidth == 0){
                itemWidth = item.unSelectedImage.size.width>size.width?item.unSelectedImage.size.width+10:size.width+10;
            }
            button.tag = i;
            item.button = button;
            button.frame = CGRectMake(x, y, itemWidth, itemHeight);
            [self addSubview:button];
            x = x+itemWidth+self.padding;
        }
        self.contentSize = CGSizeMake(x, itemHeight);
        
    }else{//垂直
        if(!self.scrollEnabled){
            itemHeight = (self.frame.size.height-num*self.padding-self.padding)/num;
        }
        itemWidth = self.frame.size.width;
        for (NSInteger i = 0;i < num;i++) {
            HsRadioGroupItem *item = _items[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:item.unSelectedImage forState:UIControlStateNormal];
            [button setImage:item.selectedImage forState:UIControlStateHighlighted];
            [button setImage:item.selectedImage forState:UIControlStateSelected];
            [button setBackgroundImage:self.unSelectedBackgroundImage forState:UIControlStateNormal];
            [button setBackgroundImage:self.selectedBackgroundImage forState:UIControlStateHighlighted];
            [button setBackgroundImage:self.selectedBackgroundImage forState:UIControlStateSelected];
            [button setTitleColor:self.unSelectColor forState:UIControlStateNormal];
            [button setTitleColor:self.selectColor forState:UIControlStateHighlighted];
            [button setTitleColor:self.selectColor forState:UIControlStateSelected];
            
            button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            [button setTitle:item.text forState:UIControlStateNormal];
            CGSize size = [item.text textSizeOfFont:[UIFont systemFontOfSize:12.0f] inSize:CGSizeMake(button.frame.size.width, 20)];
            button.imageEdgeInsets = UIEdgeInsetsMake(0,0,20,-size.width);
            
            [button setTitleEdgeInsets:UIEdgeInsetsMake(25.0, -item.unSelectedImage.size.width, 0.0, 0.0)];
            [button addTarget:self action:@selector(selectRadio:) forControlEvents:UIControlEventTouchUpInside];
            if(itemWidth == 0){
                itemWidth = item.unSelectedImage.size.width>size.width?item.unSelectedImage.size.width+10:size.width+10;
            }
            button.tag = i;
            item.button = button;
            button.frame = CGRectMake(x, y, itemWidth, itemHeight);
            [self addSubview:button];
            y = y+itemHeight+self.padding;
        }
         self.contentSize = CGSizeMake(itemWidth, y);
        
    }
    
    //设置选中状态
    [self handClick:self.selectedIndex haveSelectBlock:NO];

}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    [self handClick:selectedIndex haveSelectBlock:NO];
}

- (void)selectRadio:(UIButton *)sender{
    NSInteger index = sender.tag;
    [self handClick:index haveSelectBlock:YES];
}

- (void)handClick:(NSInteger)index haveSelectBlock:(BOOL)haveBlock{
    _selectedIndex = -1;
    for (NSInteger i = 0  ; i<_items.count; i++) {
        HsRadioGroupItem *item = _items[i];
        if(i == index){
            _selectedIndex = i;
            item.button.selected = YES;
            if(haveBlock){
                if(self.selectedBlock != nil){
                    self.selectedBlock(i);
                }
            }
        }else{
            item.button.selected = NO;
        }
    }
}




@end

@implementation HsRadioGroupItem

- (instancetype)initWithTitle:(NSString *)text selectedImage:(UIImage *)selectedImage unselectedImage:(UIImage *)unSelectedImage{
    self = [super init];
    if(self){
        self.text = text;
        self.selectedImage = selectedImage;
        self.unSelectedImage = unSelectedImage;
    }
    return self;
}

- (BOOL)selected{
    return self.button.selected;
}

- (void)setSelected:(BOOL)selected{
    self.button.selected = selected;
}

@end
