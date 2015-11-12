//
//  SecondScrollerModel.m
//  MyFm
//
//  Created by Qianfeng on 15/11/1.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "SecondScrollerModel.h"

@implementation SecondScrollerModel

+ (NSArray *)detailModelList:(NSData *)data{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray * arrayData = dic[@"data"];
    for (NSDictionary * dict in arrayData) {
        SecondScrollerModel * model = [[SecondScrollerModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [arr addObject:model];
    }
    return arr;
}

@end
