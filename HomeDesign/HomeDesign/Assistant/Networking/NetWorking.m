//
//  NetWorking.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/11.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "NetWorking.h"


@implementation NetWorking


#pragma 监测网络的可链接性
+ (BOOL) netWorkReachabilityWithURLString:(NSString *) strUrl
{
    __block BOOL netState = NO;
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                netState = YES;
                break;
             case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
    return netState;
}


+ (void)PostRequeastWithURL:(NSString *)urlStr paramDic:(NSMutableDictionary *)param success:(SuccessBlock)success errorCode:(ErrorCodeBlock)errorCode fail:(FailBlock)fail;
{
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain", nil];
    [requestManager POST:urlStr parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        fail([error localizedDescription]);
    }];
}


+ (void)GetRequeastWithURL:(NSString *)urlStr paramDic:(NSMutableDictionary *)param success:(SuccessBlock)success errorCode:(ErrorCodeBlock)errorCode fail:(FailBlock)fail;
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain", nil];
    
    [manager GET:urlStr parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        fail([error localizedDescription]);
    }];
}


@end
