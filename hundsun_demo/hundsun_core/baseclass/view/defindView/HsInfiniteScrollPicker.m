// 
//  Created by wjd on 14-1-7.
//
//

#import "HsInfiniteScrollPicker.h"
@implementation HsInfiniteScrollPicker{
    CGFloat lastPage;
    int _oldIndex;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setup];
    }
    return self;
}
-(void)setup{
    self.pagingEnabled = YES;
    self.scrollEnabled = YES;
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor clearColor];
}

-(void)build{
    NSMutableArray * tempImageArray = [[NSMutableArray alloc]init];
    
    
    [tempImageArray addObject:[self.pics objectAtIndex:self.pics.count-2]];
    [tempImageArray addObject:[self.pics lastObject]];
    for (id obj in self.pics) {
        [tempImageArray addObject:obj];
    }
    [tempImageArray addObject:[self.pics objectAtIndex:0]];
    [tempImageArray addObject:[self.pics objectAtIndex:1]];
    self.pics = Nil;
    self.pics = tempImageArray;
    
    int i = 0;
    for (id obj in self.pics) {
        
        UIButton *pic = [UIButton buttonWithType:UIButtonTypeCustom];
        pic.imageView.contentMode = UIViewContentModeTop;
        [pic setFrame:CGRectMake(i*(self.frame.size.width)+10,10, self.frame.size.width-20, self.frame.size.height-20)];
        //圆形
        [pic rounded];
        
        UIImageView * tempImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, pic.frame.size.width, pic.frame.size.height)];
        tempImage.contentMode = UIViewContentModeScaleAspectFill;
        [tempImage setClipsToBounds:YES];
        [tempImage setImage:obj];
        tempImage.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [pic addSubview:tempImage];
        [pic setBackgroundColor:[UIColor grayColor]];
        pic.tag = i;
        [pic addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pic];
        
        pic.tag = i+1;
        i ++;
    }
    [self setContentSize:CGSizeMake(self.frame.size.width*[self.pics count], self.frame.size.height)];
    //默认选中第一个
    self.selectedIndex = 0;
}
-(void)click:(id)sender{
    if(_pickerDelegate && [_pickerDelegate respondsToSelector:@selector(didClick:)]){
        [_pickerDelegate didClick:[sender tag]-2-1];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    if(selectedIndex < self.pics.count-4){
        _selectedIndex = selectedIndex;
        [self setContentOffset:CGPointMake(self.frame.size.width*(selectedIndex+2), 0) animated:YES];
        //上来放大第1个位置
        [self resume:selectedIndex+2];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width=self.frame.size.width;
    
    //便于计算页数
    int  _newIndex = scrollView.contentOffset.x/self.frame.size.width;
   // NSLog(@"scrollView before:%d",_newIndex);
    //造成循环滚动假象
    if (_newIndex <= 1) {
        //滑到最左边 当位置小于1时，回到倒数第3个位置
        [self setContentOffset:CGPointMake(width*([self.pics count]-3), 0) animated:NO];
        _selectedIndex = scrollView.contentOffset.x/width-2;
    }else if (_newIndex >= [self.pics count]-2) {
        //滑动到最右边 当位置滑到倒数第2个位置，跳到第2个位置
        [self setContentOffset:CGPointMake(width*2, 0) animated:NO];
        _selectedIndex = 0;
    }else{
        _selectedIndex = scrollView.contentOffset.x/width - 2;
    }
    
    if(_pickerDelegate && [_pickerDelegate respondsToSelector:@selector(currentPage:total:)]){
         [_pickerDelegate currentPage:_selectedIndex total:[self.pics count]-4];
    }
    
    int index = scrollView.contentOffset.x/width;
    _oldIndex = index;
    //NSLog(@"scrollView after:%d  currentPage:%d",_oldIndex,currentPage);
    [self resume:_oldIndex];
}



- (void)resume:(int)currentIndex{
    if (lastPage == self.pics.count-3 && currentIndex == 2) {
        //处理左滑后，视图做切换时一闪的bug
        //只有滑动到最右边时出现
        //处理上一次的视图
        UIView *preView = [self viewWithTag:currentIndex-1+1];
        [UIView beginAnimations:@"imageViewBig" context:nil];
        [UIView setAnimationDuration:0.5];
        [preView setTransform:CGAffineTransformMakeScale(1.3,1.3)];
        preView.alpha = 1.0;
        [UIView commitAnimations];
    }else if(lastPage == 2 && currentIndex == self.pics.count-3){
        //处理右滑后，视图在做切换时一闪的bug
        //只有滑动到最左边出现bug
        //处理上一次的视图
        UIView *preView = [self viewWithTag:self.pics.count-2+1];
        [UIView beginAnimations:@"imageViewBig" context:nil];
        [UIView setAnimationDuration:0.5];
        [preView setTransform:CGAffineTransformMakeScale(1.3,1.3)];
        preView.alpha = 1.0;
        [UIView commitAnimations];
    }
    
    lastPage = currentIndex;
    
    // NSLog(@"index:%d",currentIndex);
    for (NSInteger i = 0; i < self.pics.count; i++) {
        UIView *currentView = [self viewWithTag:i+1];
        CGFloat xscale = 1.0f;
        CGFloat yscale = 1.0f;
        CGFloat alpha = 1.0f;
        if(i == currentIndex){
            xscale = 1.3f;
            yscale = 1.3f;
        }else{
            xscale = 0.8f;
            yscale = 0.8f;
            alpha = 0.3f;
        }
        [UIView beginAnimations:@"imageViewBig" context:nil];
        [UIView setAnimationDuration:0.5f];
        CGAffineTransform newTransform =  CGAffineTransformMakeScale(xscale,yscale);
        [currentView setTransform:newTransform];
        currentView.alpha = alpha;
        [UIView commitAnimations];
    }
}

@end
