//
//  JHTransition.h
//  JHTransitionAnimate
//
//  Created by jalaSmart on 17/6/21.
//  Copyright © 2017年 MrChen. All rights reserved.
//

#import "UIViewController+AnimationTransitioningSnapshot.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kHeight [[UIScreen mainScreen] bounds].size.height
#define kWidth [[UIScreen mainScreen] bounds].size.width

///取消右滑返回发的通知
#define JH_CANCEL_POP @"JH_CANCEL_POP_NOTIFICATION"
typedef NS_ENUM(NSInteger,JHAnimateType)
{
    JHAnimateTypeDefault = 0,
    /// 两个导航栏不一致
    JHAnimateTypeDiffNavi,
    ///仿酷狗
    JHAnimateTypeKuGou,
    ///圆形遮罩
    JHAnimateTypeRound,
    ///椭圆遮罩
    JHAnimateTypeOval,
    ///仿斗鱼
    JHAnimateTypeDouYu,
};

@interface JHTransition : NSObject <UINavigationControllerDelegate>

///动画类型
@property(nonatomic,assign)JHAnimateType animationType;

///是否显示阴影 (默认YES)
@property(nonatomic,assign)BOOL isShowShadow;

+ (instancetype)shareManager;

/**
 *  设置动画方式
 *  @param animationType 动画方式
 *  @param navi 导航
 */
- (void)setAnimationType:(JHAnimateType)animationType
          withNavigation:(UINavigationController *)navi;

@end
