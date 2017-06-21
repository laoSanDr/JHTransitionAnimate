//
//  UIViewController+AnimationTransitioningSnapshot.h
//  JHTransitionAnimate
//
//  Created by jalaSmart on 17/6/21.
//  Copyright © 2017年 MrChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AnimationTransitioningSnapshot)

/**
 *屏幕快照
 */
@property (nonatomic, strong) UIView *snapshot;

@property(nonatomic,strong)UIView *topSnapshot;

@property(nonatomic,strong)UIView *viewSnapshot;

@property(nonatomic,strong)UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end
