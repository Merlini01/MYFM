//
//  WJLViewController.m
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "WJLViewController.h"
#import "PlayViewController.h"
@interface WJLViewController ()

@end

@implementation WJLViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self CustomNavigationBar];
    [self createTableView];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
- (void)CustomNavigationBar{
    UINavigationBar * navi = (UINavigationBar *)self.navigationController.navigationBar;
    self.showView = [[UIImageView alloc]initWithFrame:CGRectMake(0, - 64, WWidth, 44)];
    navi.backgroundColor = [UIColor clearColor];
    self.showView.image = [UIImage imageNamed:@"three@2x.png"];
    [navi addSubview:self.showView];
    [navi insertSubview:self.showView atIndex:0];
    [navi setTintColor:[UIColor whiteColor]];

    [navi setBackgroundImage:[UIImage imageNamed:@"touming.png"] forBarMetrics:UIBarMetricsDefault];
    [navi setShadowImage:[UIImage imageNamed:@"touming.png"]];
    
}
- (void)NaviBarLeftButton{
    
}
- (void)NaviBarRightButton{
    
}

// 网络获取数据
- (void)fetchDataFromServer {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    [MMProgressHUD showWithTitle:@"数据加载中"];
    
    NSString *url = [self getNetworkConnectionString];
    [[NetDataEngine sharedInstance]requestMessageFrom:url success:^(id responsData) {
        [MMProgressHUD dismissWithSuccess:@"加载成功" ];
        [self parsingDataFrom:responsData];
    } failed:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"加载失败"];
    }];
}

// 获取网络请求连接
- (NSString *)getNetworkConnectionString {
    return nil;
}

// 解析数据
- (void)parsingDataFrom:(id)responsData {
    
}

#pragma mark -
#pragma 创建tableView
- (void)createTableView{
    
   // self.navigationController.navigationBar.hidden = YES;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,20, WWidth, WHeight - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (void)handleTapgesture:(UIGestureRecognizer *)gesture {
}

- (NSString *)getRightItemImageName {
    return @"littlePlaying";
}

- (void)customNavigationBarRightItem {
    self.imageView = [MyFactory createUIImageView:CGRectMake(0, 0, 18, 17) imageName:[self getRightItemImageName]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapgesture:)];
    [self.imageView addGestureRecognizer:tap];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView: self.imageView];
    self.view.window.rootViewController.navigationItem.rightBarButtonItem = item;
    //self.navigationItem.rightBarButtonItem = item;
    if ([PlayViewController sharedInstance].isPlay) {
        [self.imageView startAnimating];
    }

}
@end


























