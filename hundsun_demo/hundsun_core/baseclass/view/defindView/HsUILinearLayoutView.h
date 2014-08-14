/***************************************************************************
  
LinearLayoutView.h
LinearLayoutView
Version 1.0

Copyright (c) 2013 Charles Scalesse.
 
Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:
 
The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 
***************************************************************************/
/**
 **仿android线性布局
 使用如下
 HsUILinearLayoutView *view = [HsUILinearLayoutView alloc] initWithFrame:CGRectZero];
 view.orientation = HsUILinearLayoutViewOrientationVertical;
 [view addItemView:view1]; 
 **/

#import <UIKit/UIKit.h>

typedef enum {
    HsUILinearLayoutItemFillModeNormal,   // Respects the view's frame size
    HsUILinearLayoutItemFillModeStretch   // Adjusts the frame to fill the linear layout view
} HsUILinearLayoutItemFillMode;

typedef enum {
    HsUILinearLayoutItemHorizontalAlignmentLeft,
    HsUILinearLayoutItemHorizontalAlignmentRight,
    HsUILinearLayoutItemHorizontalAlignmentCenter
} HsUILinearLayoutItemHorizontalAlignment;

typedef enum {
    HsUILinearLayoutItemVerticalAlignmentTop,
    HsUILinearLayoutItemVerticalAlignmentBottom,
    HsUILinearLayoutItemVerticalAlignmentCenter
} HsUILinearLayoutItemVerticalAlignment;

typedef struct {
    CGFloat top;
    CGFloat left;
    CGFloat bottom;
    CGFloat right;
} HsUILinearLayoutItemPadding;


@class HsUILinearLayoutItem;

typedef enum {
    HsUILinearLayoutViewOrientationVertical,
    HsUILinearLayoutViewOrientationHorizontal
} HsUILinearLayoutViewOrientation;

@interface HsUILinearLayoutView : UIScrollView

@property (nonatomic, readonly) NSMutableArray *items;
@property (nonatomic, assign) HsUILinearLayoutViewOrientation orientation;
@property (nonatomic, readonly) CGFloat layoutOffset;       // Iterates through the existing layout items and returns the current offset.
@property (nonatomic, assign) BOOL autoAdjustFrameSize;     // Updates the frame size as items are added/removed. Default is NO.
@property (nonatomic, assign) BOOL autoAdjustContentSize;   // Updates the contentView as items are added/removed. Default is YES.

@property (nonatomic,assign) BOOL keepPaddingInXib;//保留子view在xib上的布局的空隙
//子view之间x的间隙
@property (nonatomic,assign) float xpadding;
//子view之间y的间隙
@property (nonatomic,assign) float ypadding;

//重新布局  该api可以方便用xib画界面时自动布局
//xib上随便放控件 它会根据放的顺序来根据你设置的方向自动布局

/**
 **刷新布局
 **/
- (void)reloadLayout;

- (void)addItem:(HsUILinearLayoutItem *)linearLayoutItem;
- (void)addItemView:(UIView *)view;
- (void)addItemView:(UIView *)view padding:(HsUILinearLayoutItemPadding)padding;

//修改view的padding
- (void)modPadding:(HsUILinearLayoutItemPadding)padding forView:(UIView *)view;

- (void)removeItemView:(UIView *)view;
- (void)removeItem:(HsUILinearLayoutItem *)linearLayoutItem;
- (void)removeAllItems;

- (void)insertItem:(HsUILinearLayoutItem *)newItem beforeItem:(HsUILinearLayoutItem *)existingItem;
- (void)insertItem:(HsUILinearLayoutItem *)newItem afterItem:(HsUILinearLayoutItem *)existingItem;
- (void)insertItem:(HsUILinearLayoutItem *)newItem atIndex:(NSUInteger)index;

- (void)moveItem:(HsUILinearLayoutItem *)movingItem beforeItem:(HsUILinearLayoutItem *)existingItem;
- (void)moveItem:(HsUILinearLayoutItem *)movingItem afterItem:(HsUILinearLayoutItem *)existingItem;
- (void)moveItem:(HsUILinearLayoutItem *)movingItem toIndex:(NSUInteger)index;

- (void)swapItem:(HsUILinearLayoutItem *)firstItem withItem:(HsUILinearLayoutItem *)secondItem;//交换

@end

@interface HsUILinearLayoutItem : NSObject

@property (nonatomic, retain) UIView *view;
@property (nonatomic, assign) HsUILinearLayoutItemFillMode fillMode;
@property (nonatomic, assign) HsUILinearLayoutItemHorizontalAlignment horizontalAlignment;    // Use horizontalAlignment when the layout view is set to VERTICAL orientation
@property (nonatomic, assign) HsUILinearLayoutItemVerticalAlignment verticalAlignment;        // Use verticalAlignment when the layout view is set to HORIZONTAL orientation
@property (nonatomic, assign) HsUILinearLayoutItemPadding padding;
@property (nonatomic, assign) NSDictionary *userInfo;
@property (nonatomic, assign) NSInteger tag;

- (id)initWithView:(UIView *)aView;
+ (HsUILinearLayoutItem *)layoutItemForView:(UIView *)aView;

HsUILinearLayoutItemPadding HsUILinearLayoutMakePadding(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

@end