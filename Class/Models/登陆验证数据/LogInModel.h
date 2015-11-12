//
//  LogInModel.h
//  MyFm
//
//  Created by Qianfeng on 15/11/5.
//  Copyright © 2015年 qianfeng. All rights reserved.
//
//code = 0;
//data =     {
//    avatar = "http://image.xinli001.com//images/avatar.jpg";
//    id = 1000661635;
//    introduce = "<null>";
//    nickname = "@\U6d41\U6c34";
//    "qq_openid" = "";
//    "renren_openid" = "";
//    "sina_openid" = "";
//};
//expire = 1449221954;
//token = b0ca6678d14a741a56f396c01d00a006;
#import "BaseModel.h"

@interface LogInModel : BaseModel

@property (nonatomic,assign)NSInteger  code;
@property (nonatomic,copy)NSString * avatar;
@property (nonatomic,copy)NSString * id;
@property (nonatomic,copy)NSString * nickname;
@property (nonatomic,copy)NSString * updated;
@property (nonatomic,copy)NSString * expire;
@property (nonatomic,copy)NSData * token;


+ (NSArray *)detailModelList:(NSData *)data;

@end
