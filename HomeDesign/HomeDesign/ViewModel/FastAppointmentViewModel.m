//
//  FastAppointmentViewModel.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/22.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "FastAppointmentViewModel.h"

@implementation FastAppointmentViewModel

- (void)fasetAppointmentWithTid:(NSInteger)tid loupan:(NSString *)loupan city:(NSString *)city phone:(NSString *)phone mianji:(NSInteger)mianji name:(NSString *)name;
{
    NSString *datastr = [TimeFormatter dateFormatterWithDate_yyyyMMdd:[NSDate date]];
    NSString *tokenMd5 = [EncryptionCodeWithMD5 getmd5_16Bit_String:[NSString stringWithFormat:@"thp7hoiOK%@",datastr]];
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:@"7" forKey:@"type"];
    [paramDic setObject:tokenMd5 forKey:@"token"];
    [paramDic setObject:@(tid) forKey:@"tid"];
    [paramDic setObject:loupan forKey:@"loupan"];
    [paramDic setObject:city forKey:@"city"];
    [paramDic setObject:phone forKey:@"phone"];
    [paramDic setObject:@(mianji) forKey:@"mianji"];
    [paramDic setObject:name forKey:@"name"];
    
    [NetWorking PostRequeastWithURL:BASE_URL paramDic:paramDic success:^(id data) {
        [self fetchValueSuccessWithData:data];
    } errorCode:^(id errorCode) {
        [self errorBlock];
    } fail:^{
        [self failureBlock];
    }];
}


- (void)fetchValueSuccessWithData:(id)data
{
    LxPrintf(@"------------%@", data);
    self.returnBlock(data);
}

@end
