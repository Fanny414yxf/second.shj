//
//  ErpriseDynamicViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/25.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "ErpriseDynamicViewController.h"

@interface ErpriseDynamicViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger currenPage;
    NSMutableArray *listData;
}


@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ErpriseDynamicViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self networkingWithQuestionType:3 page:currenPage row:10];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"企业动态";
    currenPage = 1;
    listData = [NSMutableArray array];
    
    UIImageView *tableHeader = [[UIImageView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, 150)];
    tableHeader.image = [UIImage imageNamed:@"aboutus_banner.jpg"];
    
    _tableView = [[UITableView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
//    _tableView.backgroundColor = [UIColor colorWithHex:0.9 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.tableHeaderView = tableHeader;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDownRefresh)];
    _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullOnLoading:)];
    [_tableView.mj_header beginRefreshing];
    
}


//下拉刷新
- (void)dropDownRefresh
{
     currenPage = 1;
    [self networkingWithQuestionType:3 page:currenPage row:10];
}
//上拉加载
- (void)pullOnLoading:(NSInteger)page
{
    currenPage ++;
    [self networkingWithQuestionType:3 page:currenPage row:10];
}


- (void)networkingWithQuestionType:(NSInteger)type page:(NSInteger)page row:(NSInteger)row
{
    NSString *selfid = [NSString stringWithFormat:@"%@", self.info[@"id"]];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:selfid forKey:@"id"];
    [param setObject:@(type) forKey:@"type"];
    [param setObject:@(page) forKey:@"page"];
    [param setObject:@(row) forKey:@"row"];
    [NetWorking GetRequeastWithURL:BASE_URL paramDic:param success:^(id data) {
        [_tableView.mj_header endRefreshing];
        if ([data[@"data"] isEqual:[NSNull null]]) {
            [listData removeAllObjects];
        }else{
           listData = [NSMutableArray arrayWithArray:data[@"data"]];
        }
        [_tableView reloadData];
    } errorCode:^(id errorCode) {
        [_tableView.mj_header endRefreshing];
    } fail:^{
        [_tableView.mj_header endRefreshing];
    }];
}


#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSDictionary *info = [NSDictionary dictionaryWithDictionary:listData[indexPath.row]];
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = FONT(14);
    cell.textLabel.attributedText = [self dealWithInfo:info];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}


//cell内容
- (NSMutableAttributedString *)dealWithInfo:(NSDictionary *)info
{
    NSString *timeFormatter = [TimeFormatter longTimeLongStringWithyyyyMMdd:info[@"create_time"]];
    NSString *timeString = [NSString stringWithFormat:@"(%@/%@)", [timeFormatter substringWithRange:NSMakeRange(5, 2)], [timeFormatter substringWithRange:NSMakeRange(8, 2)]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",timeString,info[@"title"]]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 7)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(7, [attributedString length] - 7)];
    return attributedString;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = [NSDictionary dictionaryWithDictionary:listData[indexPath.row]];
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.url = [NSString stringWithFormat:@"%@%@",ADVIMAGE_URL, info[@"link_id"]] ;
    webVC.titleString = [NSString stringWithFormat:@"%@", info[@"title"]];
    [self.navigationController pushViewController:webVC animated:YES];
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
