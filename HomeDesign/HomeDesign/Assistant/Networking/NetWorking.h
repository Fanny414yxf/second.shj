//
//  NetWorking.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/11.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


//请求成功回调
typedef void (^SuccessBlock)(id data);
//请求失败
typedef void (^FailBlock)();
//错误码
typedef void (^ErrorCodeBlock)(id errorCode);

typedef void (^NetWorkBlock)(BOOL netConnetState);


@interface NetWorking : NSObject

#pragma 监测网络的可链接性
+ (BOOL) netWorkReachabilityWithURLString:(NSString *) strUrl;

/**
 *  是否有网络
 *
 */
+ (BOOL)netWorkReachability;


/**
 *  POST
 *
 *  @param urlStr
 *  @param param   <#param description#>
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
+ (void)PostRequeastWithURL:(NSString *)urlStr
                   paramDic:(NSMutableDictionary *)param
                    success:(SuccessBlock)success
                  errorCode:(ErrorCodeBlock)errorCode
                       fail:(FailBlock)fail;
/**
 *  GET
 *
 *  @param urlStr  <#urlStr description#>
 *  @param param   <#param description#>
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
+ (void)GetRequeastWithURL:(NSString *)urlStr
                  paramDic:(NSMutableDictionary *)param
                   success:(SuccessBlock)success
                 errorCode:(ErrorCodeBlock)errorCode
                      fail:(FailBlock)fail;


@end
