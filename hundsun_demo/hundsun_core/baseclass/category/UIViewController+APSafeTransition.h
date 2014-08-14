//
//  UIViewController+APSafeTransition.h
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

#import <UIKit/UIKit.h>

@interface UIViewController (APSafeTransition)

//是否已经显示过
@property (nonatomic,assign) BOOL isAppeared;

@end


#pragma mark 刷新view


@interface UIViewController (refreshView)

/**
 ** 通知整个应用NavigationController中所有的viewcontroller主题刷新
 **/
+ (void)sendChangeInTheme;

/**
 ** 通知自己或自己中所有的viewcontroller主题刷新
 **/
- (void)sendChangeInTheme;


/**
 ** 通知整个应用NavigationController中所有的viewcontroller登陆状态改变
 **/
+ (void)sendChangeInLogin;

/**
 ** 通知自己或自己中所有的viewcontroller登陆状态改变
 **/
- (void)sendChangeInLogin;

@end
