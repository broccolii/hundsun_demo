//
//  LinearLayoutView.m
//  LinearLayoutView
//
//  Created by Charles Scalesse on 3/24/12.
//  Copyright (c) 2013 Charles Scalesse. All rights reserved.
//

#import "HsUILinearLayoutView.h"

@interface HsUILinearLayoutView()

- (void)setup;
- (void)adjustFrameSize;
- (void)adjustContentSize;

@end

@implementation HsUILinearLayoutView

@synthesize items = _items;
@synthesize orientation = _orientation;
@synthesize autoAdjustFrameSize = _autoAdjustFrameSize;
@synthesize autoAdjustContentSize = _autoAdjustContentSize;

#pragma mark - Factories

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
        //保留控件在view上的间隙
        self.keepPaddingInXib = YES;
        self.showsVerticalScrollIndicator = YES;
        [self reLayout];
    }
    return self;
}

- (void)setup {
    _items = [[NSMutableArray alloc] init];
    _orientation = HsUILinearLayoutViewOrientationVertical;
    _autoAdjustFrameSize = NO;
    _autoAdjustContentSize = YES;
    self.autoresizesSubviews = NO;
}

- (void)setKeepPaddingInXib:(BOOL)keepPaddingInXib{
    _keepPaddingInXib = keepPaddingInXib;
    [self reloadLayout];
}
//刷新布局
- (void)reloadLayout{
    [_items removeAllObjects];
    [self reLayout];
}

#pragma mark - Lifecycle

- (void)dealloc {
     _items = nil;
}


#pragma mark - Layout

- (void)layoutSubviews {
    
    CGFloat relativePosition = 0.0;
    CGFloat absolutePosition = 0.0;
    
    for (HsUILinearLayoutItem *item in _items) {
        
        CGFloat startPadding = 0.0;
        CGFloat endPadding = 0.0;
        if(item.view.hidden){//如果隐藏了则不管它
            continue;
        }
        
        if (self.orientation == HsUILinearLayoutViewOrientationHorizontal) {
            
            startPadding = item.padding.left;
            endPadding = item.padding.right;
            
            if (item.verticalAlignment == HsUILinearLayoutItemVerticalAlignmentTop || item.fillMode == HsUILinearLayoutItemFillModeStretch) {
                absolutePosition = item.padding.top;
            } else if (item.verticalAlignment == HsUILinearLayoutItemVerticalAlignmentBottom) {
                absolutePosition = self.frame.size.height - item.view.frame.size.height - item.padding.bottom;
            } else { // LinearLayoutItemVerticalCenter
                absolutePosition = (self.frame.size.height / 2) - ((item.view.frame.size.height + (item.padding.bottom - item.padding.top)) / 2);
            }
            
        } else {
            
            startPadding = item.padding.top;
            endPadding = item.padding.bottom;
            
            if (item.horizontalAlignment == HsUILinearLayoutItemHorizontalAlignmentLeft || item.fillMode == HsUILinearLayoutItemFillModeStretch) {
                absolutePosition = item.padding.left;
            } else if (item.horizontalAlignment == HsUILinearLayoutItemHorizontalAlignmentRight) {
                absolutePosition = self.frame.size.width - item.view.frame.size.width - item.padding.right;
            } else { // LinearLayoutItemHorizontalCenter
                absolutePosition = (self.frame.size.width / 2) - ((item.view.frame.size.width + (item.padding.right - item.padding.left)) / 2);
            }
            
        }
        
        relativePosition += startPadding;
        
        CGFloat currentOffset = 0.0;
        if (self.orientation == HsUILinearLayoutViewOrientationHorizontal) {
            
            CGFloat height = item.view.frame.size.height;
            if (item.fillMode == HsUILinearLayoutItemFillModeStretch) {
                height = self.frame.size.height - (item.padding.top + item.padding.bottom);
            }
            
            item.view.frame = CGRectMake(relativePosition, absolutePosition, item.view.frame.size.width, height);
            currentOffset = item.view.frame.size.width;
            
        } else {
            
            CGFloat width = item.view.frame.size.width;
            if (item.fillMode == HsUILinearLayoutItemFillModeStretch) {
                width = self.frame.size.width - (item.padding.left + item.padding.right);
            }
            
            item.view.frame = CGRectMake(absolutePosition, relativePosition, width, item.view.frame.size.height);
            currentOffset = item.view.frame.size.height;
            
        }
        
        relativePosition += currentOffset + endPadding;
        
    }
    
    if (_autoAdjustFrameSize == YES) {
        [self adjustFrameSize];
    }
    
    if (_autoAdjustContentSize == YES) {
        [self adjustContentSize];
    }
}

- (void)adjustFrameSize {
    if (self.orientation == HsUILinearLayoutViewOrientationHorizontal) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.layoutOffset, self.frame.size.height);
    } else {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.layoutOffset);
    }
}

- (void)adjustContentSize {
    if (self.orientation == HsUILinearLayoutViewOrientationHorizontal) {
        CGFloat contentWidth = MAX(self.frame.size.width, self.layoutOffset);
        self.contentSize = CGSizeMake(contentWidth, self.frame.size.height);
    } else {
        CGFloat contentHeight = MAX(self.frame.size.height, self.layoutOffset);
        self.contentSize = CGSizeMake(self.frame.size.width, contentHeight);
    }
}

- (CGFloat)layoutOffset {
    CGFloat currentOffset = 0.0;
    
    for (HsUILinearLayoutItem *item in _items) {
        if (_orientation == HsUILinearLayoutViewOrientationHorizontal) {
            currentOffset += item.padding.left + item.view.frame.size.width + item.padding.right;
        } else {
            currentOffset += item.padding.top + item.view.frame.size.height + item.padding.bottom;
        }
    }
    
    return currentOffset;
}

- (void)setOrientation:(HsUILinearLayoutViewOrientation)anOrientation {
    _orientation = anOrientation;
    [self setNeedsLayout];
}

- (void)addSubview:(UIView *)view {
    [super addSubview:view];
    
    if (_autoAdjustFrameSize == YES) {
        [self adjustFrameSize];
    }
    
    if (_autoAdjustContentSize == YES) {
        [self adjustContentSize];
    }
}

//重新布局  该api可以方便用xib画界面时自动布局
//xib上随便放控件 它会根据放的顺序来根据你设置的方向自动布局
- (void)reLayout{
    if(self.items.count == 0){
        UIView *lastView = nil;
        for (UIView *subview in self.subviews) {
            if([subview isKindOfClass:[UIImageView class]] && subview.alpha == 0.0f){
                //排除里面的滚动条
                continue;
            }
            HsUILinearLayoutItemPadding padding = HsUILinearLayoutMakePadding(0,0,0,0);
            if(self.keepPaddingInXib){
                padding.top = subview.frame.origin.y-(lastView.frame.size.height+lastView.frame.origin.y);
                if (padding.top < 0) {
                    padding.top = 0.0f;
                }
            }else{
                padding.left = self.xpadding;
                padding.top = self.ypadding;
            }
            [subview removeFromSuperview];
            [self addItemView:subview padding:padding];
            lastView = subview;
        }
    }else{
        [self setNeedsLayout];
    }
}

#pragma mark - Add, Remove, Insert, & Move

- (void)addItem:(HsUILinearLayoutItem *)linearLayoutItem {
    if (linearLayoutItem == nil || [_items containsObject:linearLayoutItem] == YES || linearLayoutItem.view == nil) {
        return;
    }
    
    [_items addObject:linearLayoutItem];
    [self addSubview:linearLayoutItem.view];
}
- (void)addItemView:(UIView *)view{
    [self addItemView:view padding:HsUILinearLayoutMakePadding(0,0,0,0)];
}
- (void)addItemView:(UIView *)view padding:(HsUILinearLayoutItemPadding)padding{
    HsUILinearLayoutItem *item = [HsUILinearLayoutItem layoutItemForView:view];
    item.padding = padding;
    item.horizontalAlignment = HsUILinearLayoutItemHorizontalAlignmentCenter;
    [self addItem:item];
}

//修改view的padding
- (void)modPadding:(HsUILinearLayoutItemPadding)padding forView:(UIView *)view{
    for (HsUILinearLayoutItem *item in _items) {
        if(item.view == view){//找到item 并修改其padding
            item.padding = padding;
            break;
        }
    }
    //刷新
    [self reloadLayout];
}

- (void)removeItemView:(UIView *)view{
    for (HsUILinearLayoutItem *item in self.items) {
        if(item.view == view){
            [self removeItem:item];
            break;
        }
    }
}
- (void)removeItem:(HsUILinearLayoutItem *)linearLayoutItem {
    if (linearLayoutItem == nil || [_items containsObject:linearLayoutItem] == NO) {
        return;
    }
    
    [_items removeObject:linearLayoutItem];
    [linearLayoutItem.view removeFromSuperview];
    
}

- (void)removeAllItems {
    [_items removeAllObjects];
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

- (void)insertItem:(HsUILinearLayoutItem *)newItem beforeItem:(HsUILinearLayoutItem *)existingItem {
    if (newItem == nil || [_items containsObject:newItem] == YES || existingItem == nil ||  [_items containsObject:existingItem] == NO) {
        return;
    }
    
    NSUInteger index = [_items indexOfObject:existingItem];
    [_items insertObject:newItem atIndex:index];
    [self addSubview:newItem.view];
}

- (void)insertItem:(HsUILinearLayoutItem *)newItem afterItem:(HsUILinearLayoutItem *)existingItem {
    if (newItem == nil || [_items containsObject:newItem] == YES || existingItem == nil || [_items containsObject:existingItem] == NO) {
        return;
    }
    
    if (existingItem == [_items lastObject]) {
        [_items addObject:newItem];
    } else {
        NSUInteger index = [_items indexOfObject:existingItem];
        [_items insertObject:newItem atIndex:++index];
    }
    
    [self addSubview:newItem.view];
}

- (void)insertItem:(HsUILinearLayoutItem *)newItem atIndex:(NSUInteger)index {
    if (newItem == nil || [_items containsObject:newItem] == YES || index >= [_items count]) {
        return;
    }
    
    [_items insertObject:newItem atIndex:index];
    [self addSubview:newItem.view];
}

- (void)moveItem:(HsUILinearLayoutItem *)movingItem beforeItem:(HsUILinearLayoutItem *)existingItem {
    if (movingItem == nil || [_items containsObject:movingItem] == NO || existingItem == nil || [_items containsObject:existingItem] == NO || movingItem == existingItem) {
        return;
    }
    
    [_items removeObject:movingItem];
    
    NSUInteger existingItemIndex = [_items indexOfObject:existingItem];
    [_items insertObject:movingItem atIndex:existingItemIndex];
    
    [self setNeedsLayout];
}

- (void)moveItem:(HsUILinearLayoutItem *)movingItem afterItem:(HsUILinearLayoutItem *)existingItem {
    if (movingItem == nil || [_items containsObject:movingItem] == NO || existingItem == nil || [_items containsObject:existingItem] == NO || movingItem == existingItem) {
        return;
    }
    
    [_items removeObject:movingItem];
    
    if (existingItem == [_items lastObject]) {
        [_items addObject:movingItem];
    } else {
        NSUInteger existingItemIndex = [_items indexOfObject:existingItem];
        [_items insertObject:movingItem atIndex:++existingItemIndex];
    }
    
    [self setNeedsLayout];
}

- (void)moveItem:(HsUILinearLayoutItem *)movingItem toIndex:(NSUInteger)index {
    if (movingItem == nil || [_items containsObject:movingItem] == NO || index >= [_items count] || [_items indexOfObject:movingItem] == index) {
        return;
    }
    
    [_items removeObject:movingItem];
    
    if (index == ([_items count] - 1)) {
        [_items addObject:movingItem];
    } else {
        [_items insertObject:movingItem atIndex:index];
    }
    
    [self setNeedsLayout];
}

- (void)swapItem:(HsUILinearLayoutItem *)firstItem withItem:(HsUILinearLayoutItem *)secondItem {
    if (firstItem == nil || [_items containsObject:firstItem] == NO || secondItem == nil || [_items containsObject:secondItem] == NO || firstItem == secondItem) {
        return;
    }
    
    NSUInteger firstItemIndex = [_items indexOfObject:firstItem];
    NSUInteger secondItemIndex = [_items indexOfObject:secondItem];
    [_items exchangeObjectAtIndex:firstItemIndex withObjectAtIndex:secondItemIndex];
    
    [self setNeedsLayout];
}

@end

#pragma mark -

@implementation HsUILinearLayoutItem

@synthesize view = _view;
@synthesize fillMode = _fillMode;
@synthesize horizontalAlignment = _horizontalAlignment;
@synthesize verticalAlignment = _verticalAlignment;
@synthesize padding = _padding;
@synthesize tag = _tag;
@synthesize userInfo = _userInfo;

#pragma mark - Factories

- (id)init {
    self = [super init];
    if (self) {
        self.horizontalAlignment = HsUILinearLayoutItemHorizontalAlignmentLeft;
        self.verticalAlignment = HsUILinearLayoutItemVerticalAlignmentTop;
        self.fillMode = HsUILinearLayoutItemFillModeNormal;
    }
    return self;
}

- (id)initWithView:(UIView *)aView {
    self = [super init];
    if (self) {
        self.view = aView;
        self.horizontalAlignment = HsUILinearLayoutItemHorizontalAlignmentLeft;
        self.verticalAlignment = HsUILinearLayoutItemVerticalAlignmentTop;
        self.fillMode = HsUILinearLayoutItemFillModeNormal;
    }
    return self;
}

+ (HsUILinearLayoutItem *)layoutItemForView:(UIView *)aView {
    HsUILinearLayoutItem *item = [[HsUILinearLayoutItem alloc] initWithView:aView];
    return item;
}

#pragma mark - Memory Management

- (void)dealloc {
    self.view = nil;
    self.userInfo = nil;
}


#pragma mark - Helpers

HsUILinearLayoutItemPadding HsUILinearLayoutMakePadding(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    HsUILinearLayoutItemPadding padding;
    padding.top = top;
    padding.left = left;
    padding.bottom = bottom;
    padding.right = right;
    
    return padding;
}

@end
