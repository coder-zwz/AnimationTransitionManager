//
//  PopTransition.m
//  自定义Push和Pop的动画效果
//
//  Created by zuweizhong  on 16/6/1.
//  Copyright © 2016年 visoft. All rights reserved.
//

#import "PopTransition.h"

@interface PopTransition ()

@property(nonatomic,strong) id<UIViewControllerContextTransitioning>transitionContext;

@end
@implementation PopTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    return 0.8f;
    
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //不添加的话，屏幕什么都没有
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    /**
     * 要执行的动画
     */
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    
    toVC.view.frame = CGRectOffset(finalFrame, 0, -screenBounds.size.height);
    
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.frame = finalFrame;
        fromVC.view.alpha = 0.8;
    } completion:^(BOOL finished) {
        
        fromVC.view.alpha = 1.0;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"搞定结束");
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    //去除mask
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    
}


@end
