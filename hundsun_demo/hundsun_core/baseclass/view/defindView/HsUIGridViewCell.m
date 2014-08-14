//
//  HsUIGridViewCell.m
//  hundsun_zjfae
//
//  Created by 王金东 on 14-8-1.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsUIGridViewCell.h"


@implementation HsUIGridViewCell

//根据指定类型 创建cell
- (id)initWithStyle:(HsUIGridViewCellStyle)style{
    return [self initWithStyle:style frame:CGRectMake(0, 0, 90, 90)];
}
- (id)initWithStyle:(HsUIGridViewCellStyle)style frame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        //self.backgroundColor = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1];
        self.enabled = YES;
        _style = style;
        switch (style) {
            case GridViewCellStyleWithTitle:
                [self styleWithTitle];
                break;
            case GridViewCellStyleWithTitleWithoneLineOfTitle:
                [self styleWithTitleWithOnLine];
                break;
            case GridViewCellStyleWithImageWithoneLineOfContent:
                [self styleWithImageWithOneLine];
                break;
            case GridViewCellStyleWithOnlyImage:
                [self styleWithOnlyImage];
                break;
            case GridViewCellStyleWithOnlyTitle:
                [self styleWithOnlyTitle];
                break;
            case GridViewCellStyleWithImageWithTwoLineOfContent:
                [self styleWithImageWithTwoLine];
                break;
            default:
                [self styleWithImage];
                break;
        }
    }
    return self;
}
//设置背景图片
- (void)setBackgroundImage:(UIImage *)backgroundImage{
    if(backgroundImageView==nil){
        backgroundImageView=[[UIImageView alloc] initWithFrame:self.frame];
        backgroundImageView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self insertSubview:backgroundImageView atIndex:0];
    }
    if(_backgroundImage != backgroundImage){
        _backgroundImage = backgroundImage;
    }
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    backgroundImageView.image=self.backgroundImage;
}

- (void)setEnabled:(BOOL)enabled{
    _enabled = enabled;
    if(enabled){
        self.backgroundColor = [UIColor clearColor];
        self.selectedColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
        self.normalColor = [UIColor clearColor];
    }else{
        self.backgroundColor = [UIColor clearColor];
        self.selectedColor = nil;
        self.normalColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.1];
    }
}

//设置正常状态下的背景颜色
- (void)setNormalColor:(UIColor *)normalColor{
    if(_normalColor!=normalColor){
        _normalColor = normalColor;
    }
    self.backgroundColor=_normalColor;
}

//设置选中状态下的背景颜色
- (void)setSelectedColor:(UIColor *)selectedColor{
    if(_selectedColor != selectedColor){
        _selectedColor = selectedColor;
    }
    self.userInteractionEnabled=YES;//如果设置了 则让其可以相应 触摸事件
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.enabled){
        [self setBackgroundColor:_selectedColor];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.enabled){
        [self setBackgroundColor:_normalColor];
        if(self.delegate){
            [self.delegate didSelected:self];
        }
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.enabled){
        [self setBackgroundColor:_normalColor];
    }
}
- (void)setCanDelete:(BOOL)canDelete{
    _canDelete = canDelete;
    if(self.canDelete){
        UIImageView *deleteImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];//删除按钮
        if(self.deleteImage == nil){
            deleteImage.image = [UIImage imageNamed:@"person_delete.png"];
        }else{
            deleteImage.image = self.deleteImage;
            CGRect frame = deleteImage.frame;
            frame.size.width = self.deleteImage.size.width;
            frame.size.height = self.deleteImage.size.height;
            deleteImage.frame = frame;
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.delegate action:@selector(didDeleted:)];
        self.userInteractionEnabled = YES;
        deleteImage.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addGestureRecognizer:tap];
        [self addSubview:deleteImage];
    }
}

//创建 标题在上 描述在下的 布局
- (void)styleWithTitleWithOnLine{
    CGRect parentFrame = self.frame;
    CGFloat margin = 0.0;
    CGRect titleFrame = CGRectMake(margin, 0.0, parentFrame.size.width - (margin *2),parentFrame.size.height-25);
    _title= [[UILabel alloc] initWithFrame:titleFrame];
    
    _title.backgroundColor = [UIColor clearColor];
    _title.font = [UIFont systemFontOfSize:14.0f];
    _title.adjustsFontSizeToFitWidth = YES;
    _title.textAlignment=NSTextAlignmentCenter;
    _title.contentMode = UIViewContentModeScaleAspectFit;
    _title.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:_title];
    
    
    CGRect valueFrame = CGRectMake(margin,titleFrame.size.height, parentFrame.size.width - (margin *2),25);
    _content = [[UILabel alloc] initWithFrame:valueFrame];
    _content.textAlignment=NSTextAlignmentCenter;
    _content.backgroundColor = [UIColor clearColor];
    _content.font = [UIFont systemFontOfSize:14.0f];
    _content.adjustsFontSizeToFitWidth = YES;
    _content.contentMode = UIViewContentModeScaleAspectFit;
    _content.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_content];
}

//创建 图片在上 描述在下的布局

- (void)styleWithImageWithOneLine{
    CGRect parentFrame = self.frame;
    CGFloat margin = 0.0;
    CGRect titleFrame = CGRectMake(margin, 0.0, parentFrame.size.width - (margin *2), parentFrame.size.height-25);
    _imageView= [[UIImageView alloc] initWithFrame:titleFrame];
    
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:_imageView];
    
    CGRect valueFrame = CGRectMake(margin,titleFrame.size.height, parentFrame.size.width - (margin *2),25);
    _content = [[UILabel alloc] initWithFrame:valueFrame];
    _content.textAlignment=NSTextAlignmentCenter;
    _content.backgroundColor = [UIColor clearColor];
    _content.font = [UIFont systemFontOfSize:14.0f];
    _content.adjustsFontSizeToFitWidth = YES;
    _content.contentMode = UIViewContentModeScaleAspectFit;
    _content.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_content];
}
// 图片在上 标题在中，描述在下
-(void) styleWithImageWithTwoLine{
    CGRect parentFrame = self.frame;
    CGFloat margin = 0.0;
    CGRect titleFrame = CGRectMake(margin, 0.0, parentFrame.size.width - (margin *2), parentFrame.size.height-45);
    _imageView= [[UIImageView alloc] initWithFrame:titleFrame];
    
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:_imageView];
    
    CGRect title2Frame = CGRectMake(margin,parentFrame.size.height-45, parentFrame.size.width - (margin *2),20);
    _title = [[UILabel alloc] initWithFrame:title2Frame];
    _title.textAlignment=NSTextAlignmentCenter;
    _title.backgroundColor = [UIColor clearColor];
    _title.font = [UIFont systemFontOfSize:14.0f];
    
    _title.adjustsFontSizeToFitWidth = YES;
    _title.contentMode = UIViewContentModeScaleAspectFit;
    _title.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_title];
    
    CGRect valueFrame = CGRectMake(margin,title2Frame.origin.y+title2Frame.size.height, parentFrame.size.width - (margin *2),25);
    _content = [[UILabel alloc] initWithFrame:valueFrame];
    _content.textAlignment=NSTextAlignmentCenter;
    _content.backgroundColor = [UIColor clearColor];
    _content.font = [UIFont systemFontOfSize:12.0f];
    _content.numberOfLines = 2;
    _content.adjustsFontSizeToFitWidth = YES;
    _content.contentMode = UIViewContentModeScaleAspectFit;
    _content.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_content];
    
}


- (void)styleWithTitle{
    CGRect parentFrame = self.frame;
    CGFloat margin = 2.0;
    CGRect titleFrame = CGRectMake(margin, 5.0, parentFrame.size.width - (margin *2),parentFrame.size.height-35);
    _title= [[UILabel alloc] initWithFrame:titleFrame];
    _title.backgroundColor = [UIColor clearColor];
    _title.font = [UIFont systemFontOfSize:12.0f];
    _title.numberOfLines=0;
    _title.textAlignment=NSTextAlignmentCenter;
    _title.lineBreakMode=NSLineBreakByWordWrapping;;
    // _title.contentMode = UIViewContentModeScaleAspectFit;
    _title.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:_title];
    
    
    CGRect valueFrame = CGRectMake(margin,titleFrame.size.height, parentFrame.size.width - (margin *2),35);
    _content = [[UILabel alloc] initWithFrame:valueFrame];
    _content.textAlignment=NSTextAlignmentCenter;
    _content.backgroundColor = [UIColor clearColor];
    _content.font = [UIFont systemFontOfSize:12.0f];
    _content.numberOfLines=2;
    _content.contentMode = UIViewContentModeScaleAspectFit;
    _content.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_content];
    
}

- (void)styleWithImage{
    CGRect parentFrame = self.frame;
    CGFloat margin = 2.0;
    CGRect imageFrame = CGRectMake(margin, margin, parentFrame.size.width - (margin *2), parentFrame.size.height-40);
    _imageView= [[UIImageView alloc] initWithFrame:imageFrame];
    
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:_imageView];
    
    CGRect valueFrame = CGRectMake(margin,imageFrame.origin.y + imageFrame.size.height, parentFrame.size.width - (margin *2),40);
    _content = [[UILabel alloc] initWithFrame:valueFrame];
    _content.textAlignment=NSTextAlignmentCenter;
    _content.backgroundColor = [UIColor clearColor];
    _content.font = [UIFont systemFontOfSize:12.0f];
    _content.numberOfLines=2;
    _content.contentMode = UIViewContentModeScaleAspectFit;
    _content.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_content];
}

- (void)styleWithOnlyImage{
    CGRect parentFrame = self.frame;
    CGFloat margin = 2.0f;
    CGRect imageFrame = CGRectMake(margin, margin, parentFrame.size.width - margin *2, parentFrame.size.height-margin*2);
    _imageView= [[UIImageView alloc] initWithFrame:imageFrame];
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:_imageView];
}

- (void)styleWithOnlyTitle{
    CGRect parentFrame = self.frame;
    CGRect titleFrame = CGRectMake(0, 0, parentFrame.size.width,parentFrame.size.height);
    _title= [[UILabel alloc] initWithFrame:titleFrame];
    _title.backgroundColor = [UIColor clearColor];
    _title.font = [UIFont systemFontOfSize:20.0f];
    _title.numberOfLines=0;
    _title.textAlignment=NSTextAlignmentCenter;
    _title.lineBreakMode=NSLineBreakByWordWrapping;;
    // _title.contentMode = UIViewContentModeScaleAspectFit;
    _title.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self addSubview:_title];
}


//设置图片 偏距
- (void)setImageMargin:(HsUIGridViewPading)imageMargin{
    _imageMargin=imageMargin;
    CGRect imageFrame =_imageView.frame;
    imageFrame.origin.x=imageMargin.left;
    imageFrame.origin.y = imageMargin.top;
    if(_style == GridViewCellStyleWithOnlyImage){
        imageFrame.size.height = self.frame.size.height-(imageMargin.top+imageMargin.bottom);
    }else{
        imageFrame.size.height = self.frame.size.height-(imageMargin.top+imageMargin.bottom)-self.content.frame.size.height;
    }
    imageFrame.size.width=self.frame.size.width - (imageMargin.left+imageMargin.right);
    _imageView.frame=imageFrame;
}

//设置 title 偏距
- (void)setTitleMargin:(CGFloat)titleMargin{
    _titleMargin=titleMargin;
    CGRect titleFrame =_imageView.frame;
    titleFrame.origin.x=titleMargin;
    titleFrame.size.width=self.frame.size.width - (titleMargin *2);
    _title.frame=titleFrame;
}

- (void)dealloc{
}

@end
