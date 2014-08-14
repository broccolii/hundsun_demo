//
//  VerticallyAlignedLabel.h
//  GTT_IOS
//
//  Created by allen.huang on 13-7-18.
//  Copyright (c) 2013年 allen.huang. All rights reserved.
//
/**
 **自定义Lable 可以设置里面内容的位置
 **/
#import <UIKit/UIKit.h>

typedef enum {
    HsVerticalAlignmentTop = 1 << 0,
    HsVerticalAlignmentBottom = 1 << 1,
    HsVerticalAlignmentMiddle = 1 << 2,
    HsVerticalAlignmentLeft = 1 << 3,
    HsVerticalAlignmentRight = 1 << 4,
    
} HsVerticalAlignment;

@interface HsUILable : UILabel{
    @private
        HsVerticalAlignment verticalAlignment_;
}

@property (nonatomic, assign) HsVerticalAlignment verticalAlignment;

@end
