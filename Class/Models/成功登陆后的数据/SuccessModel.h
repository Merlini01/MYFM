//
//  SuccessModel.h
//  MyFm
//
//  Created by Qianfeng on 15/11/5.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

//"bitcoin": 50,
//"nickname": "@流水",
//"qiandao": false,
//"avatar": "http://image.xinli001.com//images/avatar.jpg",

#import "BaseModel.h"

@interface SuccessModel : BaseModel

@property (nonatomic,assign)NSInteger  bitcoin;
@property (nonatomic,assign)BOOL qiandao;
@property (nonatomic,copy)NSString * nickname;
@property (nonatomic,copy)NSString * avatar;



+ (NSArray *)detailModelList:(NSData *)data;

@end
