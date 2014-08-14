//
//  InfiniteScrollPicker.h
//  InfiniteScrollPickerExample
//
//  Created by wjd.
//  Copyright (c) wjd. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HsInfiniteScrollPickerDelegate<NSObject>

- (void)didClick:(NSInteger)page;

- (void)currentPage:(int)page total:(NSUInteger)total;

@end


@interface HsInfiniteScrollPicker : UIScrollView<UIScrollViewDelegate>
{
    CGSize imageSize;
    UIImage *image;
}

@property(nonatomic,strong)NSArray * pics;

//索引
@property (nonatomic,assign) NSInteger selectedIndex;

@property(nonatomic,retain)id<HsInfiniteScrollPickerDelegate> pickerDelegate;

-(void)build;

@end
