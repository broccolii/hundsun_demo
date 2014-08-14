//
//  HsSegmentViewController.m
//  HsDefindViewDemo
//
//  Created by 123 on 14-7-3.
//  Copyright (c) 2014年 123. All rights reserved.
//

#import "HsSegmentViewController.h"
#import "HsUISegment.h"
#import "HsBaseTableView.h"


@interface HsSegmentViewController ()<HsUISegmentDataSource>

@end

@implementation HsSegmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    HsUISegment *segment = [[HsUISegment alloc] initWithFrame:self.view.bounds];
    segment.dataSource = self;
    segment.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:segment];

    // Do any additional setup after loading the view.
}

#pragma mark -----菜单delegate
- (NSInteger)numberOfItemsInSegment:(HsUISegment *)sgm
{
    return 10;
}
- (CGFloat)widthForEachItemInsegmentControl:(HsUISegment*)sgmCtrl index:(NSInteger)index
{
    return 100;
}
- (NSString*)segmentControl:(HsUISegment *)sgmCtrl titleForItemAtIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"第 %ld 个table",(index+1)];
}

//对应索引项得视图是什么
- (UIView*)segmentContent:(HsUISegment*)sgmContent viewForItemAtIndex:(NSInteger)index{
    HsBaseTableView *keshiView = [[HsBaseTableView alloc] initWithFrame:sgmContent.bounds];
    keshiView.itemsArray = [NSMutableArray arrayWithObjects:@"第一行",@"第二行", nil];
    if(index % 3 ==0){
        keshiView.refreshHeaderable = YES;
        keshiView.refreshFooterable = YES;
    }else if(index % 3 == 1){
       keshiView.refreshHeaderable = YES;
    }else if (index % 3 == 2){
       keshiView.refreshFooterable = YES;
    }
    keshiView.backgroundColor = [UIColor whiteColor];
    return keshiView;
}

@end
