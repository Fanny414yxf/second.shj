//
//  ConstructionSiteViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/4.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "ConstructionSiteViewController.h"
#import "ConstructionSiteCell.h"
#import "ZaiJianGongChengModel.h"
#import "ZaiJianGongChengViewModel.h"
#import "ConstructionSiteDetailViewController.h"

@interface ConstructionSiteViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *listData;
    NSInteger currenPage;
    BOOL isPullOnLoading;//是否为上拉加载
}

@property (nonatomic, strong) UITableView *constructionSiteTableview;

@end

@implementation ConstructionSiteViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self networkingWithPage:currenPage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"在建工地";
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    currenPage = 1;
    isPullOnLoading = NO;
    listData = [NSMutableArray array];
    
    _constructionSiteTableview = [[UITableView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
    _constructionSiteTableview.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    _constructionSiteTableview.delegate = self;
    _constructionSiteTableview.dataSource = self;
    _constructionSiteTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _constructionSiteTableview.showsVerticalScrollIndicator = NO;
    [_constructionSiteTableview registerClass:[ConstructionSiteCell class] forCellReuseIdentifier:@"constructionsCell"];
    [_constructionSiteTableview registerClass:[NoDataCellTableViewCell class] forCellReuseIdentifier:@"nodatacell"];
    [self.view addSubview:_constructionSiteTableview];
    
    _constructionSiteTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDownRefresh)];
    [_constructionSiteTableview.mj_header beginRefreshing];
}


//下拉刷新
- (void)dropDownRefresh
{
    currenPage = 1;
    isPullOnLoading = NO;
    [self networkingWithPage:currenPage];
    
}
//上拉加载
- (void)pullOnLoading:(NSInteger)page
{
    currenPage ++;
    isPullOnLoading = YES;
    [self networkingWithPage:currenPage];
}


- (void)networkingWithPage:(NSInteger)page
{
    if ([NetWorking netWorkReachability]) {
        [self.constructionSiteTableview.mj_header endRefreshing];
        [self.constructionSiteTableview.mj_footer endRefreshing];
        [SVProgressHUD svprogressHUDWithString:@"请检查网络连接"];
        return;
    }

    
    NSString *selfid;
    [self.info isEqual:nil] ? (selfid = @"-1") : (selfid = self.info[@"id"]);
    ZaiJianGongChengViewModel *zjgcViewModel = [[ZaiJianGongChengViewModel alloc] init];
    [zjgcViewModel getZaiJianGongChengList:selfid type:@3 row:@10 page:@(page) show:@"pic"];
    [zjgcViewModel setBlockWithReturnBlock:^(id data) {
        [self.constructionSiteTableview.mj_header endRefreshing];
        [self.constructionSiteTableview.mj_footer endRefreshing];
        
        if ([data isEqual:DATAISNIL]) {
             _constructionSiteTableview.mj_footer = nil;
        }else{
            if ([data count] < 10) {
                _constructionSiteTableview.mj_footer = nil;
            }else{
                _constructionSiteTableview.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullOnLoading:)];
            }
            if (isPullOnLoading) {
                [listData addObjectsFromArray:data];
            }else{
                listData = [NSMutableArray arrayWithArray:data];
            }
        }
        [_constructionSiteTableview reloadData];
        
    } WithErrorBlock:^(id errorCode) {
        [self.constructionSiteTableview.mj_header endRefreshing];
        [self.constructionSiteTableview.mj_footer endRefreshing];
        [SVProgressHUD svprogressHUDWithString:@"请检查网络连接"];
    } WithFailureBlock:^{
        [self.constructionSiteTableview.mj_header endRefreshing];
        [self.constructionSiteTableview.mj_footer endRefreshing];
        [SVProgressHUD svprogressHUDWithString:@"请检查网络连接"];
    }];
}


#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (listData.count == 0) {
        return 1;
    }
    return [listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (listData.count == 0) {
        NoDataCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nodatacell"];
        cell.discriptionString = @"暂无工程，敬请期待";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    ConstructionSiteCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"constructionsCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellInfo:listData[indexPath.row]];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (listData.count == 0) {
        return SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT;
    }
    return 155;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (listData.count != 0) {
        ZaiJianGongChengModel *model = listData[indexPath.row];
        NSString *linkid;
        linkid = [NSString stringWithFormat:@"%@", model.link_id];
        if (![linkid hasPrefix:@"http"]) {
            linkid = [NSString stringWithFormat:@"%@%@", ADVIMAGE_URL, model.link_id];
        }
        ConstructionSiteDetailViewController *webVC = [[ConstructionSiteDetailViewController alloc] init];
        webVC.url = linkid;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}


#pragma  mark - process
- (void)processbutton:(UIButton *)sender
{
//    NSLog(@"ffffffffffffffffffffffffffff");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
