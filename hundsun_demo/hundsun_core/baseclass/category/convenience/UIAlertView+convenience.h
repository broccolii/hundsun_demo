//
//  UIAlertView+convenience.h
//  hospitalcloud_sdzy
//
//  Created by 123 on 14-6-13.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertView_block_self_index)(UIAlertView *alertView, NSInteger btnIndex);
typedef void(^UIAlertView_block_self)(UIAlertView *alertView);
typedef BOOL(^UIAlertView_block_shouldEnableFirstOtherButton)(UIAlertView *alertView);

@interface UIAlertView (convenience)

////选中功能按钮
- (void) handlerClickedButton:(UIAlertView_block_self_index)aBlock;
//选中取消按钮
- (void) handlerCancel:(UIAlertView_block_self)aBlock;
//view即将出现
- (void) handlerWillPresent:(UIAlertView_block_self)aBlock;
// view已经出现
- (void) handlerDidPresent:(UIAlertView_block_self)aBlock;
// view即将消失
- (void) handlerWillDismiss:(UIAlertView_block_self_index)aBlock;
// view已经消失
- (void) handlerDidDismiss:(UIAlertView_block_self_index)aBlock;

- (void) handlerShouldEnableFirstOtherButton:(UIAlertView_block_shouldEnableFirstOtherButton)aBlock;

@end
