//
//  RootViewController.m
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "RootViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "PlayViewController.h"

@interface RootViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView * scroller;
@property (nonatomic,strong)UIView * tabBarView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self myInit];
    [self NavigationBar];
    [self AddNotification];

}

- (NSString *)getRightItemImageName {
    return @"littlePlaying";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)AddNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ImageView:) name:@"radioStatue" object:nil];

}
- (void)ImageView:(NSNotification *)notification {
    if ([[notification object] isEqualToString:@"1"]) {
        [self.imageView startAnimating];
    }else{
        [self.imageView stopAnimating];
    }
    

}
- (void)NavigationBar{
    self.navigationController.navigationBar.barStyle =  UIBarStyleDefault;
    self.imageView = [MyFactory createUIImageView:CGRectMake(0, 0, 18, 17) imageName:[self getRightItemImageName]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapgesture:)];
    [self.imageView addGestureRecognizer:tap];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView: self.imageView];
    self.navigationItem.rightBarButtonItem = item;

}
- (void)handleTapgesture:(UIGestureRecognizer *)ges{
    PlayViewController * play = [PlayViewController sharedInstance];
    [self.navigationController pushViewController:play animated:YES];
}
- (void)myInit{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, WWidth, WHeight)];
    self.scroller.bounces = NO;
    self.scroller.pagingEnabled = YES;
    self.scroller.showsHorizontalScrollIndicator = NO;
    self.scroller.contentSize = CGSizeMake(WWidth * 4, WHeight);
    self.scroller.delegate = self;
    [self.view addSubview:self.scroller];
    
    NSArray * controllers = @[@"FirstViewController",@"SecondViewController",@"ThirdViewController",@"FourthViewController"];
    for (int i = 0; i < controllers.count; i ++) {
        BaseViewController * base = [[NSClassFromString(controllers[i]) alloc]init];
        [self addChildViewController:base];
        base.view.frame = CGRectMake(WWidth * i, 0, WWidth, WHeight - 49);
        [self.scroller addSubview:base.view];
    }
    
    self.tabBarView = [[UIView alloc]initWithFrame:CGRectMake(0, WHeight - 49, WWidth, 49)];
    self.tabBarView .backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.tabBarView ];
    
    NSArray * arrName = @[@"首页",@"发现",@"社区",@"我的"];
    NSArray * arrSelected = @[@"shouyeSelectedXiong1",@"faxianSelectedXiong1",@"shequSelectedXiong1",@"shezhiSelectedXiong1"];
    NSArray * arrNormal = @[@"shouyeXiong1",@"faxianXiong1",@"shequXiong1",@"shezhiXiong1"];
    for (int i = 0; i < controllers.count; i ++) {
       UIButton * button = [MyFactory createButton:CGRectMake(WWidth / 4 * i, 0, WWidth / 4, 49) title:arrName[i] NormalImage:[UIImage imageNamed:arrNormal[i]] selectedImage:[UIImage imageNamed:arrSelected[i]] titleColor:[UIColor whiteColor] tint:[UIColor whiteColor]  tag:10 + i];
        [button setImageEdgeInsets:UIEdgeInsetsMake(-15, 0, 0, 0)];

        [button setTitleEdgeInsets:[WJLFix tabBarButtonEdge:WWidth]];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        
        [button addTarget:self action:@selector(TabClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBarView  addSubview:button];
        if (i == 0) {
            button.selected = YES;
        }
    }

}

- (void)TabClick:(UIButton *)btn{
    for (int i = 0; i < 4 ; i++) {
        UIButton * button = (UIButton *)[self.tabBarView viewWithTag:10 + i];
        button.selected = NO;
    }
    btn.selected = YES;
    CGPoint point = self.scroller.contentOffset;
    point.x = (btn.tag - 10) * WWidth;
    self.scroller.contentOffset = point;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    for (int i = 0; i < 4 ; i++) {
        UIButton * button = (UIButton *)[self.tabBarView viewWithTag:10 + i];
        if ((self.scroller.contentOffset.x / WWidth) == i) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }
}
@end
