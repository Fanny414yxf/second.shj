//
//  HopShopingViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/7.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "HopShopingViewController.h"
#import "HotShopTableViewCell.h"
#import "HaiKuanViewModel.h"


@interface HopShopingViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIImageView *shopImage;
    UILabel *shopDiscreptionLabel;
    NSMutableArray *listDataArr;
    
    NSInteger currenPage;//当前请求页面
    BOOL isPullOnLoading;//是否为上拉加载
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HopShopingViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self networkingWithPage:currenPage];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"嗨款";
    currenPage = 1;
    isPullOnLoading = NO;
    listDataArr = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[HotShopTableViewCell class] forCellReuseIdentifier:@"haikuancell"];
    [_tableView registerClass:[NoDataCellTableViewCell class] forCellReuseIdentifier:@"nodatacell"];
    [self.view addSubview:_tableView];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDownRefresh)];
    [_tableView.mj_header beginRefreshing];

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
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD svprogressHUDWithString:@"请检查网络连接"];
        return;
    }

    NSString *selfid;
    [self.info isEqual:nil] ? (selfid = @"-1") : (selfid = self.info[@"id"]);
    HaiKuanViewModel *haikuan = [[HaiKuanViewModel alloc] init];
    [haikuan getHaiKuanListWithCityID:selfid type:@3 row:@10 page:@(page) show:@"hai"];
    
    [haikuan setBlockWithReturnBlock:^(id data) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if ([data isEqual:DATAISNIL]) {
            _tableView.mj_footer = nil;
            
        }else{
            if ([data count] < 10) {
                _tableView.mj_footer = nil;
            }else{
                _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullOnLoading:)];
            }
            if (isPullOnLoading) {
                [listDataArr addObjectsFromArray:data];
            }else{
                listDataArr = [NSMutableArray arrayWithArray:data];
            }
        }
        
        [_tableView reloadData];
        
    } WithErrorBlock:^(id errorCode) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD svprogressHUDWithString:@"请检查网络连接"];
    } WithFailureBlock:^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD svprogressHUDWithString:@"请检查网络连接"];
    }];
}



#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (listDataArr.count == 0)  {
        return 1;
    }
    return [listDataArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (listDataArr.count == 0) {
        NoDataCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nodatacell"];
        cell.discriptionString = @"嗨款抢购，敬请期待";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    HotShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"haikuancell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellInfo:listDataArr[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (listDataArr.count == 0) {
        return SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT;
    }
    return 250;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (listDataArr.count != 0) {
        NSString *linkUrl;
        HaikuanModel *kaikuanModel = listDataArr[indexPath.row];
        linkUrl = [NSString stringWithFormat:@"%@", kaikuanModel.link_id];
        if (![linkUrl hasPrefix:@"http"]) {
            linkUrl = [NSString stringWithFormat:@"%@%@", ADVIMAGE_URL, kaikuanModel.link_id];
        }
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.titleString = @"详情";
        webVC.url = linkUrl;
        [self.navigationController pushViewController:webVC animated:YES];
    }
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
