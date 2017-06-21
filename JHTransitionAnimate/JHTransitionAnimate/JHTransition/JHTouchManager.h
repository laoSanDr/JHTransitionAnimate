//
//  JHTouchManager.h
//  JHTransitionAnimate
//
//  Created by jalaSmart on 17/6/21.
//  Copyright © 2017年 MrChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JHTouchManager : NSObject

@property(nonatomic,assign)CGPoint touchPoint;

@property(nonatomic,assign)float radius;

+ (instancetype)shareManager;

@end
