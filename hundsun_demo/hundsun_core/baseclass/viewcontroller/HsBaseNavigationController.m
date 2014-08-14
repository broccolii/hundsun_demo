//
//  APBaseNavigationController.m
//
//  https://github.com/nexuspod/SafeTransition
//
//

#import "HsBaseNavigationController.h"
#import "HsThemeManager.h"

typedef void (^APTransitionBlock)(void);

@interface HsBaseNavigationController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate> {
    BOOL _transitionInProgress;//是否正在场景切换
    NSMutableArray *_peddingBlocks;//存放block
    CGFloat _systemVersion;//系统版本
}

@end

@implementation HsBaseNavigationController

#pragma mark - Creating Navigation Controllers

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];//做初始化
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _transitionInProgress = NO;
    _peddingBlocks = [NSMutableArray arrayWithCapacity:2];
    _systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
}

- (void)viewDidLoad

{
    [super viewDidLoad];
    
    //做手势委托
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate = self;
    }
    //注册刷新广播
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidLayoutWithTheme) name:ViewControllerReloadView object:nil];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    //css样式
    if([self cssName] != nil){
        NIStylesheetCache* stylesheetCache =
        [(HsBaseAppDelegate *)[UIApplication sharedApplication].delegate stylesheetCache];
        NIStylesheet* stylesheet = [stylesheetCache stylesheetWithPath:[self cssName]];
        _dom = [[NIDOM alloc] initWithStylesheet:stylesheet];
        
        [_dom registerView:self.navigationBar];
    }
}

- (NSString *)cssName{
    return [HsThemeManager shareInstance].themeName;
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
}

#pragma mark navigation delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {//界面少于2个或对显示的是rootcontroller（主要指显示首页）时，没有手势
        if (self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    return YES;
}


#pragma mark - Transition Manager

- (void)addTransitionBlock:(void (^)(void))block
{
    if (![self isTransitionInProgress]) {
        self.transitionInProgress = YES;
        block();
    }
    else {
        [_peddingBlocks addObject:[block copy]];
    }
}

- (BOOL)isTransitionInProgress
{
    return _transitionInProgress;
}

- (void)setTransitionInProgress:(BOOL)transitionInProgress
{
    _transitionInProgress = transitionInProgress;
    if (!transitionInProgress && _peddingBlocks.count > 0) {
        _transitionInProgress = YES;
        [self runNextTransition];
    }
}

- (void)runNextTransition
{
    APTransitionBlock block = _peddingBlocks.firstObject;
    [_peddingBlocks removeObject:block];
    block();
}

- (void)loadBackButton:(UIViewController *)viewController{
    UIColor *navigationItemTextColor = [UIColor whiteColor];
    UIImage *normalImage=[UIImage createArrowsImage:navigationItemTextColor direction:ArrowsDirectionLeft inSize:CGSizeMake(18, 22)];
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithImage:normalImage target:self action:@selector(popself)];
    backItem.tag = -1024;
    viewController.navigationItem.leftBarButtonItem = backItem;
}


#pragma mark - Pushing and Popping Stack Items

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        //当push进去了 隐藏底部菜单
        viewController.hidesBottomBarWhenPushed = YES;
        [self loadBackButton:viewController];
    }
    if (_systemVersion >= 8.0) {
        [super pushViewController:viewController animated:animated];
    }
    else {
        [self addTransitionBlock:^{
            //不用将改transitionInProgress，因为在viewController的viewDidAppear 会更改 （注：在UIViewController +APSafeTransition里面实现）
            [super pushViewController:viewController animated:animated];
        }];
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *poppedViewController = nil;
    if (_systemVersion >= 8.0) {
        poppedViewController = [super popViewControllerAnimated:animated];
    }
    else {
        __weak HsBaseNavigationController *weakSelf = self;
        [self addTransitionBlock:^{
            //pop动画执行完后更改transitionInProgress状态 标识没有场景动画了
            UIViewController *viewController = [super popViewControllerAnimated:animated];
            if (viewController == nil) {
                weakSelf.transitionInProgress = NO;
            }
        }];
    }
    return poppedViewController;
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray *poppedViewControllers = nil;
    if (_systemVersion >= 8.0) {
        poppedViewControllers = [super popToViewController:viewController animated:animated];
    }
    else {
        __weak HsBaseNavigationController *weakSelf = self;
        [self addTransitionBlock:^{
            //pop动画执行完后更改transitionInProgress状态 标识没有场景动画了
            if ([weakSelf.viewControllers containsObject:viewController]) {
                NSArray *viewControllers = [super popToViewController:viewController animated:animated];
                if (viewControllers.count == 0) {
                    weakSelf.transitionInProgress = NO;
                }
            }
            else {
                weakSelf.transitionInProgress = NO;
            }
        }];
    }
    return poppedViewControllers;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    NSArray *poppedViewControllers = nil;
    if (_systemVersion >= 8.0) {
        poppedViewControllers = [super popToRootViewControllerAnimated:animated];
    }
    else {
        __weak HsBaseNavigationController *weakSelf = self;
        [self addTransitionBlock:^{
            //pop动画执行完后更改transitionInProgress状态 标识没有场景动画了
            NSArray *viewControllers = [super popToRootViewControllerAnimated:animated];
            if (viewControllers.count == 0) {
                weakSelf.transitionInProgress = NO;
            }
        }];
    }
    return poppedViewControllers;
}

#pragma mark - Accessing Items on the Navigation Stack

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
    if (_systemVersion >= 8.0) {
        [super setViewControllers:viewControllers animated:animated];
    }
    else {
        __weak HsBaseNavigationController *weakSelf = self;
        [self addTransitionBlock:^{
            NSArray *originalViewControllers = weakSelf.viewControllers;
            // NSLog(@"%s", __FUNCTION__);
            [super setViewControllers:viewControllers animated:animated];
            //animated=NO 获取没有更改最后一个界面，则不用执行下一个场景动画
            if (!animated || originalViewControllers.lastObject == viewControllers.lastObject) {
                weakSelf.transitionInProgress = NO;//等于NO就是为了执行下一个场景动画
            }
        }];
    }
}

-(void)replaceLastViewController:(UIViewController*)withViewController animated:(BOOL)animated
{
    NSMutableArray * array=[NSMutableArray arrayWithArray:self.viewControllers];
    [array removeLastObject];
    [self loadBackButton:withViewController];
    [array addObject:withViewController];
    [self setViewControllers:array animated:animated];
}

-(void)popself
{
    [self popViewControllerAnimated:YES];
}


- (void)dealloc{
    [_dom unregisterAllViews];
    _dom = nil;
    //取消通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
