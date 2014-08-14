//
//  HsBaseViewController.h
//  nbhssppma_client
//
//  Created by chenjm on 14-4-9.
//  Copyright (c) 2014年 hundsun. All rights reserved.
//

#import <UIKit/UIKit.h>


extern NSString *const ViewControllerReloadView;
extern NSString *const ViewControllerReLoginView;

@interface HsBaseViewController : UIViewController


@property (nonatomic,strong) NIDOM *dom;

//可重写css样式名称
- (NSString *)cssName;


/**
 ** baseViewController的公共方法 可对viewController统一设置、刷新
 ** 通过调用sendChangeInTheme才会执行
 **/

- (void)viewDidLayoutWithTheme;

//登陆或登出时，会调用
- (void)viewDidLayoutWithLogin;

/**
 ** pushViewController 暂时只支持class、字符串、和UIViewContrller实例
 **/

- (void)pushViewController:(id)viewController;

- (void)pushViewController:(id)viewController title:(NSString *)title;

- (void)pushViewController:(id)viewController withParams:(NSDictionary *)params;

- (void)pushViewController:(id)viewController title:(NSString *)title withParams:(NSDictionary *)params;

- (void)popViewController;


@end


@interface HsBaseViewController (keyboard)


//如果开启键盘管理发生view的前一项和后一项反序了，在registerKeyBoardManager之前设置subViewReverseSort = YES;即可
@property (nonatomic,assign) BOOL subViewReverseSort;

//开启键盘管理
@property (nonatomic,assign) BOOL registerKeyBoardManager;

/**
 ** 关闭键盘
 **/
- (void)closeKeyBoard;


//开启点击空白区域取消键盘功能
@property (nonatomic,assign) BOOL tapForDismissKeyboard;

@end

