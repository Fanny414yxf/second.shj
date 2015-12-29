//
//  ChangjianWentiViewModel.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/22.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "ChangjianWentiViewModel.h"
#import "ChangjianWentiModel.h"

@implementation ChangjianWentiViewModel

- (void)getChangjianWentiDataWithID:(NSString *)ID  type:(NSNumber *)type row:(NSNumber*)row page:(NSNumber *)page keywords:(NSString *)keywords show:(NSString *)show lei:(NSNumber *)lei
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    ID == nil ? [paramDic setObject:@"0" forKey:@"id"] : [paramDic setObject:ID forKey:@"id"];;
    [paramDic setObject:type forKey:@"type"];
    [paramDic setObject:row forKey:@"row"];
    [paramDic setObject:page forKey:@"page"];
    [paramDic setObject:show forKey:@"show"];
    [paramDic setObject:lei forKey:@"lei"];
    keywords == nil ? nil : [paramDic setObject:keywords forKey:@"keywords"];
//    lei == nil ? nil : [paramDic setObject:lei forKey:@"lei"];

    
    [NetWorking GetRequeastWithURL:BASE_URL paramDic:paramDic success:^(id data){
        [self fetchValueSuccessWithData:data];
    } errorCode:^(id errorCode) {
        [self errorBlock];
    } fail:^{
        [self failureBlock];
    }];
    
}


- (void)fetchValueSuccessWithData:(id)data
{
    LxPrintf(@"data================%@", data);
     NSArray *dataarr = data[@"data"];
    if (![dataarr isEqual:[NSNull null]]) {
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dic in dataarr) {
            ChangjianWentiModel *model = [[ChangjianWentiModel alloc] init];
            model.content = dic[@"content"];
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
    }else{
        self.returnBlock(DATAISNIL);
    }
    
   
}


@end
