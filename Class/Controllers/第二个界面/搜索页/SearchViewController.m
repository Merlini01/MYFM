//
//  SearchViewController.m
//  MyFm
//
//  Created by Qianfeng on 15/11/3.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "SearchViewController.h"
#import "searchModel.h"
#import "searchViewCell.h"
#import "PlayViewController.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic)UITextField * file;
@property (nonatomic)UIButton * button;
@property (nonatomic)UILabel * label;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic)NSString * searchString;
@property (nonatomic)NSArray *  searchName;
@property (nonatomic,assign)NSInteger pageNum;
@property (nonatomic,assign)BOOL isResfreshing;
@property (nonatomic,assign)BOOL isLoadMore;
@property (nonatomic,strong)NSArray * dataSource;
@property (nonatomic,assign)BOOL isLoadTable;
@property (nonatomic)BOOL radioPlay;
@property (nonatomic)NSString * RadioString;
@end


@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.pageNum = 0;
    self.isLoadMore = NO;
    self.isResfreshing = NO;
    self.isLoadTable = NO;
    [self createTextFileAndButton];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    if (self.RadioString.length != 0) {
       self.navigationController.navigationBarHidden = YES;
    }
}
- (void)createTextFileAndButton{
    self.file = [[UITextField alloc]initWithFrame:CGRectMake(10,35, WWidth - 60, 30)];
    self.file.placeholder = @"输入节目名/主播名";
    self.file.borderStyle = UITextBorderStyleRoundedRect;
    [self.file becomeFirstResponder];
    self.file.delegate = self;
    self.file.returnKeyType = UIReturnKeySearch;
    [self.view addSubview:self.file];
    
    self.button = [MyFactory createButton:CGRectMake(WWidth - 50, 35, 50, 30) title:@"取消" titleColor:[UIColor grayColor] tag:360];
    [self.button addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    [self.view addSubview:self.button];
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, WWidth / 5, WWidth / 5 / 3)];
    self.label.text = @"热门推荐";
    self.label.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] + 3];
    self.label.textColor = [UIColor grayColor];
    [self.view addSubview:self.label];
    self.searchName = @[@"失恋",@"纱朵",@"孤独",@"情绪",@"难过",@"设设",@"高考",@"睡前故事"];
    for (NSInteger num = 0; num < self.searchName.count; num ++) {
        
        UIButton * button = [MyFactory createButton:CGRectMake(5 + WWidth / 6 * num + 25 * num, 70 + WWidth / 15 + 5 , WWidth / 6, WWidth / 15) title:self.searchName[num] titleColor:[UIColor blackColor] tag:370 + num];
        if (num < 4) {
            button.frame = CGRectMake(10 + WWidth / 5.5 * num + 10 * num, 70 + WWidth / 14 + 5 , WWidth / 5.5, WWidth / 14);
        }else if(num >= 4 && num <= 7){
            button.frame = CGRectMake(10 + WWidth / 5.5 * (num - 4) + 10 * (num - 4), 70 + WWidth / 14 + 5 + WWidth / 15 + 15, WWidth / 5.5, WWidth / 14);
        }

        button.titleLabel.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
        button.layer.cornerRadius = WWidth / 6 / 6;
        button.layer.borderWidth = 1;
        [button addTarget:self action:@selector(TuijianSearch:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //self.isSearch = YES;
    self.searchString = textField.text;
    [self fetchDataFromServer];
    if (self.isLoadTable == NO) {
        [self createTableView];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)TuijianSearch:(UIButton *)btn{
    [self.file resignFirstResponder];
    self.searchString = self.searchName[btn.tag - 370];
    self.file.text = self.searchString;
    [self fetchDataFromServer];
    if (self.isLoadTable == NO) {
        [self createTableView];
    }
    
}
- (void)returnClick{
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,70, WWidth, WHeight - 70) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"searchViewCell" bundle:nil] forCellReuseIdentifier:@"searchViewCell"];
    self.isLoadTable = YES;
}


// 网络获取数据
- (void)fetchDataFromServer {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    [MMProgressHUD showWithTitle:@"数据加载中"];
    
    NSString *url = [self getNetworkConnectionString];
    [[NetDataEngine sharedInstance]requestMessageFrom:url success:^(id responsData) {
        [self parsingDataFrom:responsData];
        if (self.dataSource.count == 0) {
            [MMProgressHUD dismissWithError:@"换个节目试试"];
            [self.tableView removeFromSuperview];
            self.isLoadTable = NO;
        }else{
            [self.tableView reloadData];
        }
        
    } failed:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"加载失败"];
    }];
}
// 获取网络请求连接
- (NSString *)getNetworkConnectionString {
    return [NSString stringWithFormat:searchUrl,self.pageNum,self.searchString];
}

// 解析数据
- (void)parsingDataFrom:(id)responsData {
    self.dataSource = [searchModel detailModelList:responsData];
    if (self.dataSource.count ) {
        [MMProgressHUD dismissWithSuccess:@"加载成功"];
    }
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    searchViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"searchViewCell" forIndexPath:indexPath];
    searchModel * model = (searchModel *)self.dataSource[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WHeight / 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.navigationController.navigationBarHidden = NO;
    searchModel * model = (searchModel *)self.dataSource[indexPath.row];
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





















