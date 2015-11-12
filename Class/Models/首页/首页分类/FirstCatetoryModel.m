//
//  FirstCatetoryModel.m
//  MyFm
//
//  Created by Qianfeng on 15/10/28.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

//@property (nonatomic,copy)NSString * id;
//@property (nonatomic,copy)NSString * title;
//@property (nonatomic,copy)NSString * cover;
//@property (nonatomic,copy)NSString * speak;
//@property (nonatomic,copy)NSString * viewnum;
#import "FirstCatetoryModel.h"

@implementation FirstCatetoryModel
@synthesize id = _id;
+ (NSArray *)detailModelList:(NSData *)data{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
     NSArray * arrayData = dic[@"data"];
    for (NSDictionary * dict in arrayData) {
        FirstCatetoryModel * model = [[FirstCatetoryModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [arr addObject:model];
    }
    return arr;
}

@end
