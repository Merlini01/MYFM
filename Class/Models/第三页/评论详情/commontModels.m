//
//  commontModels.m
//  MyFm
//
//  Created by Qianfeng on 15/11/4.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

//@property (nonatomic,copy)NSString * avatar;
//@property (nonatomic,copy)NSString * floor;
//@property (nonatomic,copy)NSString * nickname;
//@property (nonatomic,copy)NSString * content;
//@property (nonatomic,copy)NSString * created;

#import "commontModels.h"

@implementation commontModels

+ (NSArray *)detailModelList:(NSData *)data{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray * arrayData = dic[@"data"];
    for (NSDictionary * dict in arrayData) {
        commontModels * model = [[commontModels alloc]init];
        
        model.created = dict[@"created"];
        model.content = dict[@"content"];
        model.floor = dict[@"floor"];

        NSDictionary * dci1 = dict[@"user"];
        model.nickname = dci1[@"nickname"];
        model.avatar = dci1[@"avatar"];
        [arr addObject:model];
    }
    return arr;
}

@end
