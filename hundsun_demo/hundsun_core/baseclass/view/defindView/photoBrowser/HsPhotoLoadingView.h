//
//  HsPhotoLoadingView.h
//
//  Created by Hs on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMinProgress 0.0001

@class HsPhotoBrowser;
@class HsPhoto;

@interface HsPhotoLoadingView : UIView
@property (nonatomic) float progress;

- (void)showLoading;
- (void)showFailure;
@end