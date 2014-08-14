//
//  UIView+convenience.h
//
//  Created by Tjeerd in 't Veen on 12/1/11.
//  Copyright (c) 2011 Vurig Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+frame.h"

typedef NS_ENUM (NSInteger,HsViewAlignment) {
    HsViewAlignmentNoe = 0,//子view位置默认
    HsViewAlignmentTop = 1 << 0,//子view居上
    HsViewAlignmentBottom = 1 << 1,//子view居底
    HsViewAlignmentCenter = 1 << 2,//子view居中
    HsViewAlignmentLeft = 1 << 3,//子view居左
    HsViewAlignmentRight = 1 << 4,//子view居右
} ;

typedef void(^UIViewCategoryAnimationBlock)(void);//动画block

@interface UIView (convenience)

@property (nonatomic,strong,readonly) UIViewController *topViewController;

#pragma mark --------------------------touch--------------------------

//增加点击手势
- (void)addTapGesture:(id)target action:(SEL)action;
//增加pan手势
- (void)addPanGesture:(id)target action:(SEL)action;
//移除手势
- (void)removeGesture;

#pragma mark style
// 圆形
- (instancetype)rounded;
// 圆角矩形, corners:一个矩形的四个角。
- (instancetype)roundedRectWith:(CGFloat)radius;
- (instancetype)roundedRectWith:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners;

//加阴影 color:shadowColor  opacity:shadowOpacity offset:shadowOffset blurRadius:shadowRadius
- (void)setShadow : (UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset blurRadius:(CGFloat)blurRadius;

// 边框大小,颜色
-(instancetype)borderWidth:(CGFloat)width color:(UIColor *)color;

#pragma mark -------------------------- function ---------------------------------

- (void)addSubview:(UIView *)subview alignment:(HsViewAlignment)alignment;

- (void)addSubview:(UIView *)subview alignment:(HsViewAlignment)alignment offset:(CGPoint)offset;


//截屏
- (UIImage *)snapShot;


#pragma mark --------------------------操作结构树--------------------------

//是否包含某个view
- (BOOL) containsSubView:(UIView *)subView;

//是否包含某一类view
- (BOOL) containsSubViewOfClassType:(Class)clazz;

//在父视图的位置
- (NSInteger)locationAtSuperView;

//移除所以子视图
- (void)removeSubView;

- (void)removeSubViewWithTag:(NSInteger)tag;

#pragma mark -todo attribute
- (void) showDataWithDic:(NSDictionary *)dic;

@end

