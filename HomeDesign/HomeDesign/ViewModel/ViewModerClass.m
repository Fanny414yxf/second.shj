//
//  ViewModerClass.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/11.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "ViewModerClass.h"

@implementation ViewModerClass
#pragma 获取网络可到达状态
- (void)netWorkStateWithNetConnectBlock:(NetWorkBlock)netConnectBlock WithURlStr:(NSString *)strURl
{
    BOOL netState = [NetWorking netWorkReachabilityWithURLString:strURl];
    netConnectBlock(netState);
}
#pragma 接收穿过来的block
- (void)setBlockWithReturnBlock:(SuccessBlock)returnBlock WithErrorBlock:(ErrorCodeBlock)errorBlock WithFailureBlock:(FailBlock)failureBlock
{
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
    _failureBlock = failureBlock;
}



#pragma 对ErrorCode进行处理
-(void) errorCodeWithDic:(NSDictionary *)errorDic
{
    LxPrintf(@"返回错误%@",errorDic);
    self.errorBlock(errorDic);
}

#pragma 对网路异常进行处理
-(void)netFailure
{
    LxPrintf(@"网络异常");
    self.failureBlock();
}



@end
