//
//  HsZoomingScrollView.h
//
//  Created by Hs on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HsPhotoBrowser, HsPhoto, HsPhotoView;

@protocol HsPhotoViewDelegate <NSObject>
- (void)photoViewImageFinishLoad:(HsPhotoView *)photoView;
- (void)photoViewSingleTap:(HsPhotoView *)photoView;
- (void)photoViewDidEndZoom:(HsPhotoView *)photoView;
@end

@interface HsPhotoView : UIScrollView <UIScrollViewDelegate>

// 图片
@property (nonatomic, strong) HsPhoto *photo;
// 代理
@property (nonatomic, weak) id<HsPhotoViewDelegate> photoViewDelegate;
@end