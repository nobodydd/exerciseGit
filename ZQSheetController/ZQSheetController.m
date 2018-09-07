//
//  ZQSheetController.m
//  HYJFIOS
//
//  Created by zhaozq on 2018/6/29.
//  Copyright © 2018年 HYJF. All rights reserved.
//

#import "ZQSheetController.h"
#import "ZQSheetPresentationController.h"
#import "ZQSheetAnimation.h"

@interface ZQSheetController () <UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *percentDriven;


@end

@implementation ZQSheetController

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self config];
    }
    return self;
}


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config
{
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate  = self;
    self.presentingHeight = -1;
    self.backgroundColor = [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureAction:)];
    [self.view addGestureRecognizer:pan];
}

- (void)showFrom:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion
{
    [controller presentViewController:self animated:animated completion:completion];
}

- (void)showWithAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [[CommonFunction getRootTabbarController] presentViewController:self animated:animated completion:completion];
}

- (void)panGestureAction:(UIPanGestureRecognizer *)pan {
    CGFloat height = self.view.bounds.size.height;
    CGFloat percent = [pan translationInView:self.view].y / height;
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        _percentDriven = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (pan.state == UIGestureRecognizerStateChanged){
        [_percentDriven updateInteractiveTransition:percent];
    }else if (pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateEnded){
        [_percentDriven finishInteractiveTransition];
        //        if (percent > 0.06) {
        //
        //
        //        }else{
        
        //            [percentDrivenInteractiveTransition cancelInteractiveTransition];
        
        //        }
        _percentDriven = nil;
    }
}

#pragma mark  UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){
    ZQSheetPresentationController *controller = [[ZQSheetPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    controller.backgroundColor = self.backgroundColor;
    controller.presentingHeight = self.presentingHeight;
    return controller;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    if (self.showAnimation) {
        return _showAnimation;
    }
    return [ZQSheetShowAnimation new];
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    if (self.dismissAnimation) {
        return _dismissAnimation;
    }
    return [ZQSheetDismissAnimation new];
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return _percentDriven;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
