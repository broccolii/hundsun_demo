//
//  UIView+animal.m
//  hundsun_zjfae
//
//  Created by 王金东 on 14-8-4.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "UIView+animal.h"

@implementation UIView (animal)

#pragma mark - animation
- (void) animationCrossfadeWithDuration:(NSTimeInterval)duration
{
    //jump through a few hoops to avoid QuartzCore framework dependency
    CAAnimation *animation = [NSClassFromString(@"CATransition") animation];
    [animation setValue:@"kCATransitionFade" forKey:@"type"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.duration = duration;
    [self.layer addAnimation:animation forKey:nil];
}

- (void) animationCrossfadeWithDuration:(NSTimeInterval)duration completion:(UIViewCategoryAnimationBlock)completion
{
    [self animationCrossfadeWithDuration:duration];
    if (completion)
    {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), completion);
    }
}

- (void) animationCubeWithDuration:(NSTimeInterval)duration direction:(NSString *)direction{
    CATransition *transtion = [CATransition animation];
    transtion.duration = duration;
    [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [transtion setType:@"cube"];
    [transtion setSubtype:direction];
    [self.layer addAnimation:transtion forKey:@"transtionKey"];
}

- (void) animationCubeWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion{
    [self animationCubeWithDuration:duration direction:direction];
    if (completion)
    {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), completion);
    }
}

- (void) animationOglFlipWithDuration:(NSTimeInterval)duration direction:(NSString *)direction{
    CATransition *transtion = [CATransition animation];
    transtion.duration = duration;
    [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [transtion setType:@"oglFlip"];
    [transtion setSubtype:direction];
    [self.layer addAnimation:transtion forKey:@"transtionKey"];
}

- (void) animationOglFlipWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(void (^)(void))completion{
    [self animationOglFlipWithDuration:duration direction:direction];
    if (completion)
    {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), completion);
    }
}

- (void) animationMoveInWithDuration:(NSTimeInterval)duration direction:(NSString *)direction{
    CATransition *transtion = [CATransition animation];
    transtion.duration = duration;
    [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [transtion setType:kCATransitionMoveIn];
    [transtion setSubtype:direction];
    [self.layer addAnimation:transtion forKey:@"transtionKey"];
}

- (void) animationMoveInWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion{
    [self animationMoveInWithDuration:duration direction:direction];
    if (completion)
    {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), completion);
    }
}

- (void) animationShake{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置抖动幅度
    shake.fromValue = [NSNumber numberWithFloat:-0.1];
    shake.toValue = [NSNumber numberWithFloat:+0.1];
    shake.duration = 0.06;
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 3;
    [self.layer addAnimation:shake forKey:@"XYShake"];
}


@end
