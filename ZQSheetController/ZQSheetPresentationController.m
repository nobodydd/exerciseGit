//
//  ZQSheetPresentationController.m
//  HYJFIOS
//
//  Created by zhaozq on 2018/6/29.
//  Copyright © 2018年 HYJF. All rights reserved.
//

#import "ZQSheetPresentationController.h"

@interface ZQSheetPresentationController ()

@property (strong, nonatomic) UIView *backgroundView;

@property (strong, nonatomic) UIVisualEffectView *blurView;

@end

@implementation ZQSheetPresentationController

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    self.backgroundView.backgroundColor = backgroundColor;
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [_backgroundView addGestureRecognizer:tap];
    }
    return _backgroundView;
}

- (void)presentationTransitionWillBegin
{
    self.backgroundView.alpha = 0;
    self.backgroundView.frame = self.containerView.bounds;
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    self.blurView.frame = self.containerView.bounds;
    [self.backgroundView addSubview:self.blurView];
    [self.containerView addSubview:self.presentingViewController.view];
    [self.containerView addSubview:self.backgroundView];
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.backgroundView.alpha = 0.6;
    } completion:nil];
    
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
    if (!completed) {
        [_backgroundView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin
{
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.backgroundView.alpha = 0;
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed) {
        [_backgroundView removeFromSuperview];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self.presentingViewController.view];
}

- (BOOL)shouldRemovePresentersView
{
    return NO;
}

- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect bounds = self.containerView.bounds;
    if (_presentingHeight > 0) {
        return CGRectMake(bounds.origin.x, bounds.size.height - _presentingHeight, bounds.size.width, _presentingHeight);
    }
    return bounds;
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tap
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
