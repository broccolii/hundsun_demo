//
//  HsRefreshConst.h
//  HsRefresh
//
//  Created by Hs on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#ifdef DEBUG
#define HsLog(...) NSLog(__VA_ARGS__)
#else
#define HsLog(...)
#endif

#define HsColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 文字颜色
#define HsRefreshLabelTextColor HsColor(150, 150, 150)

extern const CGFloat HsRefreshViewHeight;
extern const CGFloat HsRefreshFastAnimationDuration;
extern const CGFloat HsRefreshSlowAnimationDuration;

extern NSString *const HsRefreshBundleName;
#define HsRefreshSrcName(file) [HsRefreshBundleName stringByAppendingPathComponent:file]

extern NSString *const HsRefreshFooterPullToRefresh;
extern NSString *const HsRefreshFooterReleaseToRefresh;
extern NSString *const HsRefreshFooterRefreshing;

extern NSString *const HsRefreshHeaderPullToRefresh;
extern NSString *const HsRefreshHeaderReleaseToRefresh;
extern NSString *const HsRefreshHeaderRefreshing;
extern NSString *const HsRefreshHeaderTimeKey;

extern NSString *const HsRefreshContentOffset;
extern NSString *const HsRefreshContentSize;