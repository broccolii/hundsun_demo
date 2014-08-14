//
//  UITabBar+NIStyleable.h
//  hundsun_zjfae
//
//  Created by 王金东 on 14-8-8.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NICSSRuleset;
@class NIDOM;

@interface UITabBar (NIStyleable)


/**
 * Applies the given rule set to this navigation bar. Use applyTabBarStyleWithRuleSet: instead
 *
 * This method is exposed primarily for subclasses to use when implementing the
 * applyStyleWithRuleSet: method from NIStyleable.
 */
- (void)applyTabBarStyleWithRuleSet:(NICSSRuleset *)ruleSet DEPRECATED_ATTRIBUTE;

/**
 * Applies the given rule set to this navigation bar.
 *
 * This method is exposed primarily for subclasses to use when implementing the
 * applyStyleWithRuleSet: method from NIStyleable.
 */
- (void)applyTabBarStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM: (NIDOM*) dom;




@end
