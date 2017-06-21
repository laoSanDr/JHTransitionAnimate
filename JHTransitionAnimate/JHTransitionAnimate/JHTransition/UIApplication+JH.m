//
//  UIApplication+JH.m
//  JHTransitionAnimate
//
//  Created by jalaSmart on 17/6/21.
//  Copyright © 2017年 MrChen. All rights reserved.
//

#import "UIApplication+JH.h"
#import <objc/runtime.h>
#import "JHTouchManager.h"

@implementation UIApplication (JH)

+ (void)load
{
    Method originMethod     = class_getInstanceMethod(NSClassFromString(@"UIApplication"), @selector(sendEvent:));
    Method newMethod        = class_getInstanceMethod(NSClassFromString(@"UIApplication"), @selector(jh_sendEvent:));
    method_exchangeImplementations(originMethod, newMethod);
}

- (void)jh_sendEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event touchesForWindow:[[UIApplication sharedApplication].delegate window]] anyObject];
    
    CGPoint touchPoint      = [touch locationInView:[[UIApplication sharedApplication].delegate window]];
    
    [JHTouchManager shareManager].touchPoint = touchPoint;
    
    [self jh_sendEvent:event];
}


@end
