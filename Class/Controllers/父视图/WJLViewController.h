//
//  WJLViewController.h
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"


@interface WJLViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)UIImageView * showView;
@property (nonatomic,strong)UITableView * tableView;
- (void)fetchDataFromServer;
// 获取网络请求连接
- (NSString *)getNetworkConnectionString;

// 解析数据
- (void)parsingDataFrom:(id)responsData;
- (void)createTableView;
- (void)NaviBarLeftButton;
- (void)NaviBarRightButton;
- (void)CustomNavigationBar;
//- (void)customNavigationBarRightItem;
@end
