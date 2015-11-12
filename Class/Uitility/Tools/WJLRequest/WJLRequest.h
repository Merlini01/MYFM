//
//  WJLRequest.h
//  MyFm
//
//  Created by JiaLiang Wang on 15/11/5.
//  Copyright © 2015年 JiaLiang Wang . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DownloadBlock)(NSData *downloadData);
typedef void (^ErrorBlock)(NSError *error);

@interface  WJLRequest: NSObject <NSURLConnectionDataDelegate>{
    NSURLConnection *_httpRequest;
}


@property (nonatomic,strong) NSMutableData *downloadData;
@property (nonatomic,copy) DownloadBlock successBlock;
@property (nonatomic,copy) ErrorBlock errorBlock;


- (void)downloadDataWithUrl:(NSString *)urlStr successBlock:(DownloadBlock)block failedBlock:(ErrorBlock)errorBlock;

- (void)postDataWithurl:(NSString *)urlStr
                 params:(NSString *)paraStr
                success:(DownloadBlock)successBlock
            failedBlock:(ErrorBlock)errorBlock;

@end

