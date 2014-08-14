//
//  UIView+emptyInfo.m
//  hundsun_zjfae
//
//  Created by 王金东 on 14-7-30.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "UIView+empty.h"
#import <objc/runtime.h>

static NSInteger const activityIndicatorTag = -1024;//指示器tag
static NSInteger const emptyLableTag = -512;//空视图tag
static NSInteger const markImageTag = -256;//图片tag

static const void *UIViewClickblock = &UIViewClickblock;

@implementation UIView (empty)

//显示活动指示器 居中
- (void)showActivityIndicator{
    [self showActivityIndicator:CGRectMake((self.frame.size.width-20)/2, (self.frame.size.height-20)/2, 20, 20)];
}
- (void)showActivityIndicator:(CGRect)rect{
    [self hideActivityIndicator];
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:rect];
    activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    activityIndicatorView.tag = activityIndicatorTag;
    [activityIndicatorView startAnimating];
    [self addSubview:activityIndicatorView];
}
//隐藏活动指示器
- (void)hideActivityIndicator{
    
    [self removeSubViewWithTag:activityIndicatorTag];
    
}

//显示加载中
- (void)showLoading{
    [self showEmptyView:NetWorkLoading];
}
//隐藏加载中
- (void)hideLoading{
    [self hideEmptyView];
}

//显示空视图
- (void)showEmptyView{
    [self showEmptyView:NoDataView];
}
//显示空视图 带单击事件
- (void)showEmptyViewWithClickBlock:(EmptyViewClickBlock)clickBlock{
    [self showEmptyView];
    objc_setAssociatedObject(self, UIViewClickblock, clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//显示空视图
- (void)showEmptyView:(EmptyViewType) type{
    [self showEmptyView:type title:nil];
}
//显示空视图
- (void)showEmptyView:(EmptyViewType) type clickBlock:(EmptyViewClickBlock)clickBlock{
    [self showEmptyView:type title:nil];
    objc_setAssociatedObject(self, UIViewClickblock, clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)showEmptyView:(EmptyViewType) type title:(NSString *)title{
    UIButton *button = nil;
    if([self isKindOfClass:[UIButton class]]){
        button = (UIButton *)self;
        [button setEnabled:YES];//设置可编辑
    }
    [self hideEmptyView];
    if(type == NoDataView){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 180)];
        imageView.image = [UIImage imageNamed:@"no_data"];
        imageView.center = CGPointMake(self.frameWidth/2, self.frameHeight/2);
        imageView.tag = emptyLableTag;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:imageView];
        [imageView addTapGesture:self action:@selector(clickGesture)];
    }else if(type == NetWorkFailView || type == OtherType){
        if(type == NetWorkFailView){
            title = @"咦,网络出现错误!请检查网络!";
        }
        
        if(button != nil || self.frameHeight< 240 | self.frameWidth < 240){
            [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
            [MMProgressHUD show];
            [MMProgressHUD dismissWithError:title afterDelay:1.0];
        }else{
            UIButton *emptyButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frameWidth-240)/2, (self.frameHeight-240)/2, 240, 240)];
            emptyButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
            emptyButton.titleLabel.numberOfLines = 0;
            //设置圆角
            [emptyButton rounded];
            
            CGRect imageFrame = CGRectMake((emptyButton.frameWidth-80)/2, 50, 80, 80);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
            imageView.image = [UIImage imageNamed:@"loadErrorTipImg"];
            [emptyButton addSubview:imageView];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, imageView.frameBottom+10, emptyButton.frameWidth-80, 40)];
            label.text = title;
            label.numberOfLines = 0;
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14.0f];
            [emptyButton addSubview:label];
            
            [emptyButton setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.3]] forState:UIControlStateNormal];
            [emptyButton setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.6]] forState:UIControlStateHighlighted];
            emptyButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
            emptyButton.tag = emptyLableTag;
            [self addSubview:emptyButton];
            [emptyButton addTarget:self action:@selector(clickGesture) forControlEvents:UIControlEventTouchUpInside];
        }
    }else if(type == NetWorkLoading){
        
        if(button != nil || self.frameHeight< 100 | self.frameWidth < 120 ){
            CGRect frame = CGRectMake((self.frame.size.width-20)/2, (self.frame.size.height-20)/2, 20, 20);
            if(button != nil){
                [button setEnabled:NO];//设置不可编辑
                CGSize size = [UILabel textSize:button.titleLabel.text font:button.titleLabel.font width:button.frameWidth];
                frame.origin.x = (button.frameWidth-size.width)/2-30;
            }else{
                 frame.origin.x = 0;
            }
            UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:frame];
            activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
            activityIndicatorView.tag = emptyLableTag;
            [activityIndicatorView startAnimating];
            [self addSubview:activityIndicatorView];
        }else{
            UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 120)];
            centerView.tag = emptyLableTag;
            centerView.backgroundColor = [UIColor clearColor];
            CGRect imageFrame = CGRectMake((centerView.frameWidth-80)/2, 0, 80, 100);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
            imageView.animationImages = @[[UIImage imageNamed:@"LoadingTipImg1"],[UIImage imageNamed:@"LoadingTipImg2"]];
            imageView.animationDuration = 0.3;
            [imageView startAnimating];
            [centerView addSubview:imageView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, centerView.frameHeight-20, centerView.frameWidth-20, 20)];
            label.text = @"正在加载中...";
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14.0f];
            [centerView addSubview:label];
            
            centerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
            [self addSubview:centerView alignment:HsViewAlignmentCenter];
        }
    }
}

- (void)showEmptyTitle:(NSString *) title{
    [self showEmptyView:OtherType title:title];
}

- (void)showEmptyTitle:(NSString *) title clickBlock:(EmptyViewClickBlock)clickBlock{
    [self showEmptyTitle:title];
     objc_setAssociatedObject(self, UIViewClickblock, clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//隐藏空视图
- (void)hideEmptyView{
    if([self isKindOfClass:[UIButton class]]){
        UIButton *button = (UIButton *)self;
        [button setEnabled:YES];//设置可编辑
    }
    [self removeSubViewWithTag:emptyLableTag];
}


- (void)clickGesture{
    EmptyViewClickBlock clickClock = objc_getAssociatedObject(self, UIViewClickblock);
    if(clickClock != nil){
        clickClock();
    }
}




//给view加图标
- (void)addImageNameMark:(NSString *)markImageName{
    [self addImageMark:[UIImage imageNamed:markImageName]];
}

- (void)addImageNameMark:(NSString *)markImageName inRect:(CGRect)rect{
    [self addImageMark:[UIImage imageNamed:markImageName] inRect:rect autoResize:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin];
}

- (void)addImageMark:(UIImage *)markImage{
    [self addImageMark:markImage inRect:CGRectMake(self.frameWidth-15, 0, 15, 15) autoResize:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin];
}
- (void)addImageMark:(UIImage *)markImage inRect:(CGRect)rect{
    [self addImageMark:markImage inRect:rect autoResize:UIViewAutoresizingNone];
}
- (void)addImageMark:(UIImage *)markImage inRect:(CGRect)rect autoResize:(UIViewAutoresizing)autoresizeing{
    [self removeMakrImage];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = markImage;
    imageView.tag = markImageTag;
    imageView.autoresizingMask = autoresizeing;
    [self addSubview:imageView];
}

- (void)removeMakrImage{
    [self removeSubViewWithTag:markImageTag];
}


@end
