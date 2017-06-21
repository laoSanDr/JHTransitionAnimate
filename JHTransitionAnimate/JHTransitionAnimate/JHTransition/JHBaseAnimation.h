//
//  JHBaseAnimation.h
//  JHTransitionAnimate
//
//  Created by jalaSmart on 17/6/21.
//  Copyright © 2017年 MrChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JHTransition.h"

@interface JHBaseAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign,readonly)UINavigationControllerOperation transitionType;
@property(nonatomic,strong,readwrite)UIPercentDrivenInteractiveTransition *interactivePopTransition;


/**
 *  主要构造方法
 *  @param  transitionType      动画类型 push or pop
 *  @param  duration            间隔时间
 *  @param  animaType           动画方式
 */
- (instancetype)initWithType:(UINavigationControllerOperation)transitionType Duration:(NSTimeInterval)duration
                animateType:(JHAnimateType)animaType;

/**
 *  创建实例对象
 *  @param  transitionType      动画类型 push or pop
 *  @param  animaType           动画方式
 */
+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType animateType:(JHAnimateType)animaType;

/**
 *  创建实例对象
 *  @param  transitionType      动画类型 push or pop
 *  @param  duration            间隔时间
 *  @param  animaType           动画方式
 */
+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType        duration:(NSTimeInterval)duration
                       animateType:(JHAnimateType)animaType;
/**
 *  创建实例对象
 *  @param  transitionType      动画类型 push or pop
 *  @param  duration            间隔时间
 *  @param  interactivePopTransition            可交互属性
 *  @param  animaType           动画方式
 */
+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType        duration:(NSTimeInterval)duration
          interactivePopTransition:(UIPercentDrivenInteractiveTransition *)interactivePopTransition
                       animateType:(JHAnimateType)animaType;


#pragma mark - push pop方法，具体交给子类实现
- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)pushEnded;
- (void)popEnded;

@end
