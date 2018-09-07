//
//  ZQSheetController.h
//  HYJFIOS
//
//  Created by zhaozq on 2018/6/29.
//  Copyright © 2018年 HYJF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZQSheetController : UIViewController

@property (strong, nonatomic) UIColor *backgroundColor;

@property (assign, nonatomic) CGFloat presentingHeight;

@property (strong, nonatomic) id<UIViewControllerAnimatedTransitioning> showAnimation;

@property (strong, nonatomic) id<UIViewControllerAnimatedTransitioning> dismissAnimation;

- (void)showFrom:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)showWithAnimated:(BOOL)animated completion:(void (^)(void))completion;
@end

NS_ASSUME_NONNULL_END
