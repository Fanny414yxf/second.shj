//
//  CityViewModel.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/11.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "CityViewModel.h"

@implementation CityViewModel

- (void)getCityList
{
    [NetWorking GetRequeastWithURL:CITY_URL paramDic:nil success:^(id data) {
        [self fetchValueSuccessWithData:data];
    } errorCode:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } fail:^{
        [self netFailure];
    }];
}


#pragma 获取城市列表后，对数据进行处理
- (void)fetchValueSuccessWithData:(id)data;
{
//    LxPrintf(@"开通服务的城市 ----------- %@", data);
    NSArray *statuses = data[@"data"];
    NSMutableArray *cityModelArray = [NSMutableArray array];
    NSMutableArray *cityNameArr = [NSMutableArray array];
    for (NSInteger i = 0; i < [statuses count]; i ++) {
        
        CityModel *model = [[CityModel alloc] init];
        model.number = statuses[i][@"id"];
        model.cityName = statuses[i][@"title"];
        [cityModelArray addObject:model];
        
        [cityNameArr addObject:statuses[i][@"title"]] ;
    }
    
    NSArray *cityList = [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:CITY_LIST]];
    if ([cityList count] == 0) {
        [[NSUserDefaults standardUserDefaults] setObject:cityNameArr forKey:CITY_LIST];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    self.returnBlock(cityModelArray);
}


@end
