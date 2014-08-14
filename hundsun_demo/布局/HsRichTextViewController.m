//
//  HsRichTextViewController.m
//  HsDefindViewDemo
//
//  Created by 123 on 14-7-3.
//  Copyright (c) 2014年 123. All rights reserved.
//

#import "HsRichTextViewController.h"
#import "HsRCLableScrollView.h"

@interface HsRichTextViewController ()

@property (weak,nonatomic) IBOutlet HsRCLableScrollView *rcLable;

@end

@implementation HsRichTextViewController

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
    self.rcLable.rtLableDelegate = self;
    NSString *text = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"richText" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    self.rcLable.textColor = [UIColor blackColor];
    self.rcLable.text = text;
    // Do any additional setup after loading the view from its nib.
}

- (void)rcLabel:(id)rcLabel didSelectLinkWithURL:(NSString*)url{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
