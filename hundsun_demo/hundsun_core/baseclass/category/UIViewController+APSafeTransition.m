//
//  UIViewController+APSafeTransition.m
//
//  https://github.com/nexuspod/SafeTransition
//
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 WenBi
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "UIViewController+APSafeTransition.h"
#import "HsBaseNavigationController.h"
#import <objc/runtime.h>

static const void *ViewControllerIsAppeared = &ViewControllerIsAppeared;

@implementation UIViewController (APSafeTransition)

+ (void)load
{
    Method m1;
    Method m2;

    m1 = class_getInstanceMethod(self, @selector(sofaViewDidAppear:));
    m2 = class_getInstanceMethod(self, @selector(viewDidAppear:));
    method_exchangeImplementations(m1, m2);
}


- (void)sofaViewDidAppear:(BOOL)animated
{
    if([self.navigationController isKindOfClass:[HsBaseNavigationController class]]){
        self.navigationController.transitionInProgress = NO;
    }
    self.isAppeared = YES;
    [self sofaViewDidAppear:animated];
}

//给viewcontroller增加是否显示标示
- (void)setIsAppeared:(BOOL)isAppeared{
    objc_setAssociatedObject(self, ViewControllerIsAppeared, [NSNumber numberWithBool:isAppeared], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isAppeared{
    NSNumber *appeared = objc_getAssociatedObject(self, ViewControllerIsAppeared);
    return [appeared boolValue];
}

@end

#pragma mark 刷新view

@implementation UIViewController (refreshView)

//通知自己刷新
- (void)sendChangeInTheme{
    if ([self isKindOfClass:[HsBaseViewController class]]) {
        [(HsBaseViewController *)self viewDidLayoutWithTheme];
    }else if([self isKindOfClass:[HsBaseNavigationController class]]){
        NSArray *viewsArray = ((HsBaseNavigationController*)self).viewControllers;
        for (UIViewController *viewController in viewsArray) {
            if([viewController isKindOfClass:[HsBaseViewController class]]){
                [((HsBaseViewController *)viewController) viewDidLayoutWithTheme];
            }
        }
    }
}

/**
 ** 通知整个应用NavigationController中所有的viewcontroller刷新
 **/
+ (void)sendChangeInTheme{
    [[NSNotificationCenter defaultCenter] postNotificationName:ViewControllerReloadView object:nil];
}

//通知自己刷新
- (void)sendChangeInLogin{
    if ([self isKindOfClass:[HsBaseViewController class]]) {
        [(HsBaseViewController *)self viewDidLayoutWithLogin];
    }else if([self isKindOfClass:[HsBaseNavigationController class]]){
        NSArray *viewsArray = ((HsBaseNavigationController*)self).viewControllers;
        for (UIViewController *viewController in viewsArray) {
            if([viewController isKindOfClass:[HsBaseViewController class]]){
                [((HsBaseViewController *)viewController) viewDidLayoutWithLogin];
            }
        }
    }
}

/**
 ** 通知整个应用NavigationController中所有的viewcontroller刷新
 **/
+ (void)sendChangeInLogin{
    [[NSNotificationCenter defaultCenter] postNotificationName:ViewControllerReLoginView object:nil];
}

@end
