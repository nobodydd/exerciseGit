//
//  ZQSheetAnimation.h
//  HYJFIOS
//
//  Created by zhaozq on 2018/6/29.
//  Copyright © 2018年 HYJF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQSheetShowAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) NSTimeInterval duration;

@property (assign, nonatomic) NSTimeInterval delay;

@property (assign, nonatomic) CGFloat springWithDamping;

@property (assign, nonatomic) CGFloat springVelocity;

@end

@interface ZQSheetDismissAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) NSTimeInterval duration;

@property (assign, nonatomic) NSTimeInterval delay;

@property (assign, nonatomic) CGFloat springWithDamping;

@property (assign, nonatomic) CGFloat springVelocity;

@end
