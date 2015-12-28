//
//  GlobalViewModel.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/24.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "GlobalViewModel.h"

@implementation GlobalViewModel

- (void)getGlobalRequestWithType:(NSString *)type ID:(NSString *)ID
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:type forKey:@"type"];
    [paramDic setObject:ID forKey:@"id"];
    [NetWorking GetRequeastWithURL:BASE_URL paramDic:paramDic success:^(id data) {
        [self fetchValueSuccessWithData:data];
    } errorCode:^(id errorCode) {
        [self errorBlock];
    } fail:^{
        [self errorBlock];
    }];
}


- (void)fetchValueSuccessWithData:(id)data;
{
    LxPrintf(@"全球购=======%@", data);
    NSArray *dataarr = [NSArray arrayWithArray:data[@"data"]];
    if (data[@"data"] != [NSNull null]) {
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dic in dataarr) {
            GlobalModel *model = [[GlobalModel alloc] init];
            model.cover_id = dic[@"cover_id"];
            model.create_time = dic[@"create_time"];
            model.descriptionStr = dic[@"description"];
            model.idString = dic[@"id"];
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
        self.returnBlock(data[@"flag"]);
    }
}

@end
