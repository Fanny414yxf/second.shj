//
//  IWantOrderViewModel.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/23.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "IWantOrderViewModel.h"

@implementation IWantOrderViewModel

- (void)IWantOrderRequestWithTid:(NSString *)tid name:(NSString *)name chanpingID:(NSString *)chanpingID phone:(NSString *)phone mianji:(NSString *)mianji ting:(NSString *)ting wei:(NSString *)wei shi:(NSString *)shi
{
    NSString *datastr = [TimeFormatter dateFormatterWithDate_yyyyMMdd:[NSDate date]];
    NSString *tokenMd5 = [EncryptionCodeWithMD5 getmd5_16Bit_String:[NSString stringWithFormat:@"thp7hoiOK%@",datastr]];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@"7" forKey:@"type"];
    [param setObject:tokenMd5 forKey:@"token"];
    [param setObject:tid forKey:@"tid"];
    [param setObject:chanpingID forKey:@"chanping"];
    [param setObject:name forKey:@"name"];
    [param setObject:phone forKey:@"phone"];
    [param setObject:mianji forKey:@"mianji"];
    [param setObject:ting forKey:@"ting"];
    [param setObject:wei forKey:@"wei"];
    [param setObject:shi forKey:@"shi"];
    
    [NetWorking PostRequeastWithURL:BASE_URL paramDic:param success:^(id data) {
        [self fetchValueSuccessWithData:data];
    } errorCode:^(id errorCode) {
        [self errorBlock];
    } fail:^{
        [self failureBlock];
    }];
}


- (void)fetchValueSuccessWithData:(id)data
{
//    LxPrintf(@"我要报价 ------%@", data);
    self.returnBlock(data);
}

@end
