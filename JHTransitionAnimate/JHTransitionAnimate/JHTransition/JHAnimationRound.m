//
//  JHAnimationRound.m
//  JHTransitionAnimate
//
//  Created by jalaSmart on 17/6/21.
//  Copyright © 2017年 MrChen. All rights reserved.
//

#import "JHAnimationRound.h"
#import "JHTouchManager.h"

@interface JHAnimationRound ()
@property(nonatomic,weak)id<UIViewControllerContextTransitioning> transitionContext;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL tabbarFlag;
@end

@implementation JHAnimationRound

- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    
    self.isPush                 = YES;
    self.tabbarFlag             = NO;
    self.transitionContext      = transitionContext;
    
    UIViewController *fromVC    = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC      = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration     = [self transitionDuration:transitionContext];
    
    UIView *containView         = [transitionContext containerView];
    
    fromVC.view.hidden          = YES;
    [containView addSubview:fromVC.snapshot];
    [containView addSubview:toVC.view];
    [[toVC.navigationController.view superview] insertSubview:fromVC.snapshot belowSubview:toVC.navigationController.view];
    
    CGRect frame                = CGRectMake([JHTouchManager shareManager].touchPoint.x, [JHTouchManager shareManager].touchPoint.y, 1, 1);
    if (fromVC.tabBarController)
    {
        fromVC.tabBarController.tabBar.hidden = YES;
    }
    
    //    UIBezierPath *startPath     = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:0];
    //    内切圆
    UIBezierPath *startPath     = [UIBezierPath bezierPathWithOvalInRect:frame];
    float radius                = [JHTouchManager shareManager].radius;
    UIBezierPath *endPath       = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(frame, -radius, -radius)];
    //    UIBezierPath *endPath       = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, w_kWidth, w_kHeight)];
    
    CAShapeLayer *maskLayer     = [CAShapeLayer layer];
    maskLayer.path              = endPath.CGPath;
    toVC.navigationController.view.layer.mask        = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue         = (__bridge id _Nullable)(startPath.CGPath);
    animation.toValue           = (__bridge id _Nullable)(endPath.CGPath);
    animation.duration          = duration ;
    animation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.delegate          = self;
    
    [maskLayer addAnimation:animation forKey:@"start"];
    
}

- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.isPush                 = NO;
    self.tabbarFlag             = NO;
    self.transitionContext      = transitionContext;
    
    UIViewController *fromVC    = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC      = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration     = [self transitionDuration:transitionContext];
    if(fromVC.interactivePopTransition)
    {
        duration = duration * 0.66;
    }
    UIView *containView         = [transitionContext containerView];
    
    fromVC.view.hidden          = YES;
    fromVC.navigationController.navigationBar.hidden = YES;
    [containView addSubview:toVC.view];
    [containView addSubview:toVC.snapshot];
    //    [containView sendSubviewToBack:toVC.snapshot];
    [containView addSubview:fromVC.snapshot];
    
    
    if (toVC.tabBarController && toVC == [toVC.navigationController viewControllers].firstObject)
    {
        toVC.tabBarController.tabBar.hidden = YES;
        self.tabbarFlag = YES;
    }
    
    
    CGRect frame                = CGRectMake([JHTouchManager shareManager].touchPoint.x, [JHTouchManager shareManager].touchPoint.y, 1, 1);
    float radiu                 = [JHTouchManager shareManager].radius;
    UIBezierPath *startPath     = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(frame, -radiu, -radiu)];
    UIBezierPath *endPath       = [UIBezierPath bezierPathWithOvalInRect:frame];
    
    CAShapeLayer *maskLayer     = [CAShapeLayer layer];
    maskLayer.path              = endPath.CGPath;
    fromVC.snapshot.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue         = (__bridge id _Nullable)(startPath.CGPath);
    animation.toValue           = (__bridge id _Nullable)(endPath.CGPath);
    animation.duration          = duration;
    animation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.delegate          = self;
    
    [maskLayer addAnimation:animation forKey:@"end"];
    
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    if (self.isPush)
    {
        [self.transitionContext completeTransition:YES];
        UIViewController *fromVC    = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        fromVC.view.hidden = NO;
        [fromVC.snapshot removeFromSuperview];
        [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
        [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
        
        if (self.tabbarFlag)
        {
            fromVC.tabBarController.tabBar.hidden = NO;
        }
        
    }
    else
    {
        UIViewController *fromVC    = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC      = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        toVC.view.hidden            = NO;
        toVC.navigationController.navigationBar.hidden = NO;
        [fromVC.snapshot removeFromSuperview];
        [toVC.snapshot removeFromSuperview];
        fromVC.snapshot             = nil;
        //        updateInteractiveTransition
        
        if (![self.transitionContext transitionWasCancelled])
        {
            toVC.snapshot               = nil;
            [self.transitionContext completeTransition:YES];
            if (self.tabbarFlag)
            {
                toVC.tabBarController.tabBar.hidden = NO;
            }
        }
        else
        {
            fromVC.snapshot.layer.mask = nil;
            fromVC.view.layer.mask = nil;
            fromVC.view.hidden = NO;
            [self.transitionContext completeTransition:NO];
            [[NSNotificationCenter defaultCenter] postNotificationName:JH_CANCEL_POP object:nil];
        }
        
    }
}
- (void)popEnded
{
    NSLog(@"POPEND");
}


@end
