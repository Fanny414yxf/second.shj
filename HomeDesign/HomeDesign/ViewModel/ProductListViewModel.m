//
//  ProductListViewModel.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/23.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "ProductListViewModel.h"
#import "ProductListMModel.h"


@implementation ProductListViewModel

- (void)getProductListWithType:(NSInteger)type DI:(NSString *)ID show:(NSString *)show;
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@(type) forKey:@"type"];
    ID == nil ? [param setObject:@"0" forKey:@"id"] : [param setObject:ID forKey:@"id"];;
    [param setObject:show forKey:@"show"];
    
    [NetWorking GetRequeastWithURL:BASE_URL paramDic:param success:^(id data) {
        [self fetchValueSuccessWithData:data];
    } errorCode:^(id errorCode) {
        [self errorBlock];
    } fail:^{
        [self failureBlock];
    }];
}


- (void)fetchValueSuccessWithData:(id)data
{
//    LxPrintf(@"产品列表--------%@", data);
    NSArray *dataArr = data[@"data"];
    if (data[@"data"] != [NSNull null]) {
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dic in dataArr) {
            ProductListMModel *model = [[ProductListMModel alloc] init];
            model.cover_id = dic[@"cover_id"];
            model.cp = dic[@"cp"];
            model.create_time = dic[@"create_time"];
            model.descriptionStr = dic[@"description"];
            model.idStr = dic[@"id"];
            model.link_id = dic[@"link_id"];
            model.max = dic[@"max"];
            model.min = dic[@"min"];
            model.model_id = dic[@"model_id"];
            model.msg = dic[@"msg"];
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
