//
//  BaseModel.h
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
