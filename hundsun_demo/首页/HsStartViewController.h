//
//  HsStartViewController.h
//  hospitalcloud_sdzy
//
//  Created by 123 on 14-6-13.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "HsBaseViewController.h"

typedef void(^ViewFinishedBlock) (NSInteger selectedIndex);

@interface HsStartViewController : HsBaseViewController

@property (nonatomic,strong) NSArray *imageArray;

@property (nonatomic,strong) UIViewController *rootViewController;
@property (nonatomic,copy) ViewFinishedBlock viewFinishedBlock;

@end
