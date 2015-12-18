//
//  MainViewModle.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/18.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "MainViewModle.h"

@implementation MainViewModle


- (void)getMianVCData;
{
    NSMutableDictionary *paramdic = [NSMutableDictionary dictionary];
//    [paramdic setObject:<#(nonnull id)#> forKey:<#(nonnull id<NSCopying>)#>]
    
    [NetWorking GetRequeastWithURL:@"http://shj.chinapeas.com/interface.php?type=4&id=1" paramDic:nil success:^(id data) {
        [self fetchValueSuccessWithData:data];
    } errorCode:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } fail:^{
        [self netFailure];
    }];
}



- (void)fetchValueSuccessWithData:(id)data;
{
    LxPrintf(@"主页请求结果---------：%@",data);;
}

@end
