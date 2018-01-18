//
//  PLViewController.h
//  PLViewController
//
//  Created by Jack on 2018/1/16.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLViewControllerTransitionContext : NSObject

@property (nonatomic,weak) UIViewController *fromViewController;
@property (nonatomic,weak) UIViewController *toViewController;
@property (nonatomic,weak) UIView *fromView;
@property (nonatomic,weak) UIView *toView;
@property (nonatomic,assign) CGRect finalFrameForToView;

- (void)transitionComplete:(BOOL)finish;

@end

@protocol PLViewControllerAnimatedTransition

- (void)animateTransition:(PLViewControllerTransitionContext *)transitionContext;

@end


@interface PLViewController : UIViewController

//@property (nonatomic,assign) CGRect preferredContentFrame;
@property (nonatomic,strong,readonly) UIViewController *rootViewController;
@property (nonatomic,strong,readonly) UIViewController *currentViewController;

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;

- (void)showViewController:(UIViewController *)vc;

- (id<PLViewControllerAnimatedTransition>)animationControllerForController:(UIViewController *)controller transitionFromViewController:(UIViewController *)from toViewController:(UIViewController *)to;

@end

