//
//  FirstCatetoryModel.h
//  MyFm
//
//  Created by Qianfeng on 15/10/28.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "BaseModel.h"

@interface FirstCatetoryModel : BaseModel

@property (nonatomic,copy)NSString * id;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * cover;
@property (nonatomic,copy)NSString * speak;
@property (nonatomic,copy)NSString * viewnum;
+ (NSArray *)detailModelList:(NSData *)data;

@end
