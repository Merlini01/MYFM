//
//  FirstTuiJian.h
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "BaseModel.h"
#import "HotTuiJianModel.h"
#import "newfmModel.h"
#import "NewHeartModel.h"

@interface FirstTuiJian : BaseModel
//{
//    "id": "48",
//    "title": "夏洛特烦恼",
//    "cover": "http://image.xinli001.com/20151026/101256ss8sbqbpns68vjxa.jpg",
//    "value": "99388452",
//    "type": "fm",
//    "sort": "42"
//}
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * value;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * sort;




+ (NSArray *)detailModelList:(NSData *)data;
+ (NSArray *)detailModelList1:(NSData *)data;
+ (NSArray *)detailModelList2:(NSData *)data;
+ (NSArray *)detailModelList3:(NSData *)data;
@end














