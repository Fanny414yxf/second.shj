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
    NSArray *listDataArr;
    
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HopShopingViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self networking];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"嗨款";
   
    UIView *header = [self tabelViewHeader];
    
    _tableView = [[UITableView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[HotShopTableViewCell class] forCellReuseIdentifier:@"haikuancell"];
    [self.view addSubview:_tableView];
//    _tableView.tableHeaderView = header;
    _tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        
    }];
    _tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
    }];
}


- (void)networking
{
    [SVProgressHUD showInfoWithStatus:@"加载中"];

    NSString *selfid = self.info[@"id"];
    HaiKuanViewModel *haikuan = [[HaiKuanViewModel alloc] init];
    [haikuan getHaiKuanListWithCityID:selfid type:@3 row:@10 page:@1 show:@"hai"];
    
    [haikuan setBlockWithReturnBlock:^(id data) {
        
        listDataArr = [NSArray arrayWithArray:data];
        [_tableView reloadData];
        
        [SVProgressHUD dismiss];
    } WithErrorBlock:^(id errorCode) {
        [SVProgressHUD dismiss];
    } WithFailureBlock:^{
        [SVProgressHUD dismiss];
    }];
    
}

- (UIView *)tabelViewHeader
{
    UIView *tabelHeaderView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, 250)];
    shopImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"linbaozhuangplus_header"]];
    shopImage.frame = RECT(0, 5, SCREEN_WIDTH, 200);
    shopImage.contentMode = UIViewContentModeScaleAspectFit;
    [tabelHeaderView addSubview:shopImage];
    
    UIView *discreptionBg = [[UIView alloc] initWithFrame:RECT(0, ORIGIN_Y_ADD_SIZE_H(shopImage), SCREEN_WIDTH, 40)];
    discreptionBg.backgroundColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
    [tabelHeaderView addSubview:discreptionBg];
    
    shopDiscreptionLabel = [[UILabel alloc] initWithFrame:RECT(20, 0, SCREEN_WIDTH - 20, 40) textAlignment:NSTextAlignmentLeft font:FONT(14) textColor:[UIColor whiteColor]];
    shopDiscreptionLabel.text = @"5周年珍藏版， 黄金性价比飙升";
    [discreptionBg addSubview:shopDiscreptionLabel];
    
    UIImageView *timebg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"haikuan_flgbg_time"]];
    timebg.frame = RECT(SCREEN_WIDTH - 100, 20, 100, 25);
    timebg.contentMode = UIViewContentModeScaleAspectFit;
    [tabelHeaderView addSubview:timebg];
    
    NSArray *arr = @[@"0", @"0", @":", @"1", @"2", @":", @"4", @"6"];
    UILabel *label = [[UILabel alloc] initWithFrame:RECT(0, -2, 100, 25) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor whiteColor]];
    [timebg addSubview:label];
    
    for (NSInteger i = 0; i < 8; i ++) {
        discreptionBg.backgroundColor = [RGBColor colorWithHexString:@"#e0e0e0"];
        UILabel *time = [[UILabel alloc] initWithFrame:RECT(10 + i * 11, 7.5, 10, 15) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor whiteColor]];
        time.text = [NSString stringWithFormat:@"%@", arr[i]];
        if (i == 2 || i == 5) {
            time.backgroundColor = [UIColor clearColor];
        }else{
            time.backgroundColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
        }
        [label addSubview:time];
    }

    return tabelHeaderView;
}


#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listDataArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"haikuancell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellInfo:listDataArr[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HaikuanModel *kaikuanModel = listDataArr[indexPath.row];
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.titleString = [NSString stringWithFormat:@"%@", kaikuanModel.descriptionStr];
    webVC.url = [NSString stringWithFormat:@"%@%@",ADVIMAGE_URL, kaikuanModel.link_id];
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
