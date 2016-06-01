//
//  ViewController.m
//  自定义Push和Pop的动画效果
//
//  Created by zuweizhong  on 16/6/1.
//  Copyright © 2016年 visoft. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"
#import "BezierPathTest.h"
#import "UIViewController+UIViewControllerAnimatedTransitioning.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *btn = [[UIButton alloc]init];
    
    [btn setTitle:@"push1" forState:UIControlStateNormal];
    
    btn.backgroundColor = [UIColor redColor];
    
    btn.frame = CGRectMake(100, 100, 80, 40);
    
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
    BezierPathTest *b = [[BezierPathTest alloc]init];

    b.frame = CGRectMake(100, 200, 200, 200);
    
    [self.view addSubview:b];
    
    
    
    

}
-(void)push
{
    ViewController2 *vc2 = [[ViewController2 alloc]init];
    NSLog(@"%@",self.popInteractive);
    [self.popInteractive writeToViewcontroller:vc2];
    [self.navigationController pushViewController:vc2 animated:YES];
}

@end
