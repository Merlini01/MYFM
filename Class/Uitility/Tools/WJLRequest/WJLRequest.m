//
//  WJLRequest.m
//  MyFm
//
//  Created by JiaLiang Wang  on 15/11/5.
//  Copyright © 2015年 JiaLiang Wang . All rights reserved.
//

#import "WJLRequest.h"

@implementation WJLRequest
- (instancetype)init {
    if (self = [super init]) {
        self.downloadData = [[NSMutableData alloc] init];
    }
    return self;
}

- (void)downloadDataWithUrl:(NSString *)urlStr successBlock:(DownloadBlock)block failedBlock:(ErrorBlock)errorBlock {
    
    if (_httpRequest) {
        [_httpRequest cancel];
        _httpRequest = nil;
    }
    self.successBlock = block;
    self.errorBlock = errorBlock;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _httpRequest = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}
#pragma mark - post
- (void)postDataWithurl:(NSString *)urlStr params:(NSString *)paraStr success:(DownloadBlock)successBlock failedBlock:(ErrorBlock)errorBlock{
    if (_httpRequest) {
        [_httpRequest cancel];
        _httpRequest = nil;
    }
    self.successBlock = successBlock;
    self.errorBlock = errorBlock;

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];

    request.HTTPMethod = @"POST";
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSData *data = [paraStr dataUsingEncoding:NSUTF8StringEncoding];
    [request addValue:[NSString stringWithFormat:@"%ld",data.length] forHTTPHeaderField:@"Content-Length"];
    request.HTTPBody = data;
    _httpRequest = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.downloadData.length = 0;
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.downloadData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (self.successBlock) {
 
        self.successBlock(self.downloadData);
    }else {
     
    }
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (self.errorBlock) {
        self.errorBlock(error);
    }
}

@end

