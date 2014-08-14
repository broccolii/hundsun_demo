
#import "UIScrollView+HsRefresh.h"

/**
 Hs友情提示：
 1. 添加头部控件的方法
 [self.scrollView addHeaderWithTarget:self action:@selector(headerRereshing)];
 或者
 [self.scrollView addHeaderWithCallback:^{ }];
 
 2. 添加尾部控件的方法
 [self.scrollView addFooterWithTarget:self action:@selector(footerRereshing)];
 或者
 [self.scrollView addFooterWithCallback:^{ }];
 
 3. 可以在HsRefreshConst.h和HsRefreshConst.m文件中自定义显示的文字内容和文字颜色
 
 4. 本框架兼容iOS6\iOS7，iPhone\iPad横竖屏
 
 5.自动进入刷新状态
 1> [self.scrollView headerBeginRefreshing];
 2> [self.scrollView footerBeginRefreshing];
 
 6.结束刷新
 1> [self.scrollView headerEndRefreshing];
 2> [self.scrollView footerEndRefreshing];
 */