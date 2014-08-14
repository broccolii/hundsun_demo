//
//  StatusBarWindow.m
//  SMEMU
//
//  Created by allen.huang on 14-3-13.
//  Copyright (c) 2014年 allen.huang. All rights reserved.
//

#import "StatusBarWindow.h"
#import "HsThemeManager.h"
#import "HsBaseTabBarController.h"


static StatusBarWindow *_instance;

@interface StatusBarWindow (){
     BOOL showStatusBar;//是否在显示状态提示
}

@property (nonatomic,retain) UILabel *textLable;

@end

@implementation StatusBarWindow

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        // mi_statusbar.center = CGPointMake(160, 10);
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
        self.alpha=1;
        self.delay = 2;
        [self addTapGesture:self action:@selector(tap:)];
    }
    return self;
}

+ (id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if(_instance == nil){
            _instance = [super allocWithZone:zone];
        }
    }
    return _instance;
}

+ (instancetype)sharedInstance{
    @synchronized(self){
        if(_instance == nil){
            _instance = [[StatusBarWindow alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-130, 0, 130, 20)];
        }
    }
    return _instance;
}
- (void)dealloc{
}

- (void)showSingleLineMessage:(NSString *)text{
    self.delay = 5;
    [self showMessage:text];
}

- (void)showMessage:(NSString *)text{
    if(IOS7){
        HsBaseTabBarController *tabbar = (HsBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        NICSSRuleset *ruleset = [tabbar.dom rulesetforClass:@"UINavigationBar"];
        UIColor *backgroundColor =   [ruleset colorFromCssRuleForKey:@"background-color"];
        self.backgroundColor = backgroundColor;
        self.opaque = NO;
    }else{
        self.backgroundColor = [UIColor blackColor];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!showStatusBar){
            showStatusBar = YES;
            if(self.textLable == nil){
                self.textLable = [[UILabel alloc] initWithFrame:CGRectMake(0, -20, self.frame.size.width, 20)];
                self.textLable.backgroundColor = [UIColor clearColor];
                self.textLable.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                self.textLable.textAlignment = NSTextAlignmentRight;
                self.textLable.numberOfLines = 1;
                self.textLable.lineBreakMode = NSLineBreakByTruncatingTail;
                self.textLable.font = [UIFont boldSystemFontOfSize:10.0f];
                [self addSubview:self.textLable];
            }
            if(IOS7){
                self.textLable.textColor = [UIColor blackColor];
            }else{
                self.textLable.textColor = [UIColor whiteColor];
            }
            [self  setHidden:NO];
            self.textLable.text = text;
            __block StatusBarWindow *window = self;
            [UIView animateWithDuration:0.5f animations:^{
                CGRect frame = window.textLable.frame;
                frame.origin.y = 0;
                window.textLable.frame = frame;
            } completion:^(BOOL finished){
                [window performSelector:@selector(dismissMessage) withObject:nil afterDelay:self.delay];
            }];
        }
     });
}
- (void)showMultiLineMessage:(NSString *)text{
    self.delay = 2;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger numOfLine = 15;
        CGFloat sleep = self.delay + 1.0f;
        NSInteger len = numOfLine;
        NSInteger lines = text.length%numOfLine == 0 ? (text.length/numOfLine) : (text.length/numOfLine+1);
        for(NSInteger i = 0 ;i < lines ; i++){
            if( i == lines -1){
                len = text.length%numOfLine;
            }
            NSString *subString = [text substringWithRange:NSMakeRange(i*numOfLine, len)];
            [self showMessage:subString];
            [NSThread sleepForTimeInterval:sleep];
        }
    });
}

- (void)dismissMessage{
    showStatusBar = NO;
    __block StatusBarWindow *window = self;
    [UIView animateWithDuration:0.5f animations:^{
        CGRect frame = window.textLable.frame;
        frame.origin.y = -(self.frame.size.height);
        window.textLable.frame = frame;
    } completion:^(BOOL finished){
        [window setHidden:YES];
    }];
    if(self.dimssBlock != nil){
        self.dimssBlock();
    }
}

- (void)tap:(UIGestureRecognizer *)gesture{
    [self dismissMessage];
    if(self.tapBlock != nil){
        self.tapBlock();
    }
    if(self.messageDelegate && [self.messageDelegate respondsToSelector:@selector(didTapWindow:delegate:)]){
        [self.messageDelegate performSelector:@selector(didTapWindow:delegate:) withObject:self withObject:self.messageDelegate];
    }
}

@end
