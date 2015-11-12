//
//  NetDataEngine.h
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock) (id responsData);
typedef void(^FailedBlock) (NSError * error);
@interface NetDataEngine : NSObject

+ (instancetype)sharedInstance;

- (void)requestMessageFrom:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock;
@end
