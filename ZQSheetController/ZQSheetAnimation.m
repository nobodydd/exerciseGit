//
//  ZQSheetAnimation.m
//  HYJFIOS
//
//  Created by zhaozq on 2018/6/29.
//  Copyright © 2018年 HYJF. All rights reserved.
//

#import "ZQSheetAnimation.h"

@implementation ZQSheetShowAnimation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.duration = 0.5;
        self.delay = 0.0;
        self.springWithDamping = 0.8;
        self.springVelocity = 0.0;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *containerView = [transitionContext containerView];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    CGRect startFrame = CGRectOffset(finalFrame, 0, finalFrame.size.height);
    toView.frame = startFrame;
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:self.delay usingSpringWithDamping: self.springWithDamping initialSpringVelocity: self.springVelocity options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^{
        toView.frame = finalFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }
    }];
}

@end


@implementation ZQSheetDismissAnimation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.duration = 0.5;
        self.delay = 0.0;
        self.springWithDamping = 0.8;
        self.springVelocity = 0.0;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *containerView = [transitionContext containerView];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:self.delay usingSpringWithDamping: self.springWithDamping initialSpringVelocity: self.springVelocity options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^{
        CGRect finalFrame = fromView.frame;
        finalFrame.origin.y = containerView.bounds.size.height;
        fromView.frame = finalFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled] || ![transitionContext isInteractive]];
        }
    }];
}
@end
