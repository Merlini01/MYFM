//
//  SecondModel.m
//  MyFm
//
//  Created by Qianfeng on 15/11/2.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "SecondModel.h"

@implementation SecondModel
@synthesize id = _id;
+ (NSArray *)detailModelList:(NSData *)data{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray * arrayData = dic[@"data"];
    for (NSDictionary * dict in arrayData) {
        SecondModel * model = [[SecondModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [arr addObject:model];
    }
    return arr;
}
@end
