//
//  UIImage+JHImage.h
//  JHTransitionAnimate
//
//  Created by jalaSmart on 17/6/21.
//  Copyright © 2017年 MrChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JHImage)

// 根据颜色和size生成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
