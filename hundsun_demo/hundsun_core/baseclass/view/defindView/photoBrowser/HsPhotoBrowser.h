//
//  HsPhotoBrowser.h
//
//  Created by Hs on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <UIKit/UIKit.h>
#import "HsPhoto.h"

@protocol HsPhotoBrowserDelegate;

@interface HsPhotoBrowser : UIViewController <UIScrollViewDelegate>
// 代理
@property (nonatomic, weak) id<HsPhotoBrowserDelegate> delegate;
// 所有的图片对象
@property (nonatomic, strong) NSMutableArray * photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

// 显示
- (void)show;
@end

@protocol HsPhotoBrowserDelegate <NSObject>

-(void)CellPhotoImageReload;

-(void)NewPostImageReload:(NSInteger)ImageIndex;

@optional
// 切换到某一页图片
- (void)photoBrowser:(HsPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index;
@end