//
//  HsAccountViewController.m
//  hundsun_zjfae
//
//  Created by 王金东 on 14-7-30.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsAccountViewController.h"

@interface HsAccountViewController ()

@property (nonatomic,strong) UIView *headView;

@property (nonatomic,strong) UIView *footView;

@property (nonatomic,strong) UILabel *moneyLable;

@property (nonatomic,strong) UILabel *descLable;

@property (nonatomic,strong) NSDictionary *userInfo;

@end

@implementation HsAccountViewController

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
    //必须在super.viewDidLoad之前调用
    self.style = UITableViewStyleGrouped;
    //UITableViewStyleGrouped 默认开启分块
    //self.sectionable = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //默认隐藏
    self.tableView.hidden = YES;
    
    //开启下拉刷新
    self.refreshHeaderable = YES;
    
    //注册cell
    //self.tableViewCellClass = [HsBaseTableViewCellStyleValue1 class];
    self.tableViewCellStyle = UITableViewCellStyleValue1;
    
    //设置第一块的head高 可以给tableview距上留点空隙
    self.tableView.firstSectionHeaderHeight = DefaultFirstSectionHeaderHeight;
    
    //开启延迟取消选中状态功能
    self.tableView.clearsSelectionDelay = YES;
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
    
    
    if([HsUserConfig login]){
        [self setup];
    }else{
        //模拟网络
        [self.view showLoading];
        WEAKSELF
        GCD_AfterBlock(^{
            //设置注销按钮
            weakSelf.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"登陆" target:self action:@selector(login)];
            //显示出控件
            weakSelf.tableView.hidden = YES;
            [weakSelf.view showEmptyTitle:@"未登陆，请先登陆" clickBlock:^{
                //goto login
            }];
            
        }, 2.0f);
        
        
        //用下面的网络请求 在界面消失后网络也主动取消，不用做任何操作
        /*
        [self.view urlForTag:@"url" completionHandler:^(NSDictionary *dic){
        
        } errorHandler:^(NSError *error){
        
        }];
         */
        
        //用下面的网络请求不会在界面消失主动断开
        
        /**
         
        [[HsNetworkEngine netWorkEngine] urlForTag:@"" completionHandler:^(NSDictionary *dic){
        
        
        } errorHandler:^(NSError *error){
        
        }];
         **/
    }

    
}

//渲染视图
- (void)setup{
    //显示出控件
     self.tableView.hidden = NO;
    //设置消息按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"消息" target:self action:@selector(showMessage)];
    
    
    self.itemsArray = [NSMutableArray array];
    
    //第一块
    NSMutableDictionary *userInfoDic = [NSMutableDictionary title:@"财主" imageName:@"myaccount" detail:@"12989829282" selected:^(NSIndexPath *indexPath){
       
    }];
    NSArray *fisrtSectionArray = [NSArray arrayWithObject:userInfoDic];
    [self.itemsArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:fisrtSectionArray,self.keyOfItemArray, nil]];
    
    //第2块
    NSMutableDictionary *ziChangDic = [NSMutableDictionary title:@"总资产" detail:@"100,000.68" selected:^(NSIndexPath *indexPath){
       
    }];
    
    NSMutableDictionary *shouyiDic = [NSMutableDictionary title:@"总收益" detail:@"3,000.68" selected:^(NSIndexPath *indexPath){
       
    }];
    NSArray *secondSectionArray = [NSArray arrayWithObjects:ziChangDic,shouyiDic, nil];
    [self.itemsArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:secondSectionArray,self.keyOfItemArray, nil]];
    
    //第三块
    NSMutableDictionary *chiCangDic = [NSMutableDictionary title:@"我的持仓" selected:^(NSIndexPath *indexpath){
       
    }];
    NSMutableDictionary *weiTuoDic = [NSMutableDictionary title:@"我的委托" selected:^(NSIndexPath *indexpath){
        
    }];
    NSMutableDictionary *zjlsDic = [NSMutableDictionary title:@"资金流水" selected:^(NSIndexPath *indexpath){
       
    }];
    NSMutableDictionary *cjjlDic = [NSMutableDictionary title:@"成交记录" selected:^(NSIndexPath *indexpath){
      
    }];
    NSArray *thirdSectionArray = [NSArray arrayWithObjects:chiCangDic,weiTuoDic,zjlsDic,cjjlDic ,nil];
    [self.itemsArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:thirdSectionArray,self.keyOfItemArray, nil]];

    //刷新
    [self.tableView reloadData];
}

#pragma delegate
//设置行样式
- (void)baseTableView:(UITableView *)tableView cellStyleForRowAtIndexPath:(HsBaseTableViewCell *)cell{
}


#pragma mark 事件
//登陆
- (void)login{
   //goto login
}
//显示消息
- (void)showMessage{
}

//头视图
- (UIView *)headView{
    if(_headView == nil){
        _headView = [[UIView alloc] init];
        [self.dom registerView:_headView withCSSClass:@"accountHeadBackgournd"];
        
        [_headView  buildSubviews:@[self.descLable = [[UILabel alloc] init],@".accountHeadTipText", self.moneyLable = [[UILabel alloc] init],@".accountHeadText"] inDOM:self.dom];
        
        self.moneyLable.text = @"300.06";
    }
    return _headView;
}
//脚视图
- (UIView *)footView{
    if(_footView == nil){
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        _footView.backgroundColor = [UIColor clearColor];
        
        CGFloat buttonWidth = 100;
        CGFloat buttonHeight = 40;
        CGFloat xpadding = (_footView.frame.size.width-buttonWidth*2)/3;
        CGFloat ypadding = (_footView.frame.size.height - buttonHeight)/2;
        
        UIButton *firstButton = [UIButton buttonWithThemeTitle:@"出金" frame:CGRectMake(xpadding, ypadding, buttonWidth, buttonHeight) target:self action:@selector(outGold)];
        [_footView addSubview:firstButton];
        
         UIButton *secondButton = [UIButton buttonWithThemeTitle:@"入金" frame:CGRectMake(xpadding*2+buttonWidth, ypadding, buttonWidth, buttonHeight) target:self action:@selector(inGold)];
        [_footView addSubview:secondButton];
        
    }
    return _footView;
}
//出金
- (void)outGold{
   }
//入金
- (void)inGold{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
