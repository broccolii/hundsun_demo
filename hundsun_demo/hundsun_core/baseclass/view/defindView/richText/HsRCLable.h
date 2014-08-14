//
//  RCLabel.m
//  RCLabelProject
//
/**
 * Copyright (c) 2012 Hang Chen
 * Created by hangchen on 21/7/12.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject
 * to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT
 * WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT
 * SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR
 * IN CONNECTION WITH THE SOFTWARE OR
 * THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * @author 		Hang Chen <cyndibaby905@yahoo.com.cn>
 * @copyright	2012	Hang Chen
 * @version
 *
 */


#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
typedef enum
{
	HsRCTextAlignmentRight = kCTRightTextAlignment,
	HsRCTextAlignmentLeft = kCTLeftTextAlignment,
	HsRCTextAlignmentCenter = kCTCenterTextAlignment,
	HsRCTextAlignmentJustify = kCTJustifiedTextAlignment
} HsRCTextAlignment;

typedef enum
{
	HsRCTextLineBreakModeWordWrapping = kCTLineBreakByWordWrapping,
	HsRCTextLineBreakModeCharWrapping = kCTLineBreakByCharWrapping,
	HsRCTextLineBreakModeClip = kCTLineBreakByClipping,
    HsRCTextLineBreakModeTruncatingHead = kCTLineBreakByTruncatingHead,
    HsRCTextLineBreakModeTruncatingTail = kCTLineBreakByTruncatingTail,
    HsRCTextLineBreakModeTruncatingMiddle = kCTLineBreakByTruncatingMiddle,
}HsRCTextLineBreakMode;


@class HsRCLabelComponentsStructure;


@class HsRCLabelComponent;
@protocol HsRCLabelDelegate <NSObject>

- (void)rcLabel:(id)rcLabel didSelectLinkWithURL:(NSString*)url;

@end



@interface HsRCLable : UIView  {
	//NSString *_text;
	UIFont *_font;
	UIColor *_textColor;
    UIColor *_originalColor;
	HsRCTextAlignment _textAlignment;
	HsRCTextLineBreakMode _lineBreakMode;
	
	CGSize _optimumSize;
    
    CTFramesetterRef _framesetter;
    CTFrameRef _ctFrame;
    CFRange _visibleRange;
    CTFontRef _thisFont;
    CFMutableAttributedStringRef _attrString;
    HsRCLabelComponent * _currentLinkComponent;
    HsRCLabelComponent * _currentImgComponent;
    HsRCLabelComponentsStructure *componentsAndPlainText_;
    UIColor *normalBackgroundColor;
}

@property (nonatomic, assign) CGFloat linespacing;//行间距
@property (nonatomic, weak) id<HsRCLabelDelegate> delegate;//代理类

@property (nonatomic,strong) HsRCLabelComponent *currentLinkComponent;
@property (nonatomic,strong) HsRCLabelComponent *currentImgComponent;
@property (nonatomic,assign) NSInteger maxLineHeight;
@property (nonatomic,assign) NSInteger minLineHeight;

@property (nonatomic,strong) NSString *text;//当前文本

@property (nonatomic,assign) BOOL closeCopy;//关闭copy功能

@property (nonatomic,strong) NSString *keyword;//关键字

//设置文本对齐方式
- (void)setTextAlignment:(HsRCTextAlignment)textAlignment;
//得到文本对齐方式
- (HsRCTextAlignment)textAlignment;

//设置文本折行方式
- (void)setLineBreakMode:(HsRCTextLineBreakMode)lineBreakMode;
//得到文本折行方式
- (HsRCTextLineBreakMode)lineBreakMode;

//设置文本颜色
- (void)setTextColor:(UIColor*)textColor;
- (UIColor*)textColor;//得到文本颜色

//设置字体
- (void)setFont:(UIFont*)font;

- (UIFont*)font;//得到字体

- (void)setComponentsAndPlainText:(HsRCLabelComponentsStructure*)componnetsDS;
- (HsRCLabelComponentsStructure*)componentsAndPlainText;

- (CGSize)optimumSize;
//- (void)setLineSpacing:(CGFloat)lineSpacing;
- (NSString*)visibleText;

- (void)showTruncatingTail;//将控件设置某个高度后，多余文本追加...

- (NSInteger)getLines;


@end




@interface HsRCLabelComponent : NSObject
{
	NSString *_text;
	NSString *_tagLabel;
	NSMutableDictionary *_attributes;
	int _position;
	int _componentIndex;
    BOOL _isClosure;
    UIImage *img_;
}

@property (nonatomic, assign) int componentIndex;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *tagLabel;
@property (nonatomic, strong) NSMutableDictionary *attributes;
@property (nonatomic, assign) int position;
@property (nonatomic, assign) BOOL isClosure;
@property (nonatomic, strong) UIImage *img;


- (id)initWithString:(NSString*)aText tag:(NSString*)aTagLabel attributes:(NSMutableDictionary*)theAttributes;
+ (id)componentWithString:(NSString*)aText tag:(NSString*)aTagLabel attributes:(NSMutableDictionary*)theAttributes;
- (id)initWithTag:(NSString*)aTagLabel position:(int)_position attributes:(NSMutableDictionary*)_attributes;
+ (id)componentWithTag:(NSString*)aTagLabel position:(int)aPosition attributes:(NSMutableDictionary*)theAttributes;

@end


@interface HsRCLabelComponentsStructure :NSObject {
    NSArray *components_;
    NSString *plainTextData_;
    NSArray *linkComponents_;
    NSArray *imgComponents_;
}
@property(nonatomic,strong) NSArray *components;
@property(nonatomic,strong) NSArray *linkComponents;
@property(nonatomic,strong) NSArray *imgComponents;
@property(nonatomic, strong)  NSString *plainTextData;
@end
