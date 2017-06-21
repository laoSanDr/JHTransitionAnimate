//
//  JHBaseAnimation.m
//  JHTransitionAnimate
//
//  Created by jalaSmart on 17/6/21.
//  Copyright © 2017年 MrChen. All rights reserved.
//

#import "JHBaseAnimation.h"
#import "JHAnimationDefault.h"
#import "JHAnimationDiffNavi.h"
#import "JHAnimationKuGou.h"
#import "JHAnimationOval.h"
#import "JHAnimationRound.h"
#import "JHAnimationDouYu.h"

const static NSTimeInterval DefauleAnimationDuration = 0.6;

@interface JHBaseAnimation ()

@property(nonatomic,assign)NSTimeInterval duration;
@property(nonatomic,assign,readwrite)UINavigationControllerOperation transitionType;

@end

@implementation JHBaseAnimation

///构造实例
- (instancetype)initWithType:(UINavigationControllerOperation)transitionType Duration:(NSTimeInterval)duration animateType:(JHAnimateType)animaType
{
    switch (animaType)
    {
        case JHAnimateTypeDefault:
        {
            self = [[JHAnimationDefault alloc]init];
        }
            break;
        case JHAnimateTypeDiffNavi:
        {
            self = [[JHAnimationDiffNavi alloc]init];
        }
            break;
        case JHAnimateTypeKuGou:
        {
            self = [[JHAnimationKuGou alloc]init];
        }
            break;
        case JHAnimateTypeRound:
        {
            self = [[JHAnimationRound alloc]init];
        }
            break;
        case JHAnimateTypeOval:
        {
            self = [[JHAnimationOval alloc]init];
        }
            break;
        case JHAnimateTypeDouYu:
        {
            self = [[JHAnimationDouYu alloc]init];
        }
            break;
        default:
            break;
    }
    
    if (self)
    {
        self.duration       = duration;
        self.transitionType = transitionType;
    }
    return self;
}

+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType animateType:(JHAnimateType)animaType
{
    return [self transitionWithType:transitionType duration:DefauleAnimationDuration animateType:animaType];
}

+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType duration:(NSTimeInterval)duration animateType:(JHAnimateType)animaType
{
    return [self transitionWithType:transitionType duration:duration interactivePopTransition:nil animateType:animaType];
}

+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType duration:(NSTimeInterval)duration interactivePopTransition:(UIPercentDrivenInteractiveTransition *)interactivePopTransition animateType:(JHAnimateType)animaType
{
    JHBaseAnimation *animation = [[self alloc]initWithType:transitionType Duration:duration animateType:animaType];
    animation.interactivePopTransition = interactivePopTransition;
    return animation;
}

- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext{}
- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext{}
- (void)pushEnded{}
- (void)popEnded{}

#pragma mark - UIViewControllerAnimationTransition


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (self.transitionType == UINavigationControllerOperationPush)
    {
        [self push:transitionContext];
    }
    else if (self.transitionType == UINavigationControllerOperationPop)
    {
        [self pop:transitionContext];
    }
}

- (void)animationEnded:(BOOL)transitionCompleted
{
    if (!transitionCompleted)
    {
        return;
    }
    if (self.transitionType == UINavigationControllerOperationPush)
    {
        [self pushEnded];
    }
    else if (self.transitionType == UINavigationControllerOperationPop)
    {
        [self popEnded];
    }
}

- (void)dealloc
{
    NSLog(@"%@释放",[self class]);
}


@end
