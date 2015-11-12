//
//  SecondViewController.h
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "WJLViewController.h"
#import "SecondScrollerModel.h"

@interface SecondViewController : WJLViewController
@property (nonatomic) NSArray * dataSource;
@property (nonatomic) NSArray * dataSource1;
@property (nonatomic) NSMutableArray * dataSource2;
@property (nonatomic) NSArray * dataSource3;
@property (nonatomic) NSMutableArray * imageArr;
@property (nonatomic) BOOL istable;
@property (nonatomic) NSString * string;
@property (nonatomic) NSString * RadioString;
@property (nonatomic) NSString * oldString;
@property (nonatomic,assign)NSInteger pageNumber;
@property (nonatomic,assign)BOOL isResfreshing;
@property (nonatomic,assign)BOOL isLoadMore;
@property (nonatomic,assign)BOOL radioPlay;
@end
