//
//  HsViewController.m
//  HsDefindViewDemo
//
//  Created by 123 on 14-7-3.
//  Copyright (c) 2014年 123. All rights reserved.
//

#import "HsLabelViewController.h"
#import "HsUILabel.h"

@interface HsLabelViewController ()

@end

@implementation HsLabelViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //自定义的lable
    
    HsUILable *lable1 = [[HsUILable alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    lable1.backgroundColor = [UIColor redColor];
    lable1.text = [self textInfo:@"左上角"];
    lable1.numberOfLines = 0;
    lable1.font = [UIFont systemFontOfSize:12.0f];
    lable1.verticalAlignment = HsVerticalAlignmentTop;
    lable1.textColor = [UIColor whiteColor];
    [self.view addSubview:lable1 alignment:HsViewAlignmentLeft];
    
    HsUILable *lable2 = [[HsUILable alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    lable2.backgroundColor = [UIColor redColor];
    lable2.text = [self textInfo:@"右上角"];
    lable2.font = [UIFont systemFontOfSize:12.0f];
    lable2.numberOfLines = 0;
    lable2.verticalAlignment = HsVerticalAlignmentRight;
    lable2.textColor = [UIColor whiteColor];
    [self.view addSubview:lable2 alignment:HsViewAlignmentRight];
    
    HsUILable *lable3 = [[HsUILable alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    lable3.backgroundColor = [UIColor redColor];
    lable3.text = [self textInfo:@"左下角"];
    lable3.font = [UIFont systemFontOfSize:12.0f];
    lable3.verticalAlignment = HsVerticalAlignmentBottom;
    lable3.numberOfLines = 0;
    lable3.textColor = [UIColor whiteColor];
    lable3.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:lable3 alignment:HsViewAlignmentBottom];
    
    
    HsUILable *lable4 = [[HsUILable alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    lable4.backgroundColor = [UIColor redColor];
    lable4.text = [self textInfo:@"右下角"];
    lable4.font = [UIFont systemFontOfSize:12.0f];
    lable4.textColor = [UIColor whiteColor];
    lable4.numberOfLines = 0;
    lable4.verticalAlignment = HsVerticalAlignmentRight|HsViewAlignmentBottom;
    lable4.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:lable4 alignment:HsViewAlignmentRight|HsViewAlignmentBottom];
    
    
    HsUILable *lable5 = [[HsUILable alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    lable5.backgroundColor = [UIColor redColor];
    lable5.text = [self textInfo:@"正中央"];
    lable5.font = [UIFont systemFontOfSize:12.0f];
    lable5.verticalAlignment = HsVerticalAlignmentMiddle;
    lable5.textColor = [UIColor whiteColor];
    lable5.numberOfLines = 0;
    lable5.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:lable5 alignment:HsViewAlignmentCenter];
    
    
    HsUILable *lable6 = [[HsUILable alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    lable6.backgroundColor = [UIColor redColor];
    lable6.text = [self textInfo:@"右中央"];
    lable6.font = [UIFont systemFontOfSize:12.0f];
    lable6.textColor = [UIColor whiteColor];
    lable6.numberOfLines = 0;
    lable6.verticalAlignment = HsVerticalAlignmentMiddle|HsViewAlignmentRight;
    lable6.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:lable6 alignment:HsViewAlignmentRight|HsViewAlignmentCenter];
    
    
    HsUILable *lable7 = [[HsUILable alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    lable7.backgroundColor = [UIColor redColor];
    lable7.text = [self textInfo:@"左中央"];
    lable7.font = [UIFont systemFontOfSize:12.0f];
    lable7.textColor = [UIColor whiteColor];
    lable7.numberOfLines = 0;
    lable7.verticalAlignment = HsVerticalAlignmentMiddle|HsViewAlignmentLeft;
    lable7.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:lable7 alignment:HsViewAlignmentLeft|HsViewAlignmentCenter];
    
    
    HsUILable *lable8 = [[HsUILable alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    lable8.backgroundColor = [UIColor redColor];
    lable8.text = [self textInfo:@"下中央"];
    lable8.font = [UIFont systemFontOfSize:12.0f];
    lable8.textColor = [UIColor whiteColor];
    lable8.numberOfLines = 0;
    lable8.verticalAlignment = HsVerticalAlignmentBottom|HsViewAlignmentBottom;
    lable8.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:lable8 alignment:HsViewAlignmentBottom|HsViewAlignmentCenter];
    
    HsUILable *lable9 = [[HsUILable alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    lable9.backgroundColor = [UIColor redColor];
    lable9.text = [self textInfo:@"上中央"];
    lable9.verticalAlignment = HsViewAlignmentTop|HsVerticalAlignmentMiddle;
    lable9.font = [UIFont systemFontOfSize:12.0f];
    lable9.textColor = [UIColor whiteColor];
    lable9.numberOfLines = 0;
    [self.view addSubview:lable9 alignment:HsViewAlignmentTop|HsViewAlignmentCenter];
    
    // Do any additional setup after loading the view.
}

- (NSString *)textInfo:(NSString *)text{
    return [NSString stringWithFormat:@"我在父亲的%@，当然也在自己的%@",text,text];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
