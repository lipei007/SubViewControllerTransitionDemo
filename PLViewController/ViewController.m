//
//  ViewController.m
//  PLViewController
//
//  Created by Jack on 2018/1/17.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "ViewController.h"
#import "TestVC.h"

@interface ViewController ()
{
    TestVC *_nextVC;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self foo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)foo {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 40)];
    [btn setTitle:@"Transition" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(fooClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    _nextVC = [[TestVC alloc] init];
    _nextVC.backgroundColor = [UIColor brownColor];
}

- (void)fooClick:(id)sender {
    UIViewController *tmp = self.currentViewController;
    
    [self showViewController:_nextVC];

    _nextVC = (TestVC *)tmp;
}

@end
