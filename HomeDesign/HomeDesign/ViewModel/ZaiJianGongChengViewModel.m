//
//  ZaiJianGongChengViewModel.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/21.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "ZaiJianGongChengViewModel.h"
#import "ZaiJianGongChengModel.h"

@implementation ZaiJianGongChengViewModel

- (void)getZaiJianGongChengList:(NSString *)ID type:(NSNumber *)type row:(NSNumber *)row page:(NSNumber *)page show:(NSString *)show;
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:ID forKey:@"id"];
    [dic setObject:type forKey:@"type"];
    [dic setObject:row forKey:@"row"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:show forKey:@"pic"];
   
    [NetWorking GetRequeastWithURL:BASE_URL paramDic:dic success:^(id data) {
        [self fetchValueSuccessWithData:data];
    } errorCode:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } fail:^{
        [self netFailure];
    }];
}


- (void)fetchValueSuccessWithData:(id)data
{
    LxPrintf(@"在建工程----------%@", data);
    NSArray *dataarr = data[@"data"];
    NSMutableArray *models = [NSMutableArray array];
    for (NSDictionary *dic in dataarr) {
        ZaiJianGongChengModel *model = [[ZaiJianGongChengModel alloc] init];
        model.cover_id = dic[@"cover_id"];
        model.create_time = dic[@"create_time"];
        model.descriptionStr = dic[@"description"];
        model.idstring = dic[@"id"];
        model.link_id = dic[@"link_id"];
        model.model_id = dic[@"model_id"];
        model.name = dic[@"name"];
        model.title = dic[@"title"];
        model.update_time = dic[@"update_time"];
        model.view = dic[@"view"];
        [models addObject:model];
    }
    
    self.returnBlock(models);
}

@end
