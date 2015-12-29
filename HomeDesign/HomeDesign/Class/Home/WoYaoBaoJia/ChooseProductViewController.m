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
    NSMutableArray *listArr;
    NoDataView *tipView;
    BOOL isPullOnLoading;//是否为上拉加载
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
    isPullOnLoading = NO;
    listArr = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableHeaderView = [[UIView alloc] init];
    [_tableView registerClass:[ChooseProductCell class] forCellReuseIdentifier:identify];
    [_tableView registerClass:[NoDataCellTableViewCell class] forCellReuseIdentifier:@"nodatacell"];
    [self.view addSubview:_tableView];
    _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDownRefresh)];
    [_tableView.mj_header beginRefreshing];
    
    UIView *topline = [[UIView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, 0.5)];
    topline.backgroundColor = [UIColor colorWithHex:0.9 alpha:0.3];
    [_tableView addSubview:topline];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView    respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    
    tipView  = [[NoDataView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
    tipView.discriptionString = @"暂无产品，敬请期待";
    tipView.hidden = YES;
    [self.view addSubview:tipView];
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
    ProductListViewModel *viewModle = [[ProductListViewModel alloc] init];
    [viewModle getProductListWithType:3 DI:self.selfid show:@"jia"];
    [viewModle setBlockWithReturnBlock:^(id data) {
        [_tableView.mj_header endRefreshing];
        if ([data isEqual:DATAISNIL]) {
            _tableView.mj_footer = nil;
        }else{
            if ([data count] < 10) {
                _tableView.mj_footer = nil;
            }else{
                _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullOnLoading:)];
            }
            if (isPullOnLoading) {
                [listArr addObjectsFromArray:data];
            }else{
                listArr = [NSMutableArray arrayWithArray:data]; 
            }
        }
        
        [_tableView reloadData];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (listArr.count == 0) {
        return 1;
    }
    return [listArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (listArr.count == 0) {
        return SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT;
    }
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (listArr.count == 0) {
        NoDataCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nodatacell"];
        cell.discriptionString = @"暂无产品，敬请期待";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    ProductListMModel *model = listArr[indexPath.row];
    ChooseProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellInfo:model];
    [cell handleShowDetailBtn:^(NSInteger tag) {
        WebViewController *productDetailVC = [[WebViewController alloc] init];
        productDetailVC.url = [NSString stringWithFormat:@"%@%@", ADVIMAGE_URL,model.link_id];
        productDetailVC.titleString = model.title;
        [self.navigationController pushViewController:productDetailVC animated:YES];
    }];
    [cell selectedCell:^{
        ProductListMModel *model = listArr[indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CHOOSEPRODUCT object:model];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    return cell;
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
