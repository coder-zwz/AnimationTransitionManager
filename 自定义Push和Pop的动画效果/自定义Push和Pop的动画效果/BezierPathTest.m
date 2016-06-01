//
//  BezierPathTest.m
//  自定义Push和Pop的动画效果
//
//  Created by zuweizhong  on 16/6/1.
//  Copyright © 2016年 visoft. All rights reserved.
//

#import "BezierPathTest.h"

@implementation BezierPathTest

- (void) drawRect: (CGRect) rect {
    
    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,200)];
    
    [[UIColor blueColor] setFill];
    
    [p fill]; 
    
}

@end
