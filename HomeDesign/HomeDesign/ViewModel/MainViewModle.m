//
//  MainViewModle.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/18.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "MainViewModle.h"

@implementation MainViewModle


- (void)getMianVCDataWithType:(NSInteger)type cityID:(NSInteger)cityID;
{
    NSMutableDictionary *paramdic = [NSMutableDictionary dictionary];
    [paramdic setObject:@(cityID) forKey:@"id"];
    [paramdic setObject:@(type) forKey:@"type"];
    
    [NetWorking GetRequeastWithURL:BASE_URL paramDic:paramdic success:^(id data) {
        [self fetchValueSuccessWithData:data];
    } errorCode:^(id errorCode) {
        [self errorCodeWithDic:errorCode];
    } fail:^{
        [self netFailure];
    }];
    
}


- (void)getNetworkingForRegisteredWithURL:(NSString *)urlStr paramDic:(NSMutableDictionary *)param success:(SuccessBlock)success fail:(FailBlock)fail
{
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain", nil];
    
    [requestManager GET:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        fail([error localizedDescription]);
    }];
}


- (void)fetchValueSuccessWithData:(id)data;
{
    LxPrintf(@"主页请求结果---------：%@",data);;
    
    NSDictionary *mainViewData = [NSDictionary dictionaryWithDictionary:data[@"data"]];
    
    MainModel *mainModel = [[MainModel alloc] init];
    mainModel.aboutus = mainViewData[@"aboutus"];
    mainModel.news = mainViewData[@"news"];
    mainModel.qiyedongtai = mainViewData[@"qiyedongtai"];
    mainModel.advs = mainViewData[@"lbt"];
    
    mainModel.linbaozhuang = mainViewData[@"lbz"];
    mainModel.linbaozhuangPLUS = mainViewData[@"lbzplus"];
    mainModel.zunxiangjia = mainViewData[@"zxj"];
    mainModel.haikuan = mainViewData[@"haikuan"];
    
    mainModel.threeD = mainViewData[@"3d"];
    mainModel.debiaogongyi = mainViewData[@"dbgy"];
    mainModel.changjianwenti = mainViewData[@"cjwt"];
    mainModel.zaijiangongcheng = mainViewData[@"zjgc"];
    mainModel.woyaobaojia = mainViewData[@"baojia"];
    mainModel.woyaoyouhui = mainViewData[@"youhui"];
    mainModel.zaixianyuyue = mainViewData[@"zxyy"];
    mainModel.quanqiugou = mainViewData[@"qqg"];
    
    self.returnBlock(mainModel);
}

@end
