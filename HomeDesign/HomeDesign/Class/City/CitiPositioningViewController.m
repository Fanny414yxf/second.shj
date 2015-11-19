//
//  CitiPositioningViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/11/19.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "CitiPositioningViewController.h"

@interface CitiPositioningViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *city;
}

@property (nonatomic, strong)UITableView *cityList;


@end

@implementation CitiPositioningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    city = @[@"北京", @"上海", @"深圳", @"丹麦", @"莫斯科",@"深圳", @"丹麦", @"莫斯科"];
    
    [self.view addSubview:self.cityList];

}

#pragma mark - UI

- (UITableView *)cityList{
    if (_cityList == nil) {
        _cityList = [[UITableView alloc] initWithFrame:RECT(00, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
        _cityList.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _cityList.delegate = self;
        _cityList.dataSource = self;
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
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = city[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *backgView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, 44)];
    backgView.backgroundColor = [UIColor whiteColor];

    UIImageView *mapImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"diqu"]];
    mapImage.frame = RECT(30, 5, 30, 30);
    [backgView addSubview:mapImage];
    
    UILabel *label = [[UILabel alloc] initWithFrame:RECT(ORIGIN_X_ADD_SIZE_W(mapImage) + 20, 5, 100, 30)];
    label.text = @"成都";
    label.textColor = [UIColor greenColor];
    label.textAlignment = NSTextAlignmentLeft;
    [backgView addSubview:label];
    
    return backgView;
    
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
