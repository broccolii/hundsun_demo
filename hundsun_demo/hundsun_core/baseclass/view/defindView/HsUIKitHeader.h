//
//  HsUIKitHeader.h
//  hundsun_zjfae
//
//  Created by 王金东 on 14-8-1.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

/**
 ** gridView
 **/

#define GRIDVIEW_STATIC_INLINE	static inline //静态内联

typedef NS_ENUM(NSInteger, HsUIGridViewCellStyle) {
    GridViewCellStyleWithImage,	//上面imageview 下面contentLable
    GridViewCellStyleWithTitle,//上面title 下面contentLable
    GridViewCellStyleWithImageWithoneLineOfContent,//上面imageview 下面只有1行的contentLable
    GridViewCellStyleWithTitleWithoneLineOfTitle,//上面title 下面只有一行的contentLable
    GridViewCellStyleWithOnlyImage,//只有一张图片
    GridViewCellStyleWithOnlyTitle,//只有title
    GridViewCellStyleWithImageWithTwoLineOfContent, //图片在上，中间标题，下面是内容
};


typedef struct{
    CGFloat top;
    CGFloat left;
    CGFloat bottom;
    CGFloat right;
} HsUIGridViewPading;

//静态内联 可以防止别处import时 生成重复结构体
GRIDVIEW_STATIC_INLINE HsUIGridViewPading HsUIGridViewPadingMake(CGFloat top,CGFloat left,CGFloat bottom,CGFloat right){
    HsUIGridViewPading padding = {top, left, bottom, right};
    return padding;
}
