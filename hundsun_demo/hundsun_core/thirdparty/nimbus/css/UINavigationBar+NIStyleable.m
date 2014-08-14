//
// Copyright 2011-2014 NimbusKit
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "UINavigationBar+NIStyleable.h"

#import "UIView+NIStyleable.h"
#import "NICSSRuleset.h"
#import "NimbusCore.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "Nimbus requires ARC support."
#endif

NI_FIX_CATEGORY_BUG(UINavigationBar_NIStyleable)

@implementation UINavigationBar (NIStyleable)

- (void)applyNavigationBarStyleWithRuleSet:(NICSSRuleset *)ruleSet {
  [self applyNavigationBarStyleWithRuleSet:ruleSet inDOM:nil];
}

- (void)applyNavigationBarStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
    //导航按钮颜色
  if ([ruleSet hasTintColor]) {
      self.tintColor = ruleSet.tintColor;
  }
  //导航背景色
  if([ruleSet hasBarColor]){
      self.barTintColor = ruleSet.barColor;
  }
    //导航字体颜色
    if([ruleSet hasTextColor]){
        [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ruleSet.textColor, NSForegroundColorAttributeName,
                                      nil]];
    }
 //状态栏
  if([ruleSet hasStatusBarStyle]){
    [[UIApplication sharedApplication] setStatusBarStyle:ruleSet.statusBarStyle];
  }
    if([ruleSet hasBackgroundColor]){
        [self setBackgroundImage:[UIImage createImageWithColor:ruleSet.backgroundColor] forBarMetrics:UIBarMetricsDefault];
    }
    if([ruleSet hasBackgroundImage]){
        [self setBackgroundImage:[UIImage imageNamed:ruleSet.backgroundImage] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)applyStyleWithRuleSet:(NICSSRuleset *)ruleSet inDOM:(NIDOM *)dom {
  [self applyViewStyleWithRuleSet:ruleSet inDOM:dom];
  [self applyNavigationBarStyleWithRuleSet:ruleSet inDOM:dom];
}

@end
