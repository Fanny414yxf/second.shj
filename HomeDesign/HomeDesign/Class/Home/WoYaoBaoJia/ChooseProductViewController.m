//
//  ChooseProductViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/18.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "ChooseProductViewController.h"
#import "ChooseProductCell.h"
#import "ProducrDetailViewController.h"
#import "ProductListViewModel.h"
#import "ProductListMModel.h"

static NSString *identify = @"productcell";

@interface ChooseProductViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger currenPage;
    NSArray *listArr;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ChooseProductViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self networkingWithPage:currenPage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  self.titleLabel.text = @"选择产品";
    currenPage = 1;
    listArr = [NSArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableHeaderView = [[UIView alloc] init];
    [_tableView registerClass:[ChooseProductCell class] forCellReuseIdentifier:identify];
    [self.view addSubview:_tableView];
    _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDownRefresh)];
    _tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullOnLoading:)];
    [_tableView.mj_header beginRefreshing];
}

//下拉刷新
- (void)dropDownRefresh
{
    currenPage = 1;
    [self networkingWithPage:currenPage];
    
}
//上拉加载
- (void)pullOnLoading:(NSInteger)page
{
    currenPage ++;
    [self networkingWithPage:currenPage];
}

- (void)networkingWithPage:(NSInteger)page
{
    ProductListViewModel *viewModle = [[ProductListViewModel alloc] init];
    [viewModle getProductListWithType:3 DI:self.selfid show:@"jia"];
    [viewModle setBlockWithReturnBlock:^(id data) {
        [_tableView.mj_header endRefreshing];
        if ([data isEqualToString:DATAISNIL]) {
            [SVProgressHUD svprogressHUDWithString:@"暂无产品"];
            return ;
        }
        [_tableView reloadData];
        listArr = [NSArray arrayWithArray:data];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell handleShowDetailBtn:^(NSInteger tag) {
        NSLog(@"FDFGDFHGFGDDDDDDDDDDD");
        
        ProducrDetailViewController *productDetailVC = [[ProducrDetailViewController alloc] init];
        productDetailVC.url = ZAIXIANYUYUE_HTML;
        [self.navigationController pushViewController:productDetailVC animated:YES];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductListMModel *model = listArr[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CHOOSEPRODUCT object:model];
    [self.navigationController popViewControllerAnimated:YES];
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
