//
//  StatusBarWindow.h
//  SMEMU
//
//  Created by allen.huang on 14-3-13.
//  Copyright (c) 2014年 allen.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StatusBarWindowDelegate;

//消失
typedef void(^StatusBarDimssBlock) (void);

//点击
typedef void(^StatusBarTapBlock) (void);

@interface StatusBarWindow : UIWindow

@property (assign,nonatomic) NSTimeInterval delay;

@property (assign,nonatomic) id<StatusBarWindowDelegate> messageDelegate;

- (void)showMultiLineMessage:(NSString *)text;

- (void)showSingleLineMessage:(NSString *)text;

@property (nonatomic,copy)  StatusBarDimssBlock dimssBlock;

@property (nonatomic,copy)  StatusBarTapBlock tapBlock;

+ (instancetype)sharedInstance;

- (void)dismissMessage;

@end

@protocol StatusBarWindowDelegate <NSObject>

- (void)didTapWindow:(StatusBarWindow *)window delegate:(id)delegate;

@end