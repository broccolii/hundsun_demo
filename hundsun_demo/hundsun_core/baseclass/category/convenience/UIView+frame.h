//
//  UIView+frame.h
//  hospitalcloud
//
//  Created by 王金东 on 14-7-28.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frame)

@property (nonatomic) CGFloat frameX;//view的x起点距0的偏移
@property (nonatomic) CGFloat frameY;//view的y起点距0的偏移

@property (nonatomic) CGPoint frameOrigin;//view 的距（0，0）的距离
@property (nonatomic) CGSize frameSize;////view 的宽高

// Setting these modifies the origin but not the size.
@property (nonatomic) CGFloat frameRight;//view的x终点距0的偏移
@property (nonatomic) CGFloat frameBottom;//view的y终点距0的偏移

@property (nonatomic) CGFloat frameWidth;//view的宽
@property (nonatomic) CGFloat frameHeight;//view的高


@end
