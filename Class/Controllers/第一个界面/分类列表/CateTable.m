//
//  CateTable.m
//  MyFm
//
//  Created by Qianfeng on 15/10/29.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "CateTable.h"
#import "FirstCatetoryModel.h"
#import "CateTableViewCell.h"
#import "PlayViewController.h"
#import "SecondScrollerModel.h"

@interface CateTable ()
//@property (nonatomic)UIImageView * showView;
@end

@implementation CateTable

- (void)viewDidLoad {
    [super viewDidLoad];
    [self myInit];
    [self createTableView];
    [self NaviBarRightButton];
    [self createReFresh];
    [self createPullUp];
    [self.tableView registerNib:[UINib nibWithNibName:@"CateTableViewCell" bundle:nil] forCellReuseIdentifier:@"CateTableViewCell"];
    [self fetchDataFromServer];
   
}

- (void)myInit{
    NSArray * titleName = @[@"自我成长",@"情绪管理",@"人际沟通",@"恋爱婚姻",@"职场管理",@"亲子家庭",@"心理科普",@"课程讲座",@"更多FM",@"更多心理课"];
    if (self.NumberId.length > 2 ) {
        self.title = self.NumberId;
    }else{
        if ([self.NumberId integerValue]< 10) {
            self.title = titleName[[self.NumberId integerValue] + 5];
        }else{
            self.title = titleName[[self.NumberId integerValue] - 40];
        }
    }

    
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 1;
    self.pageNum = 20;
    self.isLoadMore = NO;
    self.isResfreshing = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createTableView{
    // self.navigationController.navigationBar.hidden = YES;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, WWidth, WHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)createReFresh{
    __weak typeof (self) weakSelf = self;
    [weakSelf.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isResfreshing) {
            return ;
        }

        weakSelf.page = 1;
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
        if (self.HotOrCatetory == 2) {
            WeakSelf.isLoadMore = YES;
            [WeakSelf fetchDataFromServer];
        }else{
            
            WeakSelf.isLoadMore = YES;
            WeakSelf.pageNum += 20;
            [WeakSelf fetchDataFromServer];
        }

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
- (void)NaviBarRightButton{
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"orange1"] style:UIBarButtonItemStylePlain target:self action:@selector(ReturnClick)];
    self.navigationItem.leftBarButtonItem = left;

}

- (void)ReturnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)fetchDataFromServer {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    [MMProgressHUD showWithTitle:@"加载中"];
    NSString *head = [self getNetworkConnectionString];
        [[NetDataEngine sharedInstance]requestMessageFrom:head success:^(id responsData) {
            [self parsingDataFrom:responsData];
            [self.tableView reloadData];
            [self endRefresh];
        } failed:^(NSError *error) {
            [MMProgressHUD dismissWithError:@"加载失败"];
            [self endRefresh];
        }];


}
- (void)parsingDataFrom:(id)responsData{
    self.dataSource = [FirstCatetoryModel detailModelList:responsData];
    [MMProgressHUD dismissWithSuccess:@"加载成功" ];
}

- (NSString *)getNetworkConnectionString{

    if (self.HotOrCatetory == 1) {
        NSInteger num = [self.NumberId integerValue];
        if (num == 3) {
            return [NSString stringWithFormat:MOREFM,num - 3];
        }
        if (num == 4) {
            return [NSString stringWithFormat:MOREXINLI,num - 3];
        }
    }
    else if(self.HotOrCatetory == 2){
            NSString * str = [NSString stringWithFormat:FINDDETAIL,0,self.NumberId];
            return str;
        }else if(self.HotOrCatetory == 0){

            return [NSString stringWithFormat:CATETABLE,[self.NumberId integerValue] - 39,self.pageNum];
        }

    return nil;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CateTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CateTableViewCell" forIndexPath:indexPath];
    FirstCatetoryModel * model = self.dataSource[indexPath.row];
    [cell showDataWithModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return WHeight / 8;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayViewController * play = [PlayViewController sharedInstance];
    FirstCatetoryModel * model = self.dataSource[indexPath.row];
    
    play.Myblock = ^(BOOL PlayStatue,NSString * string){
        self.radioPlay = PlayStatue;
        self.string = string;
    };
    if ([self.string isEqualToString:@""]) {
        self.string = model.id;
    }
    
    if (self.HotOrCatetory == 2) {
        if ([[NSString stringWithFormat:@"%@",model.id] isEqualToString:self.string]) {
            self.radioPlay = YES;
        }else{
            self.radioPlay = NO;
            self.string = model.id;
        }
    }else{
        if ([model.id isEqualToString:self.string]) {
            self.radioPlay = YES;
        }else{
            self.radioPlay = NO;
            self.string = model.id;
        }
    }


    play.isPlay = self.radioPlay;
    play.PlayId = self.string;
    [self.navigationController pushViewController:play animated:YES];
}
@end
