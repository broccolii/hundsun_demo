//
//  UITabBar+NIStyleable.m
//  hundsun_zjfae
//
//  Created by 王金东 on 14-8-8.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "UITabBar+NIStyleable.h"

@implementation UITabBar (NIStyleable)


- (void)applyTabBarStyleWithRuleSet:(NICSSRuleset *)ruleSet {
    [self applyTabBarStyleWithRuleSet:ruleSet inDOM:nil];
}

- (void)applyTabBarStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
    if([ruleSet hasTextColor]){
        self.tintColor = ruleSet.textColor;
    }
    
    if ([ruleSet hasTintColor]) {
        //选中色
        self.selectedImageTintColor = ruleSet.tintColor;
    }
    if([ruleSet hasBarColor]){
        //背景色
        self.barTintColor = ruleSet.barColor;
    }
    if([ruleSet hasBackgroundColor]){
        self.backgroundImage = [UIImage createImageWithColor:ruleSet.backgroundColor];
    }
    if([ruleSet hasBackgroundImage]){
        self.backgroundImage = [UIImage imageNamed:ruleSet.backgroundImage];
    }
   
}

- (void)applyStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
    [self applyViewStyleWithRuleSet:ruleSet inDOM:dom];
    [self applyTabBarStyleWithRuleSet:ruleSet inDOM:dom];
}


@end
