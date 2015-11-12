//
//  CateTable.h
//  MyFm
//
//  Created by Qianfeng on 15/10/29.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "WJLViewController.h"

@interface CateTable : WJLViewController
@property (nonatomic) NSArray *dataSource;
@property (nonatomic,strong)NSString * NumberId;
@property (nonatomic,assign)NSInteger pageNum;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,assign)BOOL isResfreshing;
@property (nonatomic,assign)BOOL isLoadMore;
@property (nonatomic) BOOL radioPlay;
@property (nonatomic) NSString * string;
@property (nonatomic) NSInteger HotOrCatetory;
@property (nonatomic) NSArray * SecondScroll;
@end
