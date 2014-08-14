//
//  HsFoundation.h
//  hospitalcloud
//
//  Created by wjd on 14-5-12.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**************************************************************/
// 单例模式  给类自动加入单例
#undef	HEAD_SINGLETON
#define HEAD_SINGLETON( __class ) \
+ (__class *)sharedInstance;
//+ (void) purgeSharedInstance;

#undef	IMP_SINGLETON
#define IMP_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

/**************************************************************/

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 ? YES : NO)
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

// iPad
#define kIsiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define NAV_HEIGHT (float)(IOS7?64:44)
#define STATUS_VIEW_HEIGHT (float)(IOS7?20:0)

#define HUNDSUN_DEBUG 1//0表示发布模式  1表示debug模式

#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;


//Image
//可拉伸的图片

#define ResizableImage(name,top,left,bottom,right) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right)]
#define ResizableImageWithMode(name,top,left,bottom,right,mode) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right) resizingMode:mode]

/**************************************************************/
//file
//读取文件的文本内容,默认编码为UTF-8
#define FileString(name,ext)            [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(name) ofType:(ext)] encoding:NSUTF8StringEncoding error:nil]
#define FileDictionary(name,ext)        [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(name) ofType:(ext)]]
#define FileArray(name,ext)             [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(name) ofType:(ext)]]


/**************************************************************/
//弹出信息
#define ALERT(msg) [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]


/**************************************************************/
//转换
#define I2S(number) [NSString stringWithFormat:@"%d",number]
#define F2S(number) [NSString stringWithFormat:@"%f",number]
#define DATE(stamp) [NSDate dateWithTimeIntervalSince1970:[stamp intValue]];


/**************************************************************/
// GCD 多线程
#define GCD_MainFun(aFun) dispatch_async( dispatch_get_main_queue(), ^(void){aFun;} );
#define GCD_MainBlock(block) dispatch_async( dispatch_get_main_queue(), block );

#define GCD_BackGroundBlock(block) dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block );
#define GCD_BackGroundFun(aFun) dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){aFun;} );

#define GCD_OnceBlock(block) {static dispatch_once_t once;dispatch_once( &once, block);}

#define GCD_AfterBlock(block,delayInSeconds)  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
#define GCD_AfterFun(aFun,delayInSeconds) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){aFun;});


//  主要单例
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define SharedApplication                   [UIApplication sharedApplication]
#define Bundle                              [NSBundle mainBundle]
#define MainScreen                          [UIScreen mainScreen]

#define defaultFaceImage [UIImage imageNamed:@"noface.png"]
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height    // 获取屏幕的高度
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width      // 获取屏幕的宽度

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)    // 判断是否是iPhone5屏幕

//color
#define RGB(r, g, b)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define UIColorHex16(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//计算view得右边或底部距原点的距离
#define VIEW_BX(view) (view.frame.origin.x + view.frame.size.width)
#define VIEW_BY(view) (view.frame.origin.y + view.frame.size.height)

#ifndef __OPTIMIZE__
#if HUNDSUN_DEBUG==1
//#define NSLog(...) {NSLog(@"\n%s %d",__func__,__LINE__); NSLog(__VA_ARGS__);}
#define NSLog(...) {NSLog(__VA_ARGS__);}
#else
#define NSLog(...) {}
#endif
#else
#define NSLog(...) {}
#endif

