//
//  ThirdViewController.m
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ThirdViewController.h"
#import "threeModel.h"
#import "ThreeTableViewCell.h"
#import "CommentViewController.h"

@interface ThirdViewController ()
@property (nonatomic) UISegmentedControl *segment;
@property (nonatomic) BOOL isThree;
@property (nonatomic) NSArray * dataSource;
@property (nonatomic) NSMutableArray * dataSource1;
@property (nonatomic,assign)NSInteger pageNum;
@property (nonatomic,assign)BOOL isResfreshing;
@property (nonatomic,assign)BOOL isLoadMore;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource1 = [[NSMutableArray alloc]init];
    self.pageNum = 0;
    self.isLoadMore = NO;
    self.isResfreshing = NO;
    [self createLabel];
    [self createTableView];
    [self fetchDataFromServer];
    [self createReFresh];
    [self createPullUp];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createLabel{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake((WWidth - 120) / 2, 50, 120, 24)];
    label.text = @"精华";
    label.textColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UIView *vc = [[UIView alloc] initWithFrame:CGRectMake(10, 73, WWidth - 20, 1)];
    vc.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:vc];
}

- (void)createTableView{
    // self.navigationController.navigationBar.hidden = YES;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,84, WWidth, WHeight - 64 - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ThreeTableViewCell" bundle:nil] forCellReuseIdentifier:@"ThreeTableViewCell"];
}

// 网络获取数据
- (void)fetchDataFromServer {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    [MMProgressHUD showWithTitle:@"数据加载中"];
    
    NSString *url = [self getNetworkConnectionString];
    [[NetDataEngine sharedInstance]requestMessageFrom:url success:^(id responsData) {
        [self parsingDataFrom:responsData];
        [self.tableView reloadData];
        [self endRefresh];
    } failed:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"加载失败"];
        [self endRefresh];
    }];
}
// 获取网络请求连接
- (NSString *)getNetworkConnectionString {
    return [NSString stringWithFormat:BEST,self.pageNum];
}

// 解析数据
- (void)parsingDataFrom:(id)responsData {
    self.dataSource = [threeModel detailModelList:responsData];
    if (self.isResfreshing) {
        [self.dataSource1 removeAllObjects];
    }
    [self.dataSource1 addObjectsFromArray:self.dataSource];
    [MMProgressHUD dismissWithSuccess:@"加载成功"];
    //threeModel * model = self.dataSource[0];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource1.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThreeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ThreeTableViewCell" forIndexPath:indexPath];
    threeModel * model = (threeModel *)self.dataSource1[indexPath.row];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    [cell showDataWithModel:model];
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WWidth / 3;
}

- (void)createReFresh{
    __weak typeof (self) weakSelf = self;
    [weakSelf.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isResfreshing) {
            return ;
        }
        
        weakSelf.pageNum = 0;
        [weakSelf fetchDataFromServer];
        weakSelf.isResfreshing = YES;
    }];
}

- (void)createPullUp{
    __weak typeof (self)WeakSelf = self;
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (WeakSelf.isLoadMore) {
            return ;
        }
        WeakSelf.isLoadMore = YES;
        WeakSelf.pageNum += 10;
        [WeakSelf fetchDataFromServer];
        WeakSelf.isLoadMore = YES;
    }];
}
- (void)endRefresh{
    if (self.isResfreshing) {
        self.isResfreshing = NO;
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadMore) {
        self.isLoadMore = NO;
        [self.tableView footerEndRefreshing];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentViewController * comment = [[CommentViewController alloc]init];
    threeModel * model = self.dataSource1[indexPath.row];
    //comment.uid = model.id;
    comment.threeModel = model;
    [self.navigationController pushViewController:comment animated:YES];
}

@end




























