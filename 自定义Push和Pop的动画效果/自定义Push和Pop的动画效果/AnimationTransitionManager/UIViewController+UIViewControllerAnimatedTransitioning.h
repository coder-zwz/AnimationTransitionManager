//
//  UIViewController+UIViewControllerAnimatedTransitioning.h
//  自定义Push和Pop的动画效果
//
//  Created by zuweizhong  on 16/6/1.
//  Copyright © 2016年 visoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InteractiveTrasitionAnimation.h"

@interface UIViewController (UIViewControllerAnimatedTransitioning)<UINavigationControllerDelegate>

/**
 *  是否使用原生push，pop动画，默认为NO，设置请在viewDidLoad中设置
 */
@property (nonatomic, assign)BOOL isOriginalAnimation;

/**
 *  ViewController的手势交互InteractionTransitionAnimation
 */
@property(nonatomic,strong)InteractiveTrasitionAnimation *popInteractive ;


@end
