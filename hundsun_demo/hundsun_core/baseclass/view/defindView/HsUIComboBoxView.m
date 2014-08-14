//
//  UIComboBoxView.m
//  GTT_IOS
//
//  Created by allen.huang on 13-3-8.
//  Copyright (c) 2013年 wjd. All rights reserved.
//

#import "HsUIComboBoxView.h"


typedef NS_ENUM(NSInteger,ComboBoxArrowsDirection){
    ComboBoxArrowsDirectionUp,//三角朝上
    ComboBoxArrowsDirectionDown,//三角朝下
    ComboBoxArrowsDirectionLeft,//三角朝左
    ComboBoxArrowsDirectionRight,//三角朝右
};

@interface HsUIComboBoxView(){
     BOOL isEditing;//是否正在编辑
}

@property (nonatomic,retain) UIView *willShowInView;
@property (nonatomic, retain) UIActionSheet *action;
@property (nonatomic, retain) UIPickerView *picker;

@end

@implementation HsUIComboBoxView
@synthesize items;
@synthesize picker;
@synthesize action;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.textColor = [UIColor blackColor];
        self.items = [NSMutableArray array];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.textColor = [UIColor blackColor];
        self.items = [NSMutableArray array];
    }
    return self;
}

- (void)didMoveToWindow
{
    UIWindow *appWindow = [self window];
    if (appWindow != nil)
    {
        [self initWithCompontes];
    }
}

- (void)initWithCompontes
{
    if (action != nil)
    {
        return;
    }
    action = [[UIActionSheet alloc] initWithTitle:@""
                                         delegate:nil
                                cancelButtonTitle:nil
                           destructiveButtonTitle:nil
                                otherButtonTitles:nil];
    if(IOS7){
        action.backgroundColor = [UIColor whiteColor];
    }
    // 创建PickView
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, 44.0, 0.0, 0.0)];
    picker.showsSelectionIndicator = YES;
    picker.delegate = self;
    picker.dataSource = self;
    
    //顶部工具条
    UIToolbar *pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.window.frame.size.width, 44.0)];
    if(IOS7){
        pickerToolBar.barStyle = UIBarStyleDefault;
    }else{
        pickerToolBar.barStyle = UIBarStyleBlackOpaque;
    }
    [pickerToolBar sizeToFit];  //自适应框架的大小
    
    //定义两个按钮
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *btnFlexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:btnFlexibleSpace];
    
    //设置取消按钮
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(doCancelClick)];
    [barItems addObject:btnCancel];
    
    //设置确定按钮
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(doDoneClick)];
    [barItems addObject:btnDone];
    
    //往pickerToolBar上面添加按钮
    [pickerToolBar setItems:barItems];
    
    //往action添加toolBar和按钮
    [action addSubview:pickerToolBar];
    [action addSubview:picker];
}
- (void)reloadData{
    [picker reloadAllComponents];
    if(self.defaultValue){
        NSString *text = [self pickerView:picker  titleForRow:0 forComponent:0];
        self.text = text;
    }
}
// 取消
- (void)doCancelClick
{
    [action dismissWithClickedButtonIndex:0 animated:YES];
}

// 确定
- (void)doDoneClick
{
    [action dismissWithClickedButtonIndex:1 animated:YES];
    self.currentRow = [picker selectedRowInComponent:0];
    //设置输入框内容
    [self setText:[items objectAtIndex:self.currentRow]];
    if(self.delegate && [self.delegate respondsToSelector:@selector(comboBoxView:textChanged:)]){
        [self.delegate performSelector:@selector(comboBoxView:textChanged:) withObject:self withObject:self.text];
    }
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(comboBoxView:didSelectedForRow:forComponent:)]){
        [self.dataSource comboBoxView:self didSelectedForRow:[picker selectedRowInComponent:0] forComponent:0];
    }
}

// 点击文本框时是否开启响应
- (BOOL)canBecomeFirstResponder
{
    [super canBecomeFirstResponder];
    
    return YES;
}

// 触发第一响应
- (BOOL)becomeFirstResponder
{
    if (action == nil)
    {
        [self initWithCompontes];
    }
    else
    {
        if(self.willShowInView == nil){
            UIWindow *appWindow = [self window];
            [action showInView:appWindow];
        }else{
            [action showInView:self.willShowInView];
        }
        [action setBounds:CGRectMake(0.0f, 0.0f, self.window.frame.size.width, 500.0)];
        [self reloadData];
        //如果输入框有内容
        if (self.text.length > 0 && [self.text isEqualToString:@"请选择"] == NO)
        {
            NSInteger row = [items indexOfObject:self.text];
            if(row == NSNotFound){
                row = 0;
            }
            //将横条定位到当前选项
            [picker selectRow:row inComponent:0 animated:NO];
        }
    }
    
    return  YES;
}

- (void)showInView:(UIView *)view{
    if (action == nil){
        [self initWithCompontes];
    }
    self.willShowInView = view;
    [self becomeFirstResponder];
}
// 在文本框的后面加上图片
- (void)didMoveToSuperview
{

}

////////////////// 自定义ComboBoxView的delegate协议 ////////////////
// 选择一个区域
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfUIComboBoxView:)]){
        return [self.dataSource numberOfUIComboBoxView:self];
    }else{
        return 1;
    }
}

// 显示所有的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(comboBoxView:numberOfRowsInComponent:)]){
        return [self.dataSource comboBoxView:self numberOfRowsInComponent:component];
    }else{
        return [items count];
    }
}

// 显示选择某一行时的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(comboBoxView:titleForRow:forComponent:)]){
        NSString *title = [self.dataSource comboBoxView:self titleForRow:row forComponent:component];
        if([self.items isKindOfClass:[NSMutableArray class]]){
            ((NSMutableArray *)self.items)[row] = title;
        }
        return  title;
    }else{
        return [items objectAtIndex:row];
    }
}




#pragma mark UIActionSheet delegate

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet{
    isEditing = YES;
    [self setNeedsDisplay];
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    isEditing = NO;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if(self.bordColor != nil){
        self.layer.borderColor = self.bordColor.CGColor;
        self.layer.borderWidth = 1.0f;
    }
    if(self.arrowColor != nil){
        
        UIImageView *arrowImageView = (UIImageView *)[self viewWithTag:1000];
        if(arrowImageView == nil){
            arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-20, (self.frame.size.height-15)/2, 18, 15)];
            arrowImageView.tag = 1000;
        }
        ComboBoxArrowsDirection _direction = ComboBoxArrowsDirectionDown;
        if(isEditing){
            _direction =  ComboBoxArrowsDirectionUp;
        }
        arrowImageView.image = [self createArrowsImage:self.arrowColor direction:_direction inSize:CGSizeMake(15, 15)];
        [self addSubview:arrowImageView];
    }
}

- (UIImage *)createArrowsImage:(UIColor *)color direction:(ComboBoxArrowsDirection)direction inSize:(CGSize)size{
    if(color == nil){
        color = [UIColor colorWithRed:0.5 green:0.5 blue:0.6 alpha:0.5];
    }
    //支持retina高分的关键
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat x1 = 4,y1 = 4;
    CGFloat x2 = 0,y2 = 0;
    CGFloat x3 = 0,y3 = 0;
    if(direction == ComboBoxArrowsDirectionDown){
        //箭头 Arrows
        x1 = 4,y1 = 4;
        x2 = size.width/2,y2 = size.height-4;
        x3 = size.width-4,y3 = 4;
    }else if(direction == ComboBoxArrowsDirectionRight){
        x1 = 4,y1 = 4;
        x2 = size.width-4,y2 = size.height/2;
        x3 = 4,y3 = size.height-4;
    }else if(direction == ComboBoxArrowsDirectionUp){
        x1 = 4,y1 = size.height-4;
        x2 = size.width/2,y2 = 4;
        x3 = size.width-4,y3 = size.height-4;
    }else if(direction == ComboBoxArrowsDirectionLeft){
        x1 = size.width-4,y1 = 4;
        x2 = 4,y2 = size.height/2;
        x3 = size.width-4,y3 = size.height-4;
    }
    CGContextBeginPath(context);
    [color set];
    // CGContextSetRGBStrokeColor(context,0.5,0.5,0.5,0.8);//画笔线的颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
    CGContextMoveToPoint(context, x1, y1);
    CGContextAddLineToPoint(context,x2,y2);
    CGContextAddLineToPoint(context,x3,y3);
    //CGContextDrawPath(context, kCGPathFill);
    CGContextStrokePath(context);
    //CGContextFillPath(context);
    //CGContextClosePath(context);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark 做按下效果
/////////////// end ///////////////////////////////////////

- (void)dealloc
{
}
@end
