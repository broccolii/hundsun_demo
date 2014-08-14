//
//  Created by 王金东 on 14-7-3.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsLinearLayoutViewController.h"
#import "HsUILinearLayoutView.h"

@interface HsLinearLayoutViewController (){
    NSInteger i;
}
@property (strong,nonatomic) HsUILinearLayoutView *linearLayoutView;
@property (weak,nonatomic) IBOutlet UIView *secondView;
@end

@implementation HsLinearLayoutViewController

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
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"改变" target:self action:@selector(changeFrame)];
    self.linearLayoutView = (HsUILinearLayoutView *)self.view;
    
    NSArray *subView = self.linearLayoutView.subviews;
    //隐藏控件，则不会布局该控件
    //self.secondView.hidden = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)changeFrame{
    i++;
    CGFloat width = i*100;
    CGFloat height = i *100;
    if(i > 3){
        i = 0;
    }
    [UIView animateWithDuration:1.0f animations:^{
        CGRect frame = self.secondView.frame;
        frame.size.width = width;
        frame.size.height = height;
        self.secondView.frame = frame;
    } completion:^(BOOL finished){
    }];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
