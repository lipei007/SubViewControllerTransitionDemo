//
//  PLViewController.m
//  PLViewController
//
//  Created by Jack on 2018/1/16.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "PLViewController.h"
#import "TestVC.h"

@interface PLDefaultAnimateTransition : NSObject <PLViewControllerAnimatedTransition>

@end

@implementation PLDefaultAnimateTransition

- (void)animateTransition:(PLViewControllerTransitionContext *)transitionContext {
    if (transitionContext == nil) {
        return;
    }
    
    // animation
    CGRect frame = transitionContext.finalFrameForToView;
    frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
    transitionContext.toViewController.view.frame = frame;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect frame = transitionContext.finalFrameForToView;
        transitionContext.toViewController.view.frame = frame;
        
    } completion:^(BOOL finished) {
        // finish animate and report
        [transitionContext transitionComplete:finished];
    }];
    
}

@end

@interface PLViewController ()
{
    UIViewController *_rootViewController;
    UIViewController *_currentViewController;
    UIView *_ToolBar;
}
@end

@implementation PLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSAssert(_rootViewController != nil, @"No RootViewController");
    
    _ToolBar = [[UIView alloc] init];
    
    UIViewController *rootVC = _rootViewController;
    _rootViewController = nil;
    [self setupRootViewController:rootVC];
}

- (UIViewController *)currentViewController {
    return _currentViewController;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.view.bounds;
    frame.origin.y = 60;
    frame.size.height -= 60;
    
    _currentViewController.view.frame = frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        _rootViewController = rootViewController;
    }
    return self;
}

- (void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion {
    
    if (fromViewController == nil || toViewController == nil) {
        return;
    }
    
    [self addChildViewController:toViewController];
    _currentViewController = toViewController;
    [self.view addSubview:toViewController.view];
    [fromViewController willMoveToParentViewController:nil];
    
//    // animation
//    CGRect frame = _currentViewController.view.frame;
//    frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y + frame.size.height, frame.size.width, frame.size.height);
//    toViewController.view.frame = frame;
//
//    __weak typeof(self) weakSelf = self;
//    void (^PLAnimation)(void) = ^{
//        if (animations) {
//            animations();
//        }
//        CGRect frame = _currentViewController.view.frame;
//        toViewController.view.frame = frame;
//    };
//
//    // completion
//    void (^PLCompleteBlock)(BOOL) = ^(BOOL complete){
//        if (completion) {
//            completion(complete);
//        }
//        [fromViewController.view removeFromSuperview];
//        [fromViewController removeFromParentViewController];
//        [toViewController didMoveToParentViewController:weakSelf];
//    };
//
//
//    [UIView animateWithDuration:duration animations:^{
//
//        PLAnimation();
//
//    } completion:^(BOOL finished) {
//        PLCompleteBlock(finished);
//    }];
    
//    [super transitionFromViewController:fromViewController toViewController:toViewController duration:duration options:options animations:PLAnimation completion:PLCompleteBlock];

    id<PLViewControllerAnimatedTransition> animator = [self animationControllerForController:self transitionFromViewController:fromViewController toViewController:toViewController];
    if (animator == nil) {
        // defaul
         animator = [[PLDefaultAnimateTransition alloc] init];
    }
    PLViewControllerTransitionContext *context = [[PLViewControllerTransitionContext alloc] init];
    context.fromViewController = fromViewController;
    context.toViewController = toViewController;
    context.fromView = fromViewController.view;
    context.toView = toViewController.view;
    context.finalFrameForToView = fromViewController.view.frame;
    
    [animator animateTransition:context];
    
}

- (id<PLViewControllerAnimatedTransition>)animationControllerForController:(UIViewController *)controller transitionFromViewController:(UIViewController *)from toViewController:(UIViewController *)to {
    
    return nil;
}

- (void)showViewController:(UIViewController *)vc {
    if (vc == nil) {
        return;
    }
    
    if (_rootViewController == nil) {
        [self setupRootViewController:vc];
    } else {
        [self transitionFromViewController:_currentViewController toViewController:vc duration:0.25 options:UIViewAnimationOptionCurveLinear animations:nil completion:nil];
    }
    
    
}

- (void)setupRootViewController:(UIViewController *)rootViewController {
    if (rootViewController == nil) {
        return;
    }
    
    _rootViewController = rootViewController;
    
    _currentViewController = _rootViewController;
    [self addChildViewController:_currentViewController];
    [self.view addSubview:_currentViewController.view];
    [_currentViewController didMoveToParentViewController:self];
}

@end


@implementation PLViewControllerTransitionContext

- (void)transitionComplete:(BOOL)finish {
    if (finish) {
        UIViewController *parentVC = self.fromViewController.parentViewController;
        [self.fromViewController.view removeFromSuperview];
        [self.fromViewController removeFromParentViewController];
        [self.toViewController didMoveToParentViewController:parentVC];
    }
}

@end
