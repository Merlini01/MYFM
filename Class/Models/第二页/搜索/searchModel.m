//
//  searchModel.m
//  MyFm
//
//  Created by Qianfeng on 15/11/3.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "searchModel.h"

@implementation searchModel
@synthesize id = _id;
+ (NSArray *)detailModelList:(NSData *)data{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray * arrayData = dic[@"data"];
    for (NSDictionary * dict in arrayData) {
        searchModel * model = [[searchModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [arr addObject:model];
    }
    return arr;
}
@end
