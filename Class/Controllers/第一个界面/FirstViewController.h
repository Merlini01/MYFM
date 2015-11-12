//
//  FirstViewController.h
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "WJLViewController.h"
#import "PlayViewController.h"
#import "CateTable.h"

@interface FirstViewController : WJLViewController
//@property (nonatomic)UIImageView * showView;
@property (nonatomic) NSArray *dataSource;
@property (nonatomic) NSArray *dataSource1;
@property (nonatomic) NSArray *dataSource2;
@property (nonatomic) NSArray *dataSource3;
@property (nonatomic) BOOL radioPlay;
@property (nonatomic) NSString * string;
@property (nonatomic) NSString * hotString;
@end
