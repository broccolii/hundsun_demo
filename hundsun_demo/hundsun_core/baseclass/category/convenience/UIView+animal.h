//
//  UIView+animal.h
//  hundsun_zjfae
//
//  Created by 王金东 on 14-8-4.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 动画
 **/
 
@interface UIView (animal)

#pragma mark - --------------------------animation--------------------------
// 淡入淡出
- (void) animationCrossfadeWithDuration:(NSTimeInterval)duration;
- (void) animationCrossfadeWithDuration:(NSTimeInterval)duration completion:(UIViewCategoryAnimationBlock)completion;

/** 立方体翻转
 *kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom
 */
- (void) animationCubeWithDuration:(NSTimeInterval)duration direction:(NSString *)direction;
- (void) animationCubeWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion;

/** 翻转
 *kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom
 */
- (void) animationOglFlipWithDuration:(NSTimeInterval)duration direction:(NSString *)direction;
- (void) animationOglFlipWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion;

/** 覆盖
 *kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom
 */
- (void) animationMoveInWithDuration:(NSTimeInterval)duration direction:(NSString *)direction;
- (void) animationMoveInWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion;

// 抖动
- (void) animationShake;

@end
