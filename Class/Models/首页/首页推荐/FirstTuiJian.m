//
//  FirstTuiJian.m
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "FirstTuiJian.h"

@implementation FirstTuiJian

@synthesize id = _id;
+ (NSArray *)detailModelList:(NSData *)data{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary * dict = dic[@"data"];
    NSArray * arrName = dict[@"tuijian"];
    FirstTuiJian * model = [[FirstTuiJian alloc]init];
    [model setValuesForKeysWithDictionary:arrName[0]];
   
    [arr addObject:model];
    return arr;
}

+ (NSArray *)detailModelList1:(NSData *)data{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary * dict = dic[@"data"];
    NSArray * arrHotfm = dict[@"hotfm"];
    for (NSDictionary * dic1 in arrHotfm) {

        HotTuiJianModel * model = [[HotTuiJianModel alloc]init];
        model.hotfmCover = dic1[@"cover"];
        model.hotfmTitle = dic1[@"title"];
        model.hotfmId = dic1[@"id"];
        [arr addObject:model];
    }
    return arr;
}

+ (NSArray *)detailModelList2:(NSData *)data{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary * dict = dic[@"data"];
    NSArray * arrnewfm = dict[@"newfm"];
    for (NSDictionary * dic1 in arrnewfm) {
        newfmModel * model = [[newfmModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model];
    }
    return arr;
}
+ (NSArray *)detailModelList3:(NSData *)data{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary * dict = dic[@"data"];
    NSArray * arrnewfm = dict[@"newlesson"];
    for (NSDictionary * dic1 in arrnewfm) {
        NewHeartModel * model = [[NewHeartModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model];
    }
    return arr;
}
@end
