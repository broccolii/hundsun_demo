//
//  UIActionSheet+convenience.h
//  hospitalcloud_sdzy
//
//  Created by 123 on 14-6-13.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIActionSheet_block_self_index)(UIActionSheet *actionSheet, NSInteger btnIndex);
typedef void(^UIActionSheet_block_self)(UIActionSheet *actionSheet);

@interface UIActionSheet (convenience)<UIActionSheetDelegate>

//选中功能按钮
- (void) handlerClickedButton:(UIActionSheet_block_self_index)aBlock;
//选中取消按钮
- (void) handlerCancel:(UIActionSheet_block_self)aBlock;
//view即将出现
- (void) handlerWillPresent:(UIActionSheet_block_self)aBlock;
// view已经出现
- (void) handlerDidPresent:(UIActionSheet_block_self)aBlock;
// view即将消失
- (void) handlerWillDismiss:(UIActionSheet_block_self)aBlock;
// view已经消失
- (void) handlerDidDismiss:(UIActionSheet_block_self_index)aBlock;

@end
