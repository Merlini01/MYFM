//
//  threeModel.m
//  MyFm
//
//  Created by Qianfeng on 15/11/3.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "threeModel.h"
//"id": "327",
//"user_id": "29247207",
//"title": "你在哪个瞬间决定要放弃ta了？",
//"content": "说说，你在哪个瞬间决定要放弃ta了？",
//"created": "6月前",
//"updated": "刚刚",
//"jin": "0",
//"commentnum": "2080",
//"user": {
//    "id": "29247207",
//    "nickname": "墨无画",
//    "avatar": "http://image.xinli001.com//20141229/010122/831437.jpg!80"
//},
//"absolute_url": "http://yiapi.xinli001.com/fm/forum-share-page/327",
//"images": []
//@property (nonatomic,copy)NSString * id;
//@property (nonatomic,copy)NSString * title;
//@property (nonatomic,copy)NSString * content;
//@property (nonatomic,copy)NSString * created;
//@property (nonatomic,copy)NSString * updated;
//@property (nonatomic,copy)NSString * commentnum;

//@property (nonatomic,copy)NSString * nickname;
//@property (nonatomic,copy)NSString * avatar;
@implementation threeModel
@synthesize id = _id;
+ (NSArray *)detailModelList:(NSData *)data{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray * arrayData = dic[@"data"];
    for (NSDictionary * dict in arrayData) {
        threeModel * model = [[threeModel alloc]init];
        model.id = dict[@"id"];
        model.title = dict[@"title"];
        model.content = dict[@"content"];
        model.created = dict[@"created"];
        model.updated = dict[@"updated"];
        model.commentnum = dict[@"commentnum"];
        NSDictionary * dci1 = dict[@"user"];
        model.nickname = dci1[@"nickname"];
        model.avatar = dci1[@"avatar"];
        [arr addObject:model];
    }
    return arr;
}
@end
