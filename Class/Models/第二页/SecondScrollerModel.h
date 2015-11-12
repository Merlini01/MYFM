//
//  SecondScrollerModel.h
//  MyFm
//
//  Created by Qianfeng on 15/11/1.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "BaseModel.h"

@interface SecondScrollerModel : BaseModel
@property (nonatomic,copy)NSString * cover;
@property (nonatomic,copy)NSString * name;
+ (NSArray *)detailModelList:(NSData *)data;
@end
