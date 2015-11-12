//
//  threeModel.h
//  MyFm
//
//  Created by Qianfeng on 15/11/3.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "BaseModel.h"

@interface threeModel : BaseModel
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
@property (nonatomic,copy)NSString * id;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * content;
@property (nonatomic,copy)NSString * created;
@property (nonatomic,copy)NSString * updated;
@property (nonatomic,copy)NSString * commentnum;
@property (nonatomic,copy)NSString * nickname;
@property (nonatomic,copy)NSString * avatar;

+ (NSArray *)detailModelList:(NSData *)data;
@end
