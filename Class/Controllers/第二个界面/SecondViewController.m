//
//  SecondViewController.m
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstCatetoryModel.h"
#import "CateTableViewCell.h"
#import "PlayViewController.h"
#import "SecondModel.h"
#import "SearchViewController.h"

@interface SecondViewController ()<UIScrollViewDelegate>
@property (nonatomic)UIScrollView * scrollerView;
@property (nonatomic)UIPageControl * page;
@property (nonatomic,strong)NSTimer * timer1;
@property (nonatomic)NSInteger number;
@property (nonatomic)UICollectionView * CollectionView;
@property (nonatomic)UIScrollView * leftScroller;
@property (nonatomic)UIButton * searchButton;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArr = [[NSMutableArray alloc]init];
    self.dataSource2 = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.number = 0;
    self.pageNumber = 0;
    self.isLoadMore = NO;
    self.isResfreshing = NO;
    self.istable = NO;
    [self timerInit];
    
    [self createReFresh];
    [self createPullUp];
    [self fetchDataFromServer];
    [self createDataSource];
    [self  createLeftView];
    [self fetchDataFromServer1];
    [self searchButton1];

}

- (void)viewWillAppear:(BOOL)animated{
    //[self searchButton1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)createTableView{
    
    // self.navigationController.navigationBar.hidden = YES;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake( WWidth / 4,WWidth * 0.7 + 40, WWidth - WWidth / 4, WHeight - 29 - WWidth * 0.7) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"CateTableViewCell" bundle:nil] forCellReuseIdentifier:@"CateTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
#pragma mark -
#pragma mark 搜索button
- (void)searchButton1{
    UITextField * file = [[UITextField alloc]initWithFrame:CGRectMake(5, WWidth * 0.7 + 5, WWidth - 10, 30)];
    file.placeholder = @"搜索更多FM";
    file.borderStyle = UITextBorderStyleRoundedRect;
    file.userInteractionEnabled = NO;
    [self.view addSubview:file];
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(WWidth - 10 - 30, 1, 30, 30)];
    image.image = [UIImage imageNamed:@"searchButton"];
    [file addSubview:image];
    _searchButton  = [MyFactory createButton:CGRectMake(0, WWidth * 0.7, WWidth, 40) title:@" " titleColor:[UIColor whiteColor] tag:5000];
    [_searchButton addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_searchButton];
}
- (void)searchClick{
    SearchViewController * search = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}
#pragma mark -
#pragma mark 刷新和加载
- (void)createReFresh{
    __weak typeof (self) weakSelf = self;
    [weakSelf.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isResfreshing) {
            return ;
        }
        
        weakSelf.pageNumber = 0;
        [weakSelf fetchDataFromServer1];
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
        WeakSelf.pageNumber += 15;
        if (WeakSelf.pageNumber >= 30) {
            WeakSelf.pageNumber = 30;
        }
        [WeakSelf fetchDataFromServer1];
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

#pragma mark -
#pragma mark 左侧滚动视图
- (void)createLeftView{
   
    NSArray * colorArr = [MyFactory allColor];
    self.leftScroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, WWidth * 0.7 + 40, WWidth / 4, WHeight - 29 - WWidth * 0.7)];
    self.leftScroller.contentSize = CGSizeMake(WWidth / 4, WWidth / 11 * 18 + 220);
    self.leftScroller.showsVerticalScrollIndicator = NO;
    self.leftScroller.backgroundColor = [UIColor whiteColor];
    //rect.origin.x + rect.size.width
    //WWidth / 4 - rect.size.width - 15
    for (NSInteger i = 0; i < 18; i ++) {
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10 + WWidth / 11 * i + 10 * i , WWidth / 11, WWidth / 11)];
        image.image = (UIImage *)self.dataSource2[i];
        [self.leftScroller addSubview:image];
        CGRect rect = image.frame;
        UIButton * button = [MyFactory createButton:CGRectMake(0, rect.origin.y + 5, WWidth / 4, rect.size.height / 3 * 2) title:[NSString stringWithFormat:@"%@",self.dataSource1[i]] titleColor:colorArr[i] tag:300 + i];
        button.titleLabel.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] + 3];
        
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(SecondClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.leftScroller addSubview:button];
    }
        [self.view addSubview:self.leftScroller];
}

- (void)SecondClick:(UIButton *)button{
    self.string = self.dataSource1[button.tag - 300];
    self.isResfreshing = YES;
    [self fetchDataFromServer1];
}
- (void)createDataSource{
    NSString * strPath1 = [[NSBundle mainBundle]pathForResource:@"SecondListName" ofType:@"plist"];
    self.dataSource1 = [[NSArray alloc]initWithContentsOfFile:strPath1];
    NSString * strPath2 = [[NSBundle mainBundle]pathForResource:@"SecondListImage" ofType:@"plist"];
    NSArray * arrImage = [[NSArray alloc]initWithContentsOfFile:strPath2];
    for (NSInteger numImage = 0; numImage < arrImage.count; numImage ++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",arrImage[numImage]]];
        [self.dataSource2 addObject:image];
    }

}
#pragma mark -
#pragma mark 滚动视图
- (void)myScrollerView{
    self.scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WWidth, WWidth * 0.7)];
    self.scrollerView.delegate = self;
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.pagingEnabled = YES;
    self.scrollerView.contentSize = CGSizeMake(WWidth * 3, WWidth * 0.7);
    [self.view addSubview:self.scrollerView];
    for (NSInteger i = 0; i < 3; i ++) {
        UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GesClick)];
        UIImageView * image = (UIImageView *)self.imageArr[i];
        image.frame = CGRectMake(WWidth * i,0,WWidth , WWidth * 0.7);
        image.userInteractionEnabled = YES;
        [image addGestureRecognizer:ges];
        [self.scrollerView addSubview:image];
    }
    self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, WWidth * 0.7 - 15, WWidth, 10)];
    self.page.numberOfPages = 3;
    self.page.currentPage = 0;
    self.page.currentPageIndicatorTintColor = [UIColor orangeColor];
    self.page.pageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:self.page];
}

- (void)GesClick{
    [_searchButton removeFromSuperview];
    NSInteger num = self.scrollerView.contentOffset.x / WWidth;
    SecondScrollerModel * model = (SecondScrollerModel *)self.dataSource[num];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CategoryTable" object:model.name];

    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.page.currentPage = self.scrollerView.contentOffset.x / WWidth;
}

#pragma mark -
#pragma mark 定时器初始化
- (void)timerInit{
    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}
- (void)updateTimer{
    static NSInteger flag = 1;
    if (self.number == 0) {
        flag = 1;
    }else if(self.number == 2){
        flag = -1;
    }
    self.number += flag;
    [self.scrollerView setContentOffset:CGPointMake(self.number * WWidth, 0.0f) animated:YES];
    self.page.currentPage = self.number;
    
}
#pragma mark -
#pragma mark 网络请求
- (void)fetchDataFromServer {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    [MMProgressHUD showWithTitle:@"数据加载中"];
    
    NSString *url = [self getNetworkConnectionString];
    [[NetDataEngine sharedInstance]requestMessageFrom:url success:^(id responsData) {
        [self parsingDataFrom:responsData];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"加载失败"];
    }];
    
}

- (void)fetchDataFromServer1 {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    [MMProgressHUD showWithTitle:@"数据加载中"];
    if (self.string.length == 0) {
        self.string = @"睡前";
    }
    NSArray *array = [self.string componentsSeparatedByString:@" "];
     NSString *url =  [NSString stringWithFormat:FINDDETAIL,self.pageNumber,[array lastObject]];
    [[NetDataEngine sharedInstance]requestMessageFrom:url success:^(id responsData) {
        [self parsingDataFrom1:responsData];
        [self.tableView reloadData];
        [self endRefresh];
    } failed:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"加载失败"];
        [self endRefresh];
    }];
    
}
// 获取网络请求连接
- (NSString *)getNetworkConnectionString {
        return FINDSCROLL;
}

// 解析数据
- (void)parsingDataFrom:(id)responsData {
        self.dataSource = [SecondScrollerModel detailModelList:responsData];
        [MMProgressHUD dismissWithSuccess:@"加载成功" ];
        if (self.dataSource.count) {
            for (NSInteger i = 0; i < self.dataSource.count; i ++) {
                SecondScrollerModel * model = (SecondScrollerModel *)self.dataSource[i];
                UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WWidth, WWidth / 2)];
                [image sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"noDownloadedImage"]];
                [self.imageArr addObject:image];
            }
            
        }
        [self myScrollerView];
}

- (void)parsingDataFrom1:(id)responsData {
        self.dataSource3 = [SecondModel detailModelList:responsData];
    [MMProgressHUD dismissWithSuccess:@"加载成功"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource3.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CateTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CateTableViewCell" forIndexPath:indexPath];
    SecondModel * model = self.dataSource3[indexPath.row];
    [cell showDataWithModel:model];
    CGRect rect = cell.Cover.frame;
    rect.size.width = WWidth / 6;
    rect.size.height = WWidth / 6;
    rect.origin.y = 5;
    cell.Cover.frame = rect;
    cell.Cover.layer.masksToBounds = YES;
    cell.Cover.layer.cornerRadius = 10;

    CGRect rect1 = cell.title.frame;
    rect1.origin.y = rect.origin.y ;
    rect1.size.height = [WJLFix secondTableLabelHeightFix:WHeight];
    rect1.origin.x = rect.origin.x + rect.size.width + 10;
    cell.title.frame = rect1;
    
    CGRect rect2 = cell.speak.frame;
    rect2.origin.x = rect1.origin.x;
    rect2.size.height = [WJLFix secondTableLabelHeightFix:WHeight];
    rect2.origin.y = rect1.origin.y + rect1.size.height;
    cell.speak.frame = rect2;
    
    CGRect rect3 = cell.number.frame;
    rect3.origin.y = rect2.origin.y + rect2.size.height;
    rect3.size.height = [WJLFix secondTableLabelHeightFix:WHeight];
    rect3.origin.x = rect1.origin.x;
    cell.number.frame = rect3;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WWidth / 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_searchButton removeFromSuperview];
    SecondModel * model = (SecondModel *)self.dataSource3[indexPath.row];

    PlayViewController * play = [PlayViewController sharedInstance];
    if (play.Myblock) {
        play.Myblock = ^(BOOL PlayStatue,NSString * string){
            self.radioPlay = PlayStatue;
            self.RadioString = string;
        };
    }
    if (self.RadioString.length == 0) {
        self.RadioString = [NSString stringWithFormat:@"%lu",model.id];
    }else{
        NSString * str = [NSString stringWithFormat:@"%lu",model.id];
        if ( [str isEqualToString:self.RadioString]) {
            self.radioPlay = YES;
        }else{
            self.radioPlay = NO;
            self.RadioString = [NSString stringWithFormat:@"%lu",model.id];
        }
    }
    play.isPlay = self.radioPlay;
    play.PlayId = self.RadioString;
    [self.navigationController pushViewController:play animated:YES];
}
@end
















