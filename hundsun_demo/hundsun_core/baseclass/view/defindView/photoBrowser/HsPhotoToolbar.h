//
//  HsPhotoToolbar.h
//  FingerNews
//
//  Created by Hs on 13-9-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HsPhotoToolbarDelegate <NSObject>

-(void)DeleteThisImage:(NSInteger)ThisImageIndex;

@end

@interface HsPhotoToolbar : UIView
{
    
}
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

@property (nonatomic, retain) NSString * DeleteImage;

@property (nonatomic, assign) id<HsPhotoToolbarDelegate>Delegate;

@end
