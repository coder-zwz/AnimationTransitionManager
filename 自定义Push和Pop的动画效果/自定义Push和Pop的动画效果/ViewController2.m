//
//  ViewController2.m
//  自定义Push和Pop的动画效果
//
//  Created by zuweizhong  on 16/6/1.
//  Copyright © 2016年 visoft. All rights reserved.
//

#import "ViewController2.h"
#import "ViewController3.h"
#import "UIViewController+UIViewControllerAnimatedTransitioning.h"
@implementation ViewController2

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    self.isOriginalAnimation = NO;
    
    UIButton *btn = [[UIButton alloc]init];
    
    [btn setTitle:@"push2" forState:UIControlStateNormal];
    
    btn.backgroundColor = [UIColor redColor];
    
    btn.frame = CGRectMake(100, 100, 80, 40);
    
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    

}

-(void)push
{
    ViewController3 *vc3 = [[ViewController3 alloc]init];
    NSLog(@"%@",self.popInteractive);
    [self.popInteractive writeToViewcontroller:vc3];
    [self.navigationController pushViewController:vc3 animated:YES];
}
@end
