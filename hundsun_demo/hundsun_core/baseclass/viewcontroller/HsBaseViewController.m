//
//  HsBaseViewController.m
//  nbhssppma_client
//
//  Created by chenjm on 14-4-9.
//  Copyright (c) 2014年 hundsun. All rights reserved.
//

#import "HsBaseViewController.h"
#import "UIKeyboardViewController.h"
#import "HsThemeManager.h"

NSString *const ViewControllerReloadView = @"ViewControllerReloadView";
NSString *const ViewControllerReLoginView = @"ViewControllerReLoginView";

@interface HsBaseViewController ()<UIKeyboardViewControllerDelegate>{
     UIKeyboardViewController *keyBoardController;
    BOOL _subViewReverseSort;
    BOOL _registerKeyBoardManager;
    BOOL _tapForDismissKeyboard;
}

@end

@implementation HsBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (IOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    //注册主题广播
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidLayoutWithTheme) name:ViewControllerReloadView object:nil];
    
    //注册登陆广播
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidLayoutWithLogin) name:ViewControllerReLoginView object:nil];
    
    
    //css样式
    if([self cssName] != nil){
        NIStylesheetCache* stylesheetCache =
        [(HsBaseAppDelegate *)[UIApplication sharedApplication].delegate stylesheetCache];
        NIStylesheet *stylesheet = [stylesheetCache stylesheetWithPath:[self cssName]];
        NIStylesheet *parentStylesheet = [stylesheetCache stylesheetWithPath:[NSString stringWithBundleNameForKey:@"parentThemeName"]];
        _dom = [NIDOM domWithStylesheet:stylesheet andParentStyles:parentStylesheet];
        
        [_dom registerView:self.view withCSSClass:@"background"];
    }
}

- (NSString *)cssName{
    return [HsThemeManager shareInstance].themeName;
}

//view 既 要出现 事件
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!self.isAppeared){//界面第一次显示后在执行
        //viewDidReload 通过调用sendChangeInTheme才会执行
        [self viewDidLayoutWithTheme];
        [self viewDidLayoutWithLogin];
    }
    
    if(self.registerKeyBoardManager){
        keyBoardController = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
        keyBoardController.subViewReverseSort = self.subViewReverseSort;
        [keyBoardController addToolbarToKeyboard];
    }
}

- (void)setRegisterKeyBoardManager:(BOOL)registerKeyBoardManager{
    _registerKeyBoardManager = registerKeyBoardManager;
    if(registerKeyBoardManager){
        keyBoardController = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
        keyBoardController.subViewReverseSort = self.subViewReverseSort;
        [keyBoardController addToolbarToKeyboard];
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //keyBoardController = nil;
}

/**
 ** baseViewController的公共方法 可对viewController统一设置、刷新
 **/
- (void)viewDidLayoutWithTheme{
        if([HsThemeManager shareInstance].themeName != nil){
            NIStylesheetCache* stylesheetCache =
            [(HsBaseAppDelegate *)[UIApplication sharedApplication].delegate stylesheetCache];
            NIStylesheet *stylesheet = [stylesheetCache stylesheetWithPath:[HsThemeManager shareInstance].themeName];
            [_dom updateStylesheet:stylesheet];
        }
        [_dom refresh];
    
      if([self hideShadowImage]){
           [self.navigationController.navigationBar setTranslucent:NO];
           NICSSRuleset *ruleset = [_dom rulesetforClass:@"UINavigationBar"];
           UIColor *barColor =   [ruleset colorFromCssRuleForKey:@"background-color"];
           if(IOS7){
             [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:barColor] forBarMetrics:UIBarMetricsDefault];
           }else{
              [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:barColor] forBarMetrics:UIBarMetricsDefault];
             [self.navigationController.navigationBar.layer setMasksToBounds:YES];
           }
          if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)]){
              [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:barColor size:CGSizeMake(self.view.frame.size.width, 3)]];
          }
      }
}

/**
 * 隐藏导航下分隔线
 **/
- (BOOL)hideShadowImage{
    return NO;
}



- (void)viewDidLayoutWithLogin{
    
}

#pragma mark function

//pushViewController Class

- (void)pushViewController:(id)viewController{
    [self pushViewController:viewController withParams:nil];
}

- (void)pushViewController:(id)viewController title:(NSString *)title{
    [self pushViewController:viewController title:title withParams:nil];
}
- (void)pushViewController:(id)viewController  withParams:(NSDictionary *)params{
    [self pushViewController:viewController title:nil withParams:params];
}
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)pushViewController:(id)viewController title:(NSString *)title withParams:(NSDictionary *)params{
    UIViewController *_viewController = nil;
    if([viewController isKindOfClass:[NSString class]]){
        _viewController = [[NSClassFromString(viewController) alloc] init];
    }else if([viewController isKindOfClass:[UIViewController class]]){
        _viewController = viewController;
    }else{
        _viewController = [[(Class)viewController alloc] init];
    }
    if(title != nil){
        _viewController.title = title;
    }
    for (NSString *key in params.keyEnumerator){
        [_viewController setValue:params[key] forKey:key];
    }
    [self.navigationController pushViewController:_viewController animated:YES];
}

- (void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    //清理样式
    [_dom unregisterAllViews];
    _dom = nil;
    //取消通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // NSLog([NSString stringWithFormat:@"%@ is dealloc",[NSString stringWithUTF8String:object_getClassName(self)]]);

}

@end

@implementation HsBaseViewController (keyboard)

- (void)setSubViewReverseSort:(BOOL)subViewReverseSort{
    _subViewReverseSort = subViewReverseSort;
}

- (BOOL)subViewReverseSort{
    return _subViewReverseSort;
}

- (void)setRegisterKeyBoardManager:(BOOL)registerKeyBoardManager{
    _registerKeyBoardManager = registerKeyBoardManager;
}
- (BOOL)registerKeyBoardManager{
    return _registerKeyBoardManager;
}




- (BOOL)tapForDismissKeyboard{
    return _tapForDismissKeyboard;
}
#pragma mark 增加点击空白区域取消键盘
// 隐藏方法的具体实现
- (void)setTapForDismissKeyboard:(BOOL)tapForDismissKeyboard
{
     _tapForDismissKeyboard = tapForDismissKeyboard;
    
    if(tapForDismissKeyboard){
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];    //创建一个通知
        // 添加单击手势
        UITapGestureRecognizer *singleTapGR =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(tapAnywhereToDismissKeyboard:)];    // 创建一个线程池
        NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
        // 通过通知用来监听键盘的的显示和隐藏
        [nc addObserverForName:UIKeyboardWillShowNotification
                        object:nil
                         queue:mainQuene
                    usingBlock:^(NSNotification *note){
                        [self.view addGestureRecognizer:singleTapGR];
                    }];
        [nc addObserverForName:UIKeyboardWillHideNotification
                        object:nil
                         queue:mainQuene
                    usingBlock:^(NSNotification *note){
                        [self.view removeGestureRecognizer:singleTapGR];
                    }];
    }else{
        [self.view removeGesture];
    }
}

// 点击任何地方都将隐藏键盘
- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer
{
    //[self becomeFirstResponder];
    // 此方法会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}

/**
 ** 关闭键盘
 **/
- (void)closeKeyBoard{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

@end
