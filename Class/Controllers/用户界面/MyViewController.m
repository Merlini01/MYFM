//
//  MyViewController.m
//  MyFm
//
//  Created by Qianfeng on 15/11/5.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self NaviBarRightButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)NaviBarRightButton{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName, nil]];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"orange1"] style:UIBarButtonItemStylePlain target:self action:@selector(ReturnClick)];
    self.navigationItem.leftBarButtonItem = left;
    UIView * image = [[UIView alloc]initWithFrame:CGRectMake(10, 64, WWidth - 20, 1)];
    image.backgroundColor = [UIColor grayColor];
    [self.view addSubview:image];
}

- (void)ReturnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
