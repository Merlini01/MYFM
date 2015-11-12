//
//  NetDataEngine.m
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "NetDataEngine.h"

@interface NetDataEngine ()
@property (nonatomic)AFHTTPRequestOperationManager * manager;
@property (nonatomic,copy) FailedBlock failedBlock;
@end


@implementation NetDataEngine

+ (instancetype)sharedInstance{
    static NetDataEngine * s_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (!s_manager) {
            s_manager = [[NetDataEngine alloc]init];
        }
    });
    return  s_manager;
}
- (instancetype)init{
    if (self = [super init]) {
        _manager = [[AFHTTPRequestOperationManager alloc]init];
        NSSet * set = _manager.responseSerializer.acceptableContentTypes;
        NSMutableSet * mset = [NSMutableSet setWithSet:set];
        [mset addObject:@"text/html"];
        self.manager.responseSerializer.acceptableContentTypes = mset;
    }
    return self;
}
- (void)get:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock{
    NSString * strurl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.manager GET:strurl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

- (void)startNetDataEngine{
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.failedBlock([NSError errorWithDomain:@"网络不通" code:-1000 userInfo:@{NSLocalizedDescriptionKey:@"网络不通"}]);
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.failedBlock([NSError errorWithDomain:@"网络不通" code:-1000 userInfo:@{NSLocalizedDescriptionKey:@"网络不通"}]);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
            default:
                self.failedBlock([NSError errorWithDomain:@"网络不通" code:-1000 userInfo:@{NSLocalizedDescriptionKey:@"网络不通"}]);
                break;
        }
    }];
}

- (void)requestMessageFrom:(NSString *)url success:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock{
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.failedBlock = failedBlock;
    [self startNetDataEngine];
    [self get:url success:successBlock failed:failedBlock];
}


@end


























