//
//  CommentViewController.m
//  MyFm
//
//  Created by Qianfeng on 15/11/4.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "CommentViewController.h"
#import "ThreeTableViewCell.h"
#import "commontModels.h"
#import "DetailTableViewCell.h"


@interface CommentViewController ()
@property (nonatomic)NSArray * dataSource;
@property (nonatomic,assign)NSInteger pageNum;
@property (nonatomic,assign)BOOL isResfreshing;
@property (nonatomic,assign)BOOL isLoadMore;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  NaviBarRightButton];
    self.isLoadMore = NO;
    self.isResfreshing = NO;
    self.pageNum = 10;
    self.title = @"评论详情";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName, nil]];
    [self createTableView];
    [self fetchDataFromServer];
    [self createReFresh];
    [self createPullUp];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)NaviBarRightButton{
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"orange1"] style:UIBarButtonItemStylePlain target:self action:@selector(ReturnClick)];
    self.navigationItem.leftBarButtonItem = left;
}

- (void)createTableView{
        // self.navigationController.navigationBar.hidden = YES;
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, WWidth, WHeight - 64) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.bounces = YES;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ThreeTableViewCell" bundle:nil] forCellReuseIdentifier:@"ThreeTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"DetailTableViewCell"];
}
- (void)ReturnClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ThreeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ThreeTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        [cell showDataWithModel:self.threeModel];
        return cell;
    }
    
        DetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell" forIndexPath:indexPath];
        commontModels * model = self.dataSource[indexPath.row - 1];
        [cell showDataWithModel:model];
        return  cell;

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return WWidth / 3;
    }else{
        commontModels * model = self.dataSource[indexPath.row - 1];
        CGFloat height = [WJLHelper textHeightFromTextString:model.content width:WWidth - WWidth / 8 - 40 fontSize:[WJLFix FontWithScreenWidth:WWidth] + 1];
        return height + 80;
    }
    return WWidth / 3;
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
    return [NSString stringWithFormat:COMMENTSDETIL,self.threeModel.id,self.pageNum];
}

// 解析数据
- (void)parsingDataFrom:(id)responsData {
    self.dataSource = [commontModels detailModelList:responsData];
//    if (self.isResfreshing) {
//        [self.dataSource1 removeAllObjects];
//    }
//    [self.dataSource1 addObjectsFromArray:self.dataSource];
    [MMProgressHUD dismissWithSuccess:@"加载成功"];
    //threeModel * model = self.dataSource[0];
    
}

- (void)createReFresh{
    __weak typeof (self) weakSelf = self;
    [weakSelf.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isResfreshing) {
            return ;
        }
        
        weakSelf.pageNum = 10;
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


@end
