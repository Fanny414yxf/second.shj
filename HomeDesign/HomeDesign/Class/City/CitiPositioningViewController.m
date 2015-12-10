//
//  CitiPositioningViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/11/19.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "CitiPositioningViewController.h"
#import "CityTableViewCell.h"
#import <CoreLocation/CoreLocation.h>



@interface CitiPositioningViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *city;
    NSMutableArray *flagChooseArr;
}

@property (nonatomic, strong)UITableView *cityList;


@end

@implementation CitiPositioningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"城市定位";
    
    city = @[@"北京", @"上海", @"深圳", @"丹麦", @"莫斯科",@"深圳", @"丹麦", @"莫斯科"];
    flagChooseArr = [NSMutableArray array];
    for (int i = 0; i < [city count]; i ++) {
        [flagChooseArr addObject:@(0)];
    }
    
    [self.view addSubview:self.cityList];
   
}

#pragma mark - UI

- (UITableView *)cityList{
    if (_cityList == nil) {
        _cityList = [[UITableView alloc] initWithFrame:RECT(00, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
        _cityList.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _cityList.delegate = self;
        _cityList.dataSource = self;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *identify = @"systemcell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
    cell.textLabel.text = city[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        cell.editing = [flagChooseArr[indexPath.row] boolValue];
        if (cell.editing) {
            //自定义accesstype
            cell.accessoryType = UITableViewCellAccessoryNone;
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            UIButton *accessoryBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            [accessoryBtn setImage:[UIImage imageNamed:@"city_xuanze"] forState:UIControlStateNormal];
            [view addSubview:accessoryBtn];
            [cell setAccessoryView:view];
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell setAccessoryView:nil];
        }
    }
        return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *backgView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, 40)];
    backgView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];

    UIImageView *mapImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"city_diqu"]];
    mapImage.frame = RECT(30, 5, 30, 30);
    [backgView addSubview:mapImage];
    
    UILabel *label = [[UILabel alloc] initWithFrame:RECT(ORIGIN_X_ADD_SIZE_W(mapImage) + 20, 5, 100, 30)];
    section == 0 ? (label.text = @"定位城市") : (label.text = @"已开通服务的城市");
    label.textColor = [UIColor greenColor];
    label.textAlignment = NSTextAlignmentLeft;
    [backgView addSubview:label];
    
    return backgView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //把选中的cell的edting状态修改为yes 其他的置为no
    [flagChooseArr removeAllObjects];
    for (int i = 0; i < [city count]; i ++) {
        [flagChooseArr addObject:@(0)];
    }
    [flagChooseArr replaceObjectAtIndex:indexPath.row withObject:@(1)];
    [tableView reloadData];
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
