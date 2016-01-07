//
//  CitiPositioningViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/11/19.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "CitiPositioningViewController.h"
#import "CityTableViewCell.h"
#import "CityViewModel.h"
#import "CityModel.h"



@interface CitiPositioningViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *city;
    NSMutableArray *flagChooseArr;
    NSString *currentCityName;
    BOOL reloaction;
    NSArray *UserDefaultCitiNameArr;
    
    BOOL netWorkReachability;//是否连接网络
}

@property (nonatomic, strong)UITableView *cityList;


@end

@implementation CitiPositioningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"城市定位";
    netWorkReachability = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityListRequest) name:NOTIFICATION_CITY object:nil];
    
    
    UserDefaultCitiNameArr = [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:CITY_LIST]];
    flagChooseArr = [NSMutableArray array];
    currentCityName = [UserInfo shareUserInfo].currentCityName;
    
    [self cityListRequest];
    
    //添加城市列表
    [self.view addSubview:self.cityList];
}


- (void)cityListRequest
{
    if ([NetWorking netWorkReachability]) {
        netWorkReachability = NO;
        [self.cityList.mj_header endRefreshing];
        [SVProgressHUD svprogressHUDWithString:@"请检查网络连接"];
        return;
    }
    
    [SVProgressHUD show];
    CityViewModel *cityViewModel = [[CityViewModel alloc] init];
    [cityViewModel getCityList];
    [cityViewModel setBlockWithReturnBlock:^(id data) {
        [SVProgressHUD dismiss];
        //定位城市名称
        city = [NSArray arrayWithArray:data];
                
        //遍历城市列表 找出城市列表中与定位城市相同，则为选中状态 为1 否则为0
        for (int i = 0; i < [city count]; i ++) {
            NSString *str = ((CityModel *)data[i]).cityName;
            
            if ([str isEqualToString:currentCityName]) {
                [flagChooseArr addObject:@(1)];
                NSInteger cityid = [((CityModel *)data[i]).number integerValue];
                [UserInfo shareUserInfo].cityID = cityid;
            }
            [flagChooseArr addObject:@(0)];
        }
        [self.cityList reloadData];
    } WithErrorBlock:^(id errorCode) {
        [SVProgressHUD dismiss];
    } WithFailureBlock:^{
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - UI

- (UIView *)headerView
{
    UIView *headerView = [[UIView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, 80)];
    return headerView;
}

- (UITableView *)cityList{
    if (_cityList == nil) {
        _cityList = [[UITableView alloc] initWithFrame:RECT(00, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
        _cityList.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _cityList.delegate = self;
        _cityList.dataSource = self;
        _cityList.showsVerticalScrollIndicator = NO;
        [_cityList registerClass:[CityTableViewCell class] forCellReuseIdentifier:@"citycell"];
        _cityList.tableFooterView = [[UIView alloc] init];
    }
    return _cityList;
}

#pragma mark - <UITabelViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section == 0) {
        return 1;
    }else{
        if ((city == [NSNull null]) || (city == nil) || (city.count == 0)) {
            return UserDefaultCitiNameArr.count;
        }
        return [city count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"systemcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (city != nil) {
        if (indexPath.section == 0) {
            NSString *kCityName = [UserInfo shareUserInfo].kCityName;
            currentCityName = [UserInfo shareUserInfo].currentCityName;
        cell.textLabel.text = kCityName;
            if ([kCityName isEqualToString:@"(null"] || (currentCityName == nil)) {
                    cell.textLabel.text = @"重新定位";
                reloaction = YES;
            }else{
                reloaction = NO;
            }
        }else{
            cell.textLabel.text = ((CityModel *)city[indexPath.row]).cityName;
            if (indexPath.section == 1) {
                cell.editing = [flagChooseArr[indexPath.row] boolValue];
                if (cell.editing) {
                    //自定义accesstype
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                    UIButton *accessoryBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
                    [accessoryBtn setImage:[UIImage imageNamed:@"city_xuanze"] forState:UIControlStateNormal];
                    [view addSubview:accessoryBtn];
                    [cell setAccessoryView:view];
                }else{
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    [cell setAccessoryView:nil];
                }
            }
        }
    }else{
        indexPath.section == 0 ? (cell.textLabel.text = @"重新定位") : (cell.textLabel.text = UserDefaultCitiNameArr[indexPath.row]);
        reloaction = YES;
    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *backgView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, 40)];
    backgView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];

    UIImageView *mapImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"city_diqu"]];
    mapImage.frame = RECT(30, 5, 25, 30);
    [backgView addSubview:mapImage];
    
    UILabel *label = [[UILabel alloc] initWithFrame:RECT(ORIGIN_X_ADD_SIZE_W(mapImage) + 20, 5, SCREEN_WIDTH / 2, 30)];
    section == 0 ? (label.text = @"定位城市") : (label.text = @"已开通服务的城市");
    label.textColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
    label.textAlignment = NSTextAlignmentLeft;
    [backgView addSubview:label];
    
    return backgView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (reloaction) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RELOCATION object:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        //把选中的cell的edting状态修改为yes 其他的置为no
        [flagChooseArr removeAllObjects];
        for (int i = 0; i < [city count]; i ++) {
            [flagChooseArr addObject:@(0)];
        }
        
        [flagChooseArr replaceObjectAtIndex:indexPath.row withObject:@(1)];
        [tableView reloadData];
        
        CityModel *model = city[indexPath.row];
        [UserInfo shareUserInfo].currentCityName = model.cityName;
        [UserInfo shareUserInfo].cityID = [model.number integerValue];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CITY object:[UserInfo shareUserInfo].currentCityName];
        [self.navigationController popViewControllerAnimated:YES];
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
