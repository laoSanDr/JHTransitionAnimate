//
//  JHTransition.m
//  JHTransitionAnimate
//
//  Created by jalaSmart on 17/6/21.
//  Copyright © 2017年 MrChen. All rights reserved.
//

#import "JHTransition.h"
#import "JHBaseAnimation.h"

@interface JHTransition ()

@end

@implementation JHTransition

+ (instancetype)shareManager
{
    static JHTransition *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JHTransition alloc]init];
        manager.isShowShadow = YES;
    });
    return manager;
}

- (void)setAnimationType:(JHAnimateType)animationType withNavigation:(UINavigationController *)navi
{
    self.animationType = animationType;
    if (animationType == JHAnimateTypeDefault)
    {
        navi.delegate = nil;
    }
}
- (void)setAnimationType:(JHAnimateType)animationType
{
    if (animationType == JHAnimateTypeDefault)
    {
        _animationType = JHAnimateTypeDiffNavi;
    }
    else
    {
        _animationType = animationType;
    }
}

#pragma mark - UINavigationDelegate
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(JHBaseAnimation *) animationControlle
{
    return animationControlle.interactivePopTransition;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (fromVC.interactivePopTransition)
    {
        JHBaseAnimation *animation = [[JHBaseAnimation alloc]initWithType:operation Duration:0.6 animateType:self.animationType];
        animation.interactivePopTransition = fromVC.interactivePopTransition;
        return animation; //手势
    }
    else
    {
        JHBaseAnimation *animation = [[JHBaseAnimation alloc]initWithType:operation Duration:0.6 animateType:self.animationType];
        return animation;//非手势
    }
    
}

@end
