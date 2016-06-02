//
//  ViewController.m
//  支付Demo
//
//  Created by Mark_Lee on 16/5/22.
//  Copyright © 2016年 MarkLee. All rights reserved.
//

#import "ViewController.h"
#import "MLWechatPay.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *wxPayButton = [[UIButton alloc ] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [wxPayButton setTitle:@"微信支付" forState:UIControlStateNormal];
    [wxPayButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:wxPayButton];
    [wxPayButton addTarget:self action:@selector(wxPay) forControlEvents:UIControlEventTouchDown];
}

- (void)wxPay
{
    [[MLWechatPay shareWechatPay] WXPayWithDic:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
