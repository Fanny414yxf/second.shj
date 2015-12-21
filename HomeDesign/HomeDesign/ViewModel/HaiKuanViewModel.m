//
//  HaiKuanViewModel.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/21.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "HaiKuanViewModel.h"
#import "HaikuanModel.h"

@implementation HaiKuanViewModel

- (void)getHaiKuanListWithCityID:(NSString*)ID type:(NSNumber *)type row:(NSNumber*)row page:(NSNumber*)page show:(NSString *)show
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:ID forKey:@"id"];
    [dic setObject:type forKey:@"type"];
    [dic setObject:row forKey:@"row"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:show forKey:@"show"];
    [NetWorking GetRequeastWithURL:BASE_URL paramDic:dic success:^(id data) {
        [self fetchValueSuccessWithData:data];
    } errorCode:^(id errorCode) {
        [self errorBlock];
    } fail:^{
        [self failureBlock];
    }];
}


- (void)fetchValueSuccessWithData:(id)data;
{
    NSArray *dataarr = data[@"data"];
    NSMutableArray *modles = [NSMutableArray array];
    for (NSDictionary *dic in dataarr) {
        HaikuanModel *haikuanmodel = [[HaikuanModel alloc] init];
        haikuanmodel.cover_id = dic[@"cover_id"];
        haikuanmodel.create_time = dic[@"create_time"];
        haikuanmodel.descriptionStr = dic[@"description"];
        haikuanmodel.endtime = dic[@"endtime"];
        haikuanmodel.idstr = dic[@"id"];
        haikuanmodel.link_id = dic[@"link_id"];
        haikuanmodel.model_id = dic[@"model_id"];
        haikuanmodel.name = dic[@"name"];
        haikuanmodel.title = dic[@"title"];
        haikuanmodel.update_time = dic[@"update_time"];
        haikuanmodel.view = dic[@"view"];
        [modles addObject:haikuanmodel];
    }
    
    LxPrintf(@"---------%@", data);
    self.returnBlock(modles);
}

@end
