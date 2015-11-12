//
//  FirstViewController.m
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstTuiJian.h"
#import "FirstTopCell.h"
#import "FirstrCategoryCell.h"
#import "FirstCatetoryModel.h"
#import "PlayModel.h"
#import "HotTuiJiangTableViewCell.h"
#import "HotTuiJianModel.h"
#import "NewestViewCell.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

-(instancetype)init{
    if (self = [super init]) {
        [self tabBarItemSetting];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.string = @"99388452";
    self.hotString = @"";
    self.radioPlay = NO;
    self.view.backgroundColor = [UIColor grayColor];
    [self addNotification];
    [self fetchDataFromServer];

    [self.tableView registerNib:[UINib nibWithNibName:@"FirstTopCell" bundle:nil] forCellReuseIdentifier:@"FirstTopCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FirstrCategoryCell" bundle:nil] forCellReuseIdentifier:@"FirstrCategoryCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HotTuiJiangTableViewCell" bundle:nil] forCellReuseIdentifier:@"HotTuiJiangTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewestViewCell" bundle:nil] forCellReuseIdentifier:@"NewestViewCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TableClick:) name:@"CategoryTable" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HotClick:) name:@"HotTuiJian" object:nil];
}

- (void)TableClick:(NSNotification *)notification{
    CateTable * cate = [[CateTable alloc]init];
    NSString * CateString = [notification object];
    if (CateString.length > 3) {
        cate.HotOrCatetory = 2;
        cate.NumberId = [notification object];
    }else{
        NSInteger num = [[notification object] integerValue];
        if (num < 5) {
            cate.HotOrCatetory = 1;
        }else if(num >= 40 && num <= 49){
            cate.HotOrCatetory = 0;
        }
        cate.NumberId = [notification object];
    }
    [self.navigationController pushViewController:cate animated:YES];

}
- (void)HotClick:(NSNotification *)notification{
    PlayViewController * play = [PlayViewController sharedInstance];
    //if ([self.hotString isEqualToString:[notification object]]) {
        play.isPlay = YES;
    //}else{
        play.isPlay = NO;
    //}
    self.hotString = [notification object];
    play.PlayId = [notification object];
    [self.navigationController pushViewController:play animated:YES];
    
}
- (NSString *)getTuijianUrl{
    return FIRSTTUIJIANURL;
}

- (void)parsingDataFrom:(id)responsData{
    self.dataSource = [FirstTuiJian detailModelList:responsData];
    self.dataSource1 = [FirstTuiJian detailModelList1:responsData];
    self.dataSource2 = [FirstTuiJian detailModelList2:responsData];
    self.dataSource3 = [FirstTuiJian detailModelList3:responsData];
    [MMProgressHUD dismissWithSuccess:@"加载成功" ];
}
#pragma -mark tabbar
-(void)tabBarItemSetting{
    UITabBarItem * item = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage imageNamed:@"shouyeXiong1"] selectedImage:[UIImage imageNamed:@"shouyeSelectedXiong1"]];
    self.tabBarItem = item;
}
//#pragma -mark tabbar
- (void)fetchDataFromServer {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    [MMProgressHUD showWithTitle:@"加载中"];
    NSString *head = [self getTuijianUrl];
    [[NetDataEngine sharedInstance]requestMessageFrom:head success:^(id responsData) {
    [self parsingDataFrom:responsData];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"加载失败"];
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row == 0) {
        FirstTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstTopCell" forIndexPath:indexPath];
        FirstTuiJian * model = self.dataSource[0];
        [cell showDataWithModel:model];
        return cell;
    }
    if (indexPath.row == 1) {
        FirstrCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstrCategoryCell" forIndexPath:indexPath];
        cell.frame = CGRectMake(0, WWidth + 5, WWidth, WHeight / 7);
        [cell createButton];
        FirstCatetoryModel * model = self.dataSource[0];
        [cell showDataWithModel:model];
        return cell;
    }
    if (indexPath.row == 2) {
        HotTuiJiangTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotTuiJiangTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell showDataWithArray:self.dataSource1];
        return cell;
    }
    if (indexPath.row == 3 || indexPath.row == 4) {
        NewestViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewestViewCell" forIndexPath:indexPath];
        if (indexPath.row == 3) {
            [cell showDataWithArray:self.dataSource2 flag:indexPath.row];
        }else{
            [cell showDataWithArray:self.dataSource3 flag:indexPath.row];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return WWidth / 2;
    }else if(indexPath.row == 1){
        return WHeight / 7;
    }else if(indexPath.row == 2){
        return [WJLFix firstHotFix:WHeight];
    }else if(indexPath.row == 3 || indexPath.row == 4){
        return [WJLFix firstNewFix:WHeight];
    }
    return WHeight / 3;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        PlayViewController * play = [PlayViewController sharedInstance];
        //   打开，点击推荐 不会重新开始
        //    if (play.isPlay == YES) {
        //        self.radioPlay = YES;
        //    }
        play.Myblock = ^(BOOL PlayStatue,NSString * string){
            self.radioPlay = PlayStatue;
            self.string = string;
        };
        
        play.isPlay = NO;
        play.PlayId = self.string;
        [self.navigationController pushViewController:play animated:YES];
    }

 
}



@end























