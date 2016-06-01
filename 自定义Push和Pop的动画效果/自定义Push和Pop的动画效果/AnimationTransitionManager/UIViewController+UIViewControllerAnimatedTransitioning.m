//
//  UIViewController+UIViewControllerAnimatedTransitioning.m
//  自定义Push和Pop的动画效果
//
//  Created by zuweizhong  on 16/6/1.
//  Copyright © 2016年 visoft. All rights reserved.
//

#import "UIViewController+UIViewControllerAnimatedTransitioning.h"
#import <objc/runtime.h>
#import "PushTransiton.h"
#import "PopTransition.h"
#import "InteractionTransitionAnimation.h"
@implementation UIViewController (UIViewControllerAnimatedTransitioning)


+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(swizzled_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(self,originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        
        BOOL success = class_addMethod(self,swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        
        if (success) {
            
            class_replaceMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        }else
        {
            method_exchangeImplementations(originalMethod, swizzledMethod);
            
        }
 
    });
    
    

}
-(void)swizzled_viewWillAppear:(BOOL)animial
{
    [self swizzled_viewWillAppear:animial];
    //初始化
    self.popInteractive = [[InteractiveTrasitionAnimation alloc]init];

    NSLog(@"------%d",self.isOriginalAnimation);
    if (!self.isOriginalAnimation && self.navigationController) {
        
        NSLog(@"%@",self.navigationController);
        
        __weak typeof(self) weakSelf = self;
  
        self.navigationController.delegate = weakSelf;
 
    }
    else
    {
        self.navigationController.delegate = nil;
    }
    
}
/** 返回转场动画实例*/
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return [[PushTransiton alloc]init];
    }
    else if (operation == UINavigationControllerOperationPop){
        return [[PopTransition alloc]init];
    }
    return nil;
}
/** 返回交互手势实例*/
-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                        interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{

    return self.popInteractive.isActing ? self.popInteractive : nil;
}

-(void)setIsOriginalAnimation:(BOOL)isOriginalAnimation
{

    objc_setAssociatedObject(self, @selector(isOriginalAnimation), [NSNumber numberWithBool:isOriginalAnimation], OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
-(BOOL)isOriginalAnimation
{
   
    NSNumber *num  = objc_getAssociatedObject(self, _cmd);
    
    return num.boolValue;
    
}
-(InteractiveTrasitionAnimation *)popInteractive
{
    return objc_getAssociatedObject(self, _cmd);

}
-(void)setPopInteractive:(InteractiveTrasitionAnimation *)popInteractive
{
    
    objc_setAssociatedObject(self, @selector(popInteractive), popInteractive, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

@end
