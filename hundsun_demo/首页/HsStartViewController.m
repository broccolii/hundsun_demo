//
//  HsStartViewController.m
//  hospitalcloud_sdzy
//
//  Created by 123 on 14-6-13.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "HsStartViewController.h"
#import "HsInfiniteScrollPicker.h"
#import "HsRadioGroup.h"

#define hideStartViewKey @"hideStartView"

@interface HsStartViewController ()<HsInfiniteScrollPickerDelegate>{
    HsRadioGroup *radioGroup;
}

@end

@implementation HsStartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView{
    [super loadView];
    
    //设置背景
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"start01"]];
    backgroundImageView.frame = CGRectMake(50, 80, self.view.frameWidth-100, 30);
    [self.view addSubview:backgroundImageView];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]]];
    }
    
    
    HsInfiniteScrollPicker *picker = [[HsInfiniteScrollPicker alloc] initWithFrame:CGRectMake((self.view.frame.size.width-210)/2, 160, 210, 210)];
    //加入数据
    picker.backgroundColor = [UIColor clearColor];
    picker.pics = images;
    picker.pickerDelegate = self;
    picker.clipsToBounds = NO;
    [self.view addSubview:picker];
    //创建
    [picker build];
    
    NSArray *items = @[
                       [[HsRadioGroupItem alloc] initWithTitle:@"产品列表" selectedImage:[UIImage imageNamed:@"index_km_grey"] unselectedImage:[UIImage imageNamed:@"index_km_grey"]],[[HsRadioGroupItem alloc] initWithTitle:@"转让专区" selectedImage:[UIImage imageNamed:@"index_km_grey"] unselectedImage:[UIImage imageNamed:@"index_km_grey"]],[[HsRadioGroupItem alloc] initWithTitle:@"我的账户" selectedImage:[UIImage imageNamed:@"index_km_grey"] unselectedImage:[UIImage imageNamed:@"index_km_grey"]],[[HsRadioGroupItem alloc] initWithTitle:@"更多" selectedImage:[UIImage imageNamed:@"index_km_grey"] unselectedImage:[UIImage imageNamed:@"index_km_grey"]]];
    
    radioGroup = [[HsRadioGroup alloc] initWithFrame:CGRectMake(20, self.view.frameHeight-90, self.view.frameWidth-40, 50) items:items];
    radioGroup.padding = 10;
    radioGroup.selectedIndex = 0;
    radioGroup.scrollEnabled = NO;
    radioGroup.unSelectColor = [UIColor blackColor];
    radioGroup.selectColor = [UIColor redColor];
    radioGroup.selectedBlock = ^(NSInteger index){
        
        picker.selectedIndex = index;
    
    };
    [self.view addSubview:radioGroup];
    
  
}

- (void)exitView{
//    if(self.viewFinishedBlock != nil){
//        self.viewFinishedBlock(radioGroup.selectedIndex);
//    }else{
//        UIWindow* window = [UIApplication sharedApplication].delegate.window;
//        window.rootViewController = self.rootViewController;
//    }
}


#pragma mark HsInfiniteScrollPickerDelegate
- (void)didClick:(NSInteger)page{
    [self exitView];
}

- (void)currentPage:(int)page total:(NSUInteger)total{
    radioGroup.selectedIndex = page;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
