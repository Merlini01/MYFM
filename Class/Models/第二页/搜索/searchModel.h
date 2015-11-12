//
//  searchModel.h
//  MyFm
//
//  Created by Qianfeng on 15/11/3.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "BaseModel.h"

@interface searchModel : BaseModel
@property (nonatomic,assign)NSInteger id;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * cover;
@property (nonatomic,copy)NSString * speak;
@property (nonatomic,copy)NSString * viewnum;
+ (NSArray *)detailModelList:(NSData *)data;
@end
