//
//  SuccessModel.m
//  MyFm
//
//  Created by Qianfeng on 15/11/5.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "SuccessModel.h"

@implementation SuccessModel

+ (NSArray *)detailModelList:(NSData *)data{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary * dic = dict[@"data"];
    SuccessModel * model = [[SuccessModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    [arr addObject:model];
    return arr;
}

@end
