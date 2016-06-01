//
//  PushTransiton.m
//  自定义Push和Pop的动画效果
//
//  Created by zuweizhong  on 16/6/1.
//  Copyright © 2016年 visoft. All rights reserved.
//

#import "PushTransiton.h"

@interface PushTransiton ()

@property(nonatomic,strong) id<UIViewControllerContextTransitioning>transitionContext;

@end

@implementation PushTransiton

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
     * 要执行的动画(扇形)
     */
//    CGRect originRect = CGRectMake(0, 0, 50, 50);
//    UIBezierPath *maskStartPath = [UIBezierPath bezierPathWithOvalInRect:originRect];
//    UIBezierPath *maskEndPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(originRect, -2000, -2000)];
//    //创建一个CAShapeLayer来负责展示圆形遮盖
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    
//    maskLayer.path = maskEndPath.CGPath;//将他的path指定为最终的path，来避免在动画完成后回弹
//    toVC.view.layer.mask = maskLayer;
//
//    CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
//    maskAnimation.fromValue = (id)maskStartPath.CGPath;
//    maskAnimation.toValue = (id)maskEndPath.CGPath;
//    maskAnimation.duration = [self transitionDuration:transitionContext];
//    maskAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    maskAnimation.fillMode = kCAFillModeForwards;
//    maskAnimation.removedOnCompletion = NO;
//    maskAnimation.delegate = self;
//    [maskLayer addAnimation:maskAnimation forKey:@"Path"];
    /**
     * 要执行的动画
     */
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    
    toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
    
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
