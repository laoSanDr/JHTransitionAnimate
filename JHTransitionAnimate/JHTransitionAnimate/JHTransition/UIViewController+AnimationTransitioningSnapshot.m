//
//  UIViewController+AnimationTransitioningSnapshot.m
//  JHTransitionAnimate
//
//  Created by jalaSmart on 17/6/21.
//  Copyright © 2017年 MrChen. All rights reserved.
//

#import "UIViewController+AnimationTransitioningSnapshot.h"
#import "JHTransition.h"
#import <objc/runtime.h>

@implementation UIViewController (AnimationTransitioningSnapshot)
@dynamic interactivePopTransition;

+ (void)load
{
    Method originMethod     = class_getInstanceMethod(NSClassFromString(@"UIViewController"), @selector(viewDidLoad));
    Method newMethod        = class_getInstanceMethod(NSClassFromString(@"UIViewController"), @selector(jh_viewDidLoad));
    method_exchangeImplementations(originMethod, newMethod);
}

- (void)jh_viewDidLoad
{
    
    if (self.navigationController && self != self.navigationController.viewControllers.firstObject)
    {
        UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePopRecognizer:)];
        [self.view addGestureRecognizer:popRecognizer];
    }
    [self jh_viewDidLoad];
}

- (void)handlePopRecognizer:(UIPanGestureRecognizer *)recognizer
{
    static BOOL w_isDragging = NO;
    CGFloat progress = [recognizer translationInView:self.view].x / CGRectGetWidth(self.view.frame);
    progress = MIN(1.0, MAX(0.0, progress));
    if (progress <= 0 && !w_isDragging && recognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        w_isDragging = YES;
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        w_isDragging = YES;
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        if (progress > 0.25)
        {
            w_isDragging = NO;
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else
        {
            w_isDragging = NO;
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}

- (UIPercentDrivenInteractiveTransition *)interactivePopTransition
{
    UIPercentDrivenInteractiveTransition *obj = objc_getAssociatedObject(self, @"JHInteractivePopTransition");
    if (!obj)
    {
        //        obj = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self setInteractivePopTransition:obj];
    }
    return obj;
}
- (void)setInteractivePopTransition:(UIPercentDrivenInteractiveTransition *)interactivePopTransition
{
    objc_setAssociatedObject(self, @"JHInteractivePopTransition", interactivePopTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)snapshot
{
    UIView *view = objc_getAssociatedObject(self, @"JHAnimationTransitioningSnapshot");
    if (!view)
    {
        view = self.tabBarController ? [self.tabBarController.view snapshotViewAfterScreenUpdates:NO] : [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
        [self setSnapshot:view];
    }
    return view;
}

- (void)setSnapshot:(UIView *)snapshot
{
    objc_setAssociatedObject(self, @"JHAnimationTransitioningSnapshot", snapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIView *)topSnapshot
{
    UIView *view = objc_getAssociatedObject(self, @"JHAnimationTransitioningTopSnapshot");
    if(!view)
    {
        view = [self.navigationController.view resizableSnapshotViewFromRect:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 64) afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        
        [self setTopSnapshot:view];
    }
    return view;
}
- (void)setTopSnapshot:(UIView *)topSnapshot
{
    objc_setAssociatedObject(self, @"JHAnimationTransitioningTopSnapshot", topSnapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIView *)viewSnapshot
{
    UIView *view = objc_getAssociatedObject(self, @"JHAnimationTransitioningViewSnapshot");
    if (!view)
    {
        view = [self.navigationController.view resizableSnapshotViewFromRect:CGRectMake(0, 64, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]) - 64) afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        [self setViewSnapshot:view];
    }
    return view;
}
- (void)setViewSnapshot:(UIView *)viewSnapshot
{
    objc_setAssociatedObject(self, @"JHAnimationTransitioningViewSnapshot", viewSnapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
///获取截图
- (UIImage *)imageFromView:(UIView *)snapView {
    UIGraphicsBeginImageContext(snapView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [snapView.layer renderInContext:context];
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return targetImage;
}


@end
