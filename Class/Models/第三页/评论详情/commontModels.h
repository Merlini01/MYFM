//
//  commontModels.h
//  MyFm
//
//  Created by Qianfeng on 15/11/4.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

//"id": "691002",
//"user_id": "716570",
//"content": "东北",
//"created": "14分钟前",
//"created_str": "2015-11-04 13:01:45",
//"zannum": "0",
//"replynum": "0",
//"role": "0",
//"role_id": "0",
//"user": {
//    "id": "716570",
//    "nickname": "阿群很想你",
//    "avatar": "http://ossimg.xinli001.com/20151104/3cd4c7003fa824cb5dbd0aa7b2fc35be.jpg"
//},
//"replyuser": null,
//"reply": [],
//"floor": 1510
#import "BaseModel.h"

@interface commontModels : BaseModel

@property (nonatomic,copy)NSString * avatar;
@property (nonatomic,copy)NSString * floor;
@property (nonatomic,copy)NSString * nickname;
@property (nonatomic,copy)NSString * content;
@property (nonatomic,copy)NSString * created;


+ (NSArray *)detailModelList:(NSData *)data;
@end















