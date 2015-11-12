//
//  PlayModel.m
//  MyFm
//
//  Created by Qianfeng on 15/10/27.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "PlayModel.h"

@implementation PlayModel
@synthesize id = _id;
+ (NSArray *)detailModelList:(NSData *)data{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary * dict = dic[@"data"];
    PlayModel * model = [[PlayModel alloc]init];
    model.id = dict[@"id"];
    model.title = dict[@"title"];
    model.cover = dict[@"cover"];
    model.speak = dict[@"speak"];
    model.url = dict[@"url"];
    model.duration = [dict[@"duration"] integerValue];
    model.viewnum = dict[@"viewnum"];
    NSDictionary * diantai = dict[@"diantai"];
    model.TCover = diantai[@"cover"];
    model.TContent = diantai[@"content"];
    [arr addObject:model];
    return arr;
}

-(NSURL *)audioFileURL{
    return [NSURL URLWithString:self.url];
}
@end
